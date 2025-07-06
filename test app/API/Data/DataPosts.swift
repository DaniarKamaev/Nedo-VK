//
//  DataPosts.swift
//  test app
//
//  Created by dany on 04.07.2025.
//

import Foundation


// MARK: - ArtistElement
struct Post: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
