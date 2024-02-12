//
//  URLRequest+Extentions.swift
//  ImageFeed
//
//  Created by kalmahik on 11.02.2024.
//

import Foundation

extension URLRequest {
    static func makeHTTPRequest(path: String, httpMethod: String, baseURL: URL = URL(string: DefaultBaseURL)!) -> URLRequest {
        var request = URLRequest(url: URL(string: path, relativeTo: baseURL)!)
        request.httpMethod = httpMethod
        return request
    }
}

