//
//  URLRequest+Extentions.swift
//  ImageFeed
//
//  Created by kalmahik on 11.02.2024.
//

import Foundation

extension URLRequest {
    static func makeRequest(
        httpMethod: String? = Methods.get.rawValue,
        path: String, host: String? = NetworkConstants.host,
        queryItems: [URLQueryItem]? = []
    ) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = NetworkConstants.schema
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        var request = URLRequest(url: urlComponents.url ?? NetworkConstants.defaultBaseURL)
        request.httpMethod = httpMethod
        let token = OAuthTokenStorage().token
        if let token {
            request.setValue("\(AuthKeys.bearer) \(token)", forHTTPHeaderField: AuthKeys.authorization.rawValue)
        }
        return request
    }
}
