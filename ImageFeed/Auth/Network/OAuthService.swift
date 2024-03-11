//
//  OAuthService.swift
//  ImageFeed
//
//  Created by kalmahik on 11.02.2024.
//

import Foundation

private enum OAuthServiceError: Error {
    case invalidRequest
}

final class OAuthService: OAuthServiceProtocol {
    static let shared = OAuthService()
    let networkClient: NetworkClientProtocol = NetworkClient()
    private var lastCode: String?

    private init() {}

    func fetchAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        if lastCode == code {
            print("[imageFeed][fetchAuthToken][\(AuthConstants.tokenPath)]: [the same code]")
            return
        }
        lastCode = code
        let queryItems = [
            URLQueryItem(name: AuthKeys.clientID.rawValue, value: AuthConstants.accessKey[1]),
            URLQueryItem(name: AuthKeys.clientSecret.rawValue, value: AuthConstants.secretKey[1]),
            URLQueryItem(name: AuthKeys.redirectUri.rawValue, value: AuthConstants.redirectURI),
            URLQueryItem(name: AuthKeys.code.rawValue, value: code),
            URLQueryItem(name: AuthKeys.grantType.rawValue, value: AuthKeys.authorizationCode.rawValue)
        ]
        let request = URLRequest.makeRequest(
            httpMethod: Methods.post.rawValue,
            path: AuthConstants.tokenPath,
            host: AuthConstants.hostToken,
            queryItems: queryItems
        )
        networkClient.fetch(urlRequest: request) { [weak self] (result: Result<OAuthTokenResponse, Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response.accessToken))
                self?.lastCode = nil
            }
        }
    }
}
