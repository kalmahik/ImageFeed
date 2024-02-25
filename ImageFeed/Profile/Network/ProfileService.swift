//
//  ProfileService.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

private enum ProfileServiceError: Error {
    case invalidRequest
}

final class ProfileService: ProfileServiceProtocol {
    static let shared = ProfileService()
    let networkClient: NetworkClientProtocol = NetworkClient()
    
    private init() {}
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
        var request = URLRequest.makeRequest(path: profileMePath)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") //TODO: remove from here
        networkClient.fetch(urlRequest: request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let profileResponse = try decoder.decode(ProfileResponse.self, from: data)
                    let profile = Profile.convertProfile(profileResponse)
                    completion(.success(profile))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
