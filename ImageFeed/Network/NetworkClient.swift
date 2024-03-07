import Foundation

private enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}

class NetworkClient: NetworkClientProtocol {
    private weak var task: URLSessionTask?

    func fetch<Response: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<Response, Error>) -> Void) {
        if task != nil {
            task?.cancel()
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let error {
                completion(.failure(error))
                print("[imageFeed][fetch][\(urlRequest.url ?? NetworkConstants.defaultBaseURL)]: [\(error)]")
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(NetworkError.httpStatusCode(response.statusCode)))
                print("[imageFeed][fetch][\(urlRequest.url ?? NetworkConstants.defaultBaseURL)]: [\(response.statusCode)]")
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
                    print("[imageFeed][fetch][\(urlRequest.url ?? NetworkConstants.defaultBaseURL)]: [\(error)]")
                }
                return
            }
            self?.task = nil
        }
        self.task = task
        task.resume()
    }
}
