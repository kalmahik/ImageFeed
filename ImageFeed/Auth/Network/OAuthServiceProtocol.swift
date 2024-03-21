import Foundation

protocol OAuthServiceProtocol {
    var networkClient: NetworkClientProtocol { get }

    func fetchAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void)
}
