//
//  Constants.swift
//  ImageFeed
//
//  Created by Murad Azimov on 04.02.2024.
//

import Foundation

struct AuthConstants {
    static let accessKey = "jsR4eJSa8sZwpX4IH0jIha-l-I52ziQiCOtVIWENf6k"
    static let secretKey = "6M0kRYVdL9qadhIOgL5R66WBjrqG72nrJ_hbFuNhStQ"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"

    static let authURL = "https://unsplash.com/oauth/authorize"
    static let tokenPath = "/oauth/token"
    static let hostToken = "unsplash.com"
    static let redirectPath = "/oauth/authorize/native"
}

enum AuthKeys: String {
    case clientID = "client_id"
    case clientSecret = "client_secret"
    case redirectUri = "redirect_uri"
    case responseType = "response_type"
    case grantType = "grant_type"
    case scope = "scope"
    case code = "code"
    case authorizationCode = "authorization_code"
    case bearer = "Bearer"
    case authorization = "Authorization"
}
