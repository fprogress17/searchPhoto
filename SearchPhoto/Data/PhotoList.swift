//
//  PhotoListData.swift
//  SearchPhoto
//
//  Created by Choonghun Lee on 9/23/24.
//

import Foundation

// MARK: - FlickrPhotoList
struct PhotoList: Codable {
    var title: String = ""
    var link: String = ""
    var description: String = ""
    var modified: String = ""
    var generator: String = ""
    var items: [PhotoItem] = []
}

// MARK: - PhotoItem
struct PhotoItem: Codable, Hashable {
    var id = UUID()
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let description: String
    let published: String
    let author: String
    let authorID: String
    let tags: String

    enum CodingKeys: String, CodingKey {
        case title, link, media, description, published, author, tags
        case dateTaken = "date_taken"
        case authorID = "author_id"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PhotoItem, rhs: PhotoItem) -> Bool {
        lhs.id == rhs.id
    }

}

// MARK: - Media
struct Media: Codable {
    let m: String
}
