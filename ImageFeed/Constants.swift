//
//  Constants.swift
//  ImageFeed
//
//  Created by Murad Azimov on 04.02.2024.
//

import Foundation

let AccessKey = "\(ACCESS_KEY)"
let SecretKey = "\(SECRET_KEY)"
let RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
let AccessScope = "public+read_user+write_likes"
let DefaultBaseURL = "https://api.unsplash.com"
let AuthURL = "https://unsplash.com/oauth/authorize"
let TokenURL = "https://unsplash.com/oauth/token"
let RedirectPath = "/oauth/authorize/native"

enum AuthKeys: String {
    case client_id, client_secret, redirect_uri, response_type, grant_type, scope, code, authorization_code
}
