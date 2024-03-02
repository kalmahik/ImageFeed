//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

struct ProfileResponse: Decodable {
    let id: String
    let username: String
    let firstName: String
    let lastName: String
    let bio: String?
}
