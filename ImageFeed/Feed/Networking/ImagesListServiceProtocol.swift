//
//  ProfileServiceProtocol.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

protocol ImageListServiceProtocol {
    var networkClient: NetworkClientProtocol { get }

    func fetchPhotosNextPage(completion: @escaping (Result<String, Error>) -> Void)
}
