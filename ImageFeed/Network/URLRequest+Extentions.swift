//
//  URLRequest+Extentions.swift
//  ImageFeed
//
//  Created by kalmahik on 11.02.2024.
//

import Foundation

extension URLRequest {
    static func makeRequest(httpMethod: String? = "GET", path: String, queryItems: [URLQueryItem]?) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = schema
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        var request = URLRequest(url: urlComponents.url ?? defaultBaseURL)
        request.httpMethod = httpMethod
        return request
    }
}
