import Foundation

class OAuthTokenStorage: OAuthTokenStorageProtocol {
    private let userDefaults = UserDefaults.standard
    
    private enum KeysToStore: String {
        case token
    }
    
    var token: String? {
        get { userDefaults.string(forKey: KeysToStore.token.rawValue) }
    }
    
    func storeToken(token: String) {
        userDefaults.set(token, forKey: KeysToStore.token.rawValue)
    }
}
