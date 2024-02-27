//
//  ProfileService.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

final class ProfileService: ProfileServiceProtocol {
    static let shared = ProfileService()
    let networkClient: NetworkClientProtocol = NetworkClient()
    private (set) var profile: Profile?

    private init() {}
    
    func fetchProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
        let request = URLRequest.makeRequest(path: profileMePath)
        networkClient.fetch(urlRequest: request) { [weak self] (result: Result<ProfileResponse, Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                let profile = Profile.convertProfile(response)
                self?.profile = profile
                completion(.success(profile))
            }
        }
    }
}
