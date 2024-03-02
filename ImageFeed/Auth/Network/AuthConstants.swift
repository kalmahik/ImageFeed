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
    case client_id, client_secret, redirect_uri, response_type, grant_type, scope, code, authorization_code, Bearer, Authorization
}
