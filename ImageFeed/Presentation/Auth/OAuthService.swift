//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by kalmahik on 11.02.2024.
//

import Foundation

struct OAuthService: OAuthServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchAuthToken(code: String, handler:  @escaping (Result<String, Error>) -> Void) {
        let queryItems = [
            URLQueryItem(name: AuthKeys.client_id.rawValue, value: accessKey),
            URLQueryItem(name: AuthKeys.client_secret.rawValue, value: secretKey),
            URLQueryItem(name: AuthKeys.redirect_uri.rawValue, value: redirectURI),
            URLQueryItem(name: AuthKeys.code.rawValue, value: code),
            URLQueryItem(name: AuthKeys.grant_type.rawValue, value: AuthKeys.authorization_code.rawValue),
        ]
        let request = URLRequest.makeRequest(httpMethod: "POST", path: tokenPath, queryItems: queryItems)
        networkClient.fetch(urlRequest: request) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(OAuthTokenResponse.self, from: data)
                    handler(.success(response.accessToken))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }
}
