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
        
        var urlComponents = URLComponents(string: TokenURL)!
        //        urlComponents.scheme = "https"
        //        urlComponents.host = "api.github.com"
        //        urlComponents.path = "/search/repositories"
        urlComponents.queryItems = [
            URLQueryItem(name: AuthKeys.client_id.rawValue, value: AccessKey),
            URLQueryItem(name: AuthKeys.client_secret.rawValue, value: SecretKey),
            URLQueryItem(name: AuthKeys.redirect_uri.rawValue, value: RedirectURI),
            URLQueryItem(name: AuthKeys.code.rawValue, value: AuthKeys.code.rawValue),
            URLQueryItem(name: AuthKeys.grant_type.rawValue, value: AuthKeys.authorization_code.rawValue),
        ]
        guard let url = urlComponents.url else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "get"
        
        let request = authTokenRequest(code: code)
        
        networkClient.fetch(urlRequest: request) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(OAuthTokenResponse.self, from: data)
                    print("-------------", response)
                    handler(.success(response.accessToken))
                } catch {
                    handler(.failure(error))
                }
            }
        }
    }
    
    private func authTokenRequest(code: String) -> URLRequest {
            URLRequest.makeHTTPRequest(
                path: "/oauth/token"
                + "?client_id=\(AccessKey)"
                + "&&client_secret=\(SecretKey)"
                + "&&redirect_uri=\(RedirectURI)"
                + "&&code=\(code)"
                + "&&grant_type=authorization_code",
                httpMethod: "POST",
                baseURL: URL(string: "https://unsplash.com")!
    ) }
}
