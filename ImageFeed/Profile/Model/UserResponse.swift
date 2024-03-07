//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

struct UserResponse: Decodable {
    let profileImage: ProfileImage
}

// MARK: - ProfileImage
struct ProfileImage: Decodable {
    let small: String
    let medium: String
    let large: String
}
