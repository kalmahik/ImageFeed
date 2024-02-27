//
//  ProfileServiceProtocol.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

protocol ProfileImageServiceProtocol {
    var networkClient: NetworkClientProtocol { get }

    func fetchProfileImageURL(username: String, completion: @escaping (Result<String, Error>) -> Void)
}
