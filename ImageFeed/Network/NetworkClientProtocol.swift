import Foundation

protocol NetworkClientProtocol {
    func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}
