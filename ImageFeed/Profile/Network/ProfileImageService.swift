//
//  ProfileService.swift
//  ImageFeed
//
//  Created by kalmahik on 25.02.2024.
//

import Foundation

final class ProfileImageService: ProfileImageServiceProtocol {
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    let networkClient: NetworkClientProtocol = NetworkClient()
    private (set) var profileImageURL: String?
    
    
    private init() {}
    
    func fetchProfileImageURL(username: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        let request = URLRequest.makeRequest(path: "\(userPath)\(username)")
        networkClient.fetch(urlRequest: request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let profileResponse = try decoder.decode(UserResponse.self, from: data)
                    let profileImageURL = profileResponse.profileImage.small
                    self.profileImageURL = profileImageURL
                    completion(.success(profileImageURL))
                    NotificationCenter.default.post(
                        name: ProfileImageService.didChangeNotification,
                        object: self,
                        userInfo: ["URL": profileImageURL])
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
