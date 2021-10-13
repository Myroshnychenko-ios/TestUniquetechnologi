//
//  JSONPlaceholder.swift
//  TestUniquetechnologi
//
//  Created by Максим Мирошниченко on 12.10.2021.
//

import Foundation
import RxSwift
import Alamofire
import UIKit

protocol JSONPlaceholderProtocol {
    
    // MARK: - JSONPlaceholder Protocol
    
    func fetchPhotos() -> Observable<[Photo]>
    func downloadPhoto(urlString: String, completion: @escaping (UIImage) -> Void)
    
}

class JSONPlaceholder: JSONPlaceholderProtocol {
    
    func fetchPhotos() -> Observable<[Photo]> {
        let items = PublishSubject<[Photo]>()
        AF.request(DBConstants.url, method: .get, parameters: nil).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                items.onNext(photos)
                items.onCompleted()
            } catch {
                items.onError(error)
            }
        }
        return items
    }
    
    func downloadPhoto(urlString: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }
        AF.download(url).responseData(completionHandler: { (response) in
            guard let data = response.value else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        })
    }
    
}
