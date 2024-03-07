//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Murad Azimov on 05.03.2024.
//

import Foundation

final class ImagesListService: ImageListServiceProtocol {
    static let shared = ImagesListService()
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    let networkClient: NetworkClientProtocol = NetworkClient()
    let lastLoadedPage = 0

    private init() {}

    private (set) var photos: [Photo] = []

    func fetchPhotosNextPage(completion: @escaping (Result<String, Error>) -> Void) {

        assert(Thread.isMainThread)
        let request = URLRequest.makeRequest(path: ProfileConstants.profileMePath)
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

        let nextPage = (lastLoadedPage) + 1

    }
}
