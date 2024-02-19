//
//  OAuthServiceProtocol.swift
//  ImageFeed
//
//  Created by kalmahik on 11.02.2024.
//

import Foundation

protocol OAuthServiceProtocol {
    func fetchAuthToken(code: String, handler: @escaping (Result<String, Error>) -> Void)
}
