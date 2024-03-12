import Foundation
import Kingfisher

class KingfisherTokenPlugin: ImageDownloadRequestModifier {
    private let token = OAuthTokenStorage().token

    func modified(for request: URLRequest) -> URLRequest? {
        var request = request
        if let token {
            request.setValue("\(AuthKeys.bearer.rawValue) \(token)", forHTTPHeaderField: AuthKeys.authorization.rawValue)
        }
        return request
    }
}
