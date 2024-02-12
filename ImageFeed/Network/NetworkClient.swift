import Foundation

struct NetworkClient: NetworkClientProtocol {    
    private enum NetworkError: Error {
        case httpStatusCode(Int)
        case urlRequestError(Error)
        case urlSessionError
    }

    func fetch(urlRequest: URLRequest, handler: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                handler(.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.httpStatusCode(response.statusCode)))
                return
            }
            if let data {
                handler(.success(data))
                return
            }
        }
        task.resume()
    }
}
