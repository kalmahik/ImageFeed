//
//  Constants.swift
//  ImageFeed
//
//  Created by Murad Azimov on 04.02.2024.
//

import Foundation

let accessKey = "\(ACCESS_KEY)"
let secretKey = "\(SECRET_KEY)"
let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
let accessScope = "public+read_user+write_likes"
let defaultBaseURL = "https://api.unsplash.com"
let authURL = "https://unsplash.com/oauth/authorize"
let tokenPath = "/oauth/token"
let redirectPath = "/oauth/authorize/native"
let host = "unsplash.com"
let schema = "https"

enum AuthKeys: String {
    case client_id, client_secret, redirect_uri, response_type, grant_type, scope, code, authorization_code
}
