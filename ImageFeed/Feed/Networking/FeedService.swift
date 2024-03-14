import Foundation

final class FeedService: FeedServiceProtocol {
    static let shared = FeedService()
    static let didChangeNotification = Notification.Name(rawValue: FeedConstants.didChangeNotification)
    let networkClient: NetworkClientProtocol = NetworkClient()
    var lastLoadedPage = 0

    private init() {}

    private (set) var photos: [Photo] = []

    func fetchFeed() {
        assert(Thread.isMainThread)
        let nextPage = lastLoadedPage + 1
        let queryItems = [
            URLQueryItem(name: FeedConstants.page, value: "\(nextPage)"),
            URLQueryItem(name: FeedConstants.perPage, value: "\(FeedConstants.photosPerPage)")
        ]
        let request = URLRequest.makeRequest(path: FeedConstants.feedPath, queryItems: queryItems)
        networkClient.fetch(urlRequest: request) { [weak self] (result: Result<[PhotoResponse], Error>) in
            guard let self else { return }
            switch result {
            case .failure:
                break
            case .success(let response):
                self.lastLoadedPage = nextPage
                let lastPhotos = response.map { Photo($0) }
                DispatchQueue.main.async {
                    self.photos.append(contentsOf: lastPhotos)
                }
                NotificationCenter.default.post(name: FeedService.didChangeNotification, object: self)
            }
        }
    }

    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Photo, Error>) -> Void) {
        assert(Thread.isMainThread)
        let path = FeedConstants.likePath.replacingOccurrences(of: "id", with: photoId)
        let method = isLike ? HttpMethods.post.rawValue : HttpMethods.delete.rawValue
        let request = URLRequest.makeRequest(httpMethod: method, path: path)
        networkClient.fetch(urlRequest: request) { [weak self] (result: Result<LikeResponse, Error>) in
            guard let self else { return }
            switch result {
            case .failure(let error):
                completion(.failure(error))
                break
            case .success(let response):
                let photo = Photo(response.photo)
                let index = self.photos.firstIndex(where: { $0.id == photoId })
                guard let index else { return }
                DispatchQueue.main.async {
                    self.photos[index] = photo
                }
                completion(.success(photo))
            }
        }
    }

    func cleanData() {
        photos = []
        lastLoadedPage = 0
    }
}
