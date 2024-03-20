import Foundation

struct AuthHelper: AuthHelperProtocol {

    func authRequest() -> URLRequest {
        let url = authURL()
        return URLRequest(url: url)
    }

    func authURL() -> URL {
        var urlComponents = URLComponents(string: AuthConstants.authURL) ?? URLComponents()
        urlComponents.queryItems = [
            URLQueryItem(name: AuthKeys.clientID.rawValue, value: AuthConstants.accessKey),
            URLQueryItem(name: AuthKeys.redirectUri.rawValue, value: AuthConstants.redirectURI),
            URLQueryItem(name: AuthKeys.responseType.rawValue, value: AuthKeys.code.rawValue),
            URLQueryItem(name: AuthKeys.scope.rawValue, value: AuthConstants.accessScope)
        ]

        return urlComponents.url ?? NetworkConstants.defaultBaseURL
    }

    func parseCode(from url: URL) -> String? {
        if
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == AuthConstants.redirectPath,
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == AuthKeys.code.rawValue}) {
            return codeItem.value
        } else {
            return nil
        }
    }
}
