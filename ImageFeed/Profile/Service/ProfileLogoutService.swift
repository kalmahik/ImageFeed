//
//  ProfileLogoutService.swift
//  ImageFeed
//
//  Created by Murad Azimov on 11.03.2024.
//

import Foundation
import WebKit

final class ProfileLogoutService {
    static let shared = ProfileLogoutService()
    private lazy var storage = OAuthTokenStorage()

    private init() {}

    func logout() {
        cleanCookies()
        cleanToken()
        goToAuth()
    }

    private func cleanCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }

    private func cleanToken() {
        storage.storeToken(token: nil)
    }

    private func goToAuth() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first else { return }
            window.rootViewController = SplashViewController()
        }
    }
}
