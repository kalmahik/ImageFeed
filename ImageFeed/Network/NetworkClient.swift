import Foundation
import os

private enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}

class NetworkClient: NetworkClientProtocol {
    private weak var task: URLSessionTask?
    private lazy var profileLogoutService = ProfileLogoutService.shared

    func fetch<Response: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<Response, Error>) -> Void) {
        Logger.networkLog(message: "attempt to call", urlRequest: urlRequest)
        if task != nil {
            Logger.networkLog(message: "cancelled", urlRequest: urlRequest)
            task?.cancel()
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let error {
                completion(.failure(error))
                Logger.networkLog(message: error.localizedDescription, urlRequest: urlRequest)
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 403 {
                self?.profileLogoutService.logout()
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(NetworkError.httpStatusCode(response.statusCode)))
                Logger.networkLog(message: "\(response.statusCode)", urlRequest: urlRequest)
                return
            }
            if let data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(Response.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                    Logger.networkLog(message: error.localizedDescription, urlRequest: urlRequest)
                }
                return
            }
            self?.task = nil
        }
        self.task = task
        task.resume()
    }
}
