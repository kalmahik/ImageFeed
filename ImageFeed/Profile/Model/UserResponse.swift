//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

struct ProfileImage: Decodable {
    let small: String
    let medium: String
    let large: String
}

struct UserResponse: Decodable {
    let profileImage: ProfileImage
}
