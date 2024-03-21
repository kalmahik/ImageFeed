import Foundation
import Kingfisher
import WebKit

final class ProfileLogoutService {
    static let shared = ProfileLogoutService()

    private let oAuthService = OAuthService.shared
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let storage = OAuthTokenStorage.shared
    private let feedService = FeedService.shared

    private init() {}

    func logout() {
        cleanCookies()
        cleanToken()
        cleanUserData()
        goToAuth()
    }

    private func cleanCookies() {
        DispatchQueue.main.async {
            HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
            WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
                records.forEach { record in
                    WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                }
            }
        }
    }

    private func cleanToken() {
        storage.storeToken(token: nil)
    }

    private func cleanUserData() {
        profileService.cleanData()
        profileImageService.cleanData()
        feedService.cleanData()
        KingfisherManager.shared.cache.clearCache()
    }

    private func goToAuth() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first else { return }
            window.rootViewController = SplashViewController()
        }
    }
}
