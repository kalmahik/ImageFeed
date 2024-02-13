//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by kalmahik on 12.02.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    private lazy var networkClient: NetworkClientProtocol = NetworkClient()
    private lazy var oAuthService: OAuthService = OAuthService(networkClient: networkClient)
    private lazy var oAuthTokenStorage: OAuthTokenStorage = OAuthTokenStorage()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkToken()
    }
    
    private func checkToken() {
        if oAuthTokenStorage.token != nil {
            switchToTabBarController()
        } else {
            switchToAuthController()
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
    
    
    private func switchToAuthController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let authController = AuthViewController(delegate: self)
        let navigationController = UINavigationController(rootViewController: authController)
        window.rootViewController = navigationController
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        self.loadData(code: code)
    }
    
    private func loadData(code: String) {
        oAuthService.fetchAuthToken(code: code) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let token):
                    self?.navigationController?.popViewController(animated: true)
                    self?.oAuthTokenStorage.storeToken(token: token)
                    self?.switchToTabBarController()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
