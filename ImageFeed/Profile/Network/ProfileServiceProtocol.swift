import Foundation

protocol ProfileServiceProtocol {
    var networkClient: NetworkClientProtocol { get }

    func fetchProfile(completion: @escaping (Result<Profile, Error>) -> Void)
}
