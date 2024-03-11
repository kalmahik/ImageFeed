//
//  LikeResponse.swift
//  ImageFeed
//
//  Created by Murad Azimov on 10.03.2024.
//

import Foundation

// MARK: - LikeResponse
struct LikeResponse: Decodable {
    let photo: PhotoResponse
    let user: User
}
