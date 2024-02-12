import Foundation

struct NetworkClient: NetworkClientProtocol {
    private enum NetworkError: Error {
        case codeError
    }

    func fetch(urlRequest: URLRequest, handler: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                handler(.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode < 200 || response.statusCode >= 300 {
                handler(.failure(NetworkError.codeError))
                return
            }
            guard let data else { return }
            handler(.success(data))
        }
        task.resume()
    }
}
