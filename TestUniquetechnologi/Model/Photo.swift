//
//  Photo.swift
//  TestUniquetechnologi
//
//  Created by Максим Мирошниченко on 12.10.2021.
//

import Foundation

struct Photo: Decodable {
    
    // MARK: - Photo data model
    
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
}
