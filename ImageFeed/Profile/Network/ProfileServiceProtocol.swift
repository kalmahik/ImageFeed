//
//  ProfileServiceProtocol.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

protocol ProfileServiceProtocol {
    var networkClient: NetworkClientProtocol { get }

    func fetchProfile(completion: @escaping (Result<Profile, Error>) -> Void)
}
