import Foundation

private enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}

class NetworkClient: NetworkClientProtocol {
    private weak var task: URLSessionTask?
    private lazy var profileLogoutService = ProfileLogoutService.shared

    func fetch<Response: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<Response, Error>) -> Void) {
        print("[imageFeed][fetch][\(urlRequest.httpMethod ?? "")][\(urlRequest.url ?? NetworkConstants.defaultBaseURL)]: [attempt to call]")
        if task != nil {
            print("[imageFeed][fetch][\(urlRequest.httpMethod ?? "")][\(urlRequest.url ?? NetworkConstants.defaultBaseURL)]: [cancelled]")
            task?.cancel()
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let error {
                completion(.failure(error))
                print("[imageFeed][fetch][\(urlRequest.httpMethod ?? "")][\(urlRequest.url ?? NetworkConstants.defaultBaseURL)]: [\(error.localizedDescription)]")
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 403 {
                self?.profileLogoutService.logout()
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(NetworkError.httpStatusCode(response.statusCode)))
                print("[imageFeed][fetch][\(urlRequest.httpMethod ?? "")][\(urlRequest.url ?? NetworkConstants.defaultBaseURL)]: [\(response.statusCode)]")
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
                    print("[imageFeed][fetch][\(urlRequest.httpMethod ?? "")][\(urlRequest.url ?? NetworkConstants.defaultBaseURL)]: [\(error.localizedDescription)]")
                }
                return
            }
            self?.task = nil
        }
        self.task = task
        task.resume()
    }
}
