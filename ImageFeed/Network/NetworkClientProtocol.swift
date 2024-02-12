import Foundation

protocol NetworkClientProtocol {
    func fetch(urlRequest: URLRequest, handler: @escaping (Result<Data, Error>) -> Void)
}
