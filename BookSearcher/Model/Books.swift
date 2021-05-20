//
//  Books.swift
//  BookSearcher
//
//  Created by Akhmad Talatov on 18/05/21.
//

import Foundation


struct Books: Codable {
    let kind: String
    let totalItems: Int
    let items: [Book]
}

struct Book: Codable {
    let kind: String
    let id: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
}

struct ImageLinks: Codable {
    let smallThumbnail: String
    let thumbnail: String
}
