import Foundation

extension URLRequest {
    static func makeRequest(
        httpMethod: String? = HttpMethods.get.rawValue,
        path: String, host: String? = NetworkConstants.host,
        queryItems: [URLQueryItem]? = []
    ) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = NetworkConstants.schema
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        var request = URLRequest(url: urlComponents.url ?? NetworkConstants.defaultBaseURL)
        request.httpMethod = httpMethod
        let token = OAuthTokenStorage.shared.token
        if let token {
            request.setValue("\(AuthKeys.bearer.rawValue) \(token)", forHTTPHeaderField: AuthKeys.authorization.rawValue)
        }
        return request
    }
}
