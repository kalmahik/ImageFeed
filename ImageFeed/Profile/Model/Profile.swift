//
//  Profile.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String

    static func convertProfile(_ profileResponse: ProfileResponse) -> Profile {
        Profile(
            username: profileResponse.username,
            name: "\(profileResponse.firstName ?? "") \(profileResponse.lastName ?? "")",
            loginName: "@\(profileResponse.username)",
            bio: profileResponse.bio ?? ""
        )
    }
}
