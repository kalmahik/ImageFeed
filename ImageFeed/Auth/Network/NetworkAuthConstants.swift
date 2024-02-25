//
//  Constants.swift
//  ImageFeed
//
//  Created by Murad Azimov on 04.02.2024.
//

import Foundation

let accessKey = "jsR4eJSa8sZwpX4IH0jIha-l-I52ziQiCOtVIWENf6k"
let secretKey = "6M0kRYVdL9qadhIOgL5R66WBjrqG72nrJ_hbFuNhStQ"
let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
let accessScope = "public+read_user+write_likes"

let authURL = "https://unsplash.com/oauth/authorize"
let tokenPath = "/oauth/token"
let hostToken = "unsplash.com"
let redirectPath = "/oauth/authorize/native"

enum AuthKeys: String {
    case client_id, client_secret, redirect_uri, response_type, grant_type, scope, code, authorization_code
}
