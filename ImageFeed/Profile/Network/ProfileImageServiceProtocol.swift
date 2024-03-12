import Foundation

protocol ProfileImageServiceProtocol {
    var networkClient: NetworkClientProtocol { get }

    func fetchProfileImageURL(username: String, completion: @escaping (Result<String, Error>) -> Void)
}
