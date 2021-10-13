//
//  ViewController.swift
//  TestUniquetechnologi
//
//  Created by Максим Мирошниченко on 12.10.2021.
//

import UIKit
import RxSwift
import RxCocoa

class PhotosViewController: UIViewController {
    
    // MARK: - Variables
    
    private let jSONPlaceholder = JSONPlaceholder()
    private let disposeBag = DisposeBag()
    private var photos: Observable<[Photo]>?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushDetailViewController" {
            guard let detailViewController = segue.destination as? DetailViewController else { return }
            guard let photo = sender as? Photo else { return }
            print(photo)
            detailViewController.jSONPlaceholder = self.jSONPlaceholder
            detailViewController.photo = photo
        }
    }
    
    // MARK: - Helpers
    
    private func configure() {
        configureTableView()
        bindTableView()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: PhotoTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PhotoTableViewCell.identifier)
    }
    
    private func bindTableView() {
        photos = jSONPlaceholder.fetchPhotos()
        photos?.bind(to: tableView.rx.items(cellIdentifier: PhotoTableViewCell.identifier, cellType: PhotoTableViewCell.self)) { (row, photo, cell) in
            cell.configure(photo: photo, jSONPlaceholder: self.jSONPlaceholder)
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected(Photo.self).subscribe(onNext: { photo in
            self.performSegue(withIdentifier: "pushDetailViewController", sender: photo)
        }).disposed(by: disposeBag)
    }

}
