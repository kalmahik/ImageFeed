//
//  OAuthTokenResponse.swift
//  ImageFeed
//
//  Created by kalmahik on 11.02.2024.
//

import Foundation


struct OAuthTokenResponse: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case createdAt = "created_at"
    }
}



