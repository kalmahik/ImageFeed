//
//  OAuthServiceProtocol.swift
//  ImageFeed
//
//  Created by kalmahik on 11.02.2024.
//

import Foundation

protocol OAuthServiceProtocol {
    var networkClient: NetworkClientProtocol { get }

    func fetchAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void)
}
