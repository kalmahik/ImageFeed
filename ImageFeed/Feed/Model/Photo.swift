//
//  Photo.swift
//  ImageFeed
//
//  Created by Murad Azimov on 05.03.2024.
//

import Foundation

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool

    // Может лучше сделать инит?
    static func convertPhoto(_ photoResponse: PhotoResponse) -> Photo {
        Photo(
            id: photoResponse.id,
            size: CGSize(width: photoResponse.width, height: photoResponse.height),
            createdAt: photoResponse.createdAt,
            welcomeDescription: photoResponse.description,
            thumbImageURL: photoResponse.urls.thumb,
            largeImageURL: photoResponse.urls.full,
            isLiked: photoResponse.likedByUser
        )
    }
}
