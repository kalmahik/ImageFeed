import Foundation

final class ProfileImageService: ProfileImageServiceProtocol {
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: ProfileConstants.didChangeNotification)
    let networkClient: NetworkClientProtocol = NetworkClient()
    private (set) var profileImageURL: String?

    private init() {}

    func fetchProfileImageURL(username: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        let request = URLRequest.makeRequest(path: "\(ProfileConstants.userPath)\(username)")
        networkClient.fetch(urlRequest: request) { [weak self] (result: Result<UserResponse, Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                let profileImageURL = response.profileImage.medium
                self?.profileImageURL = profileImageURL
                NotificationCenter.default.post(
                    name: ProfileImageService.didChangeNotification,
                    object: self,
                    userInfo: [ProfileConstants.url: profileImageURL])
                completion(.success(profileImageURL))
            }
        }
    }
}
