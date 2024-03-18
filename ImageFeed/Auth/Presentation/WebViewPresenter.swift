//
//  WebViewPresenter.swift
//  ImageFeed
//
//  Created by Murad Azimov on 18.03.2024.
//

import Foundation

final class WebViewPresenter: WebViewPresenterProtocol {
    weak var view: WebViewViewControllerProtocol?

    func loadWebview() {
        var urlComponents = URLComponents(string: AuthConstants.authURL) ?? URLComponents()
        urlComponents.queryItems = [
            URLQueryItem(name: AuthKeys.clientID.rawValue, value: AuthConstants.accessKey),
            URLQueryItem(name: AuthKeys.redirectUri.rawValue, value: AuthConstants.redirectURI),
            URLQueryItem(name: AuthKeys.responseType.rawValue, value: AuthKeys.code.rawValue),
            URLQueryItem(name: AuthKeys.scope.rawValue, value: AuthConstants.accessScope)
        ]
        view?.load(URLRequest(url: urlComponents.url ?? NetworkConstants.defaultBaseURL))
    }

    func didUpdateProgressValue(_ newValue: Double) {
        let newProgressValue = Float(newValue)
        view?.setProgressValue(newProgressValue)

        let shouldHideProgress = shouldHideProgress(for: newProgressValue)
        view?.setProgressHidden(shouldHideProgress)
    }

    func shouldHideProgress(for value: Float) -> Bool {
        value >= 1.0
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
