import Foundation

protocol OAuthTokenStorageProtocol {
    var token: String? { get }
    func storeToken(token: String)
}
