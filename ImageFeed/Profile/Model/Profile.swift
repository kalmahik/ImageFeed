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
    
    static func convertProfile(_ profileResult: ProfileResponse) -> Profile{
        return Profile(
            username: profileResult.username,
            name: "\(profileResult.firstName ?? "") \(profileResult.lastName ?? "")" ,
            loginName: "@\(profileResult.username)",
            bio: profileResult.bio ?? ""
        )
    }
}
