//
//  Constants.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

struct NetworkConstants {
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")!
    static let host = "api.unsplash.com"
    static let schema = "https"
}

enum Methods: String {
    case POST, GET
}
