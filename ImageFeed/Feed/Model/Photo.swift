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

    init(id: String, size: CGSize, createdAt: Date?, welcomeDescription: String?, thumbImageURL: String, largeImageURL: String, isLiked: Bool) {
        self.id = id
        self.size = size
        self.createdAt = createdAt
        self.welcomeDescription = welcomeDescription
        self.thumbImageURL = thumbImageURL
        self.largeImageURL = largeImageURL
        self.isLiked = isLiked
    }

    init(_ photoResponse: PhotoResponse) {
        self.id = photoResponse.id
        self.size = CGSize(width: photoResponse.width, height: photoResponse.height)
        self.createdAt = photoResponse.createdAt
        self.welcomeDescription = photoResponse.description
        self.thumbImageURL = photoResponse.urls.thumb
        self.largeImageURL = photoResponse.urls.full
        self.isLiked =  photoResponse.likedByUser
    }
}
