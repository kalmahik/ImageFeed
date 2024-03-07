//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Murad Azimov on 05.03.2024.
//

import Foundation

final class FeedService: FeedServiceProtocol {
    static let shared = FeedService()
    static let didChangeNotification = Notification.Name(rawValue: FeedConstants.notifyDataLoaded)
    let networkClient: NetworkClientProtocol = NetworkClient()
    let lastLoadedPage = 0

    private init() {}

    private (set) var photos: [Photo] = []

    func fetchFeed(completion: @escaping (Result<[Photo], Error>) -> Void) {
        assert(Thread.isMainThread)
        let nextPage = (lastLoadedPage) + 1
        let queryItems = [
            URLQueryItem(name: FeedConstants.page, value: "\(nextPage)"),
            URLQueryItem(name: FeedConstants.perPage, value: "10")
        ]
        let request = URLRequest.makeRequest(path: FeedConstants.feedPath, queryItems: queryItems)
        networkClient.fetch(urlRequest: request) { [weak self] (result: Result<[PhotoResponse], Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                let lastPhotos = response.map { Photo.convertPhoto($0) }
                DispatchQueue.main.async { [weak self] in
                    self?.photos.append(contentsOf: lastPhotos)
                }
                NotificationCenter.default.post(
                    name: FeedService.didChangeNotification,
                    object: self,
                    userInfo: ["photos": self?.photos ?? []])
                completion(.success(self?.photos ?? []))
            }
        }
    }
}
