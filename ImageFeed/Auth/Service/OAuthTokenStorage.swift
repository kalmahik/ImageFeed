import Foundation
import SwiftKeychainWrapper

class OAuthTokenStorage: OAuthTokenStorageProtocol {
    static let shared = OAuthTokenStorage()
    private let keychain = KeychainWrapper.standard

    private enum KeysToStore: String {
        case token
    }

    private init() {}

    var token: String? {
        keychain.string(forKey: KeysToStore.token.rawValue)
    }

    func storeToken(token: String?) {
        guard let token else {
            keychain.removeObject(forKey: KeysToStore.token.rawValue)
            return
        }
        keychain.set(token, forKey: KeysToStore.token.rawValue)
    }
}
