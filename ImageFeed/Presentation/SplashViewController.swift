//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by kalmahik on 12.02.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    private let oAuthService = OAuthService.shared
    private let profileService = ProfileService.shared
    private let storage = OAuthTokenStorage()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkToken()
    }
    
    override func viewDidLoad() {
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        view.backgroundColor = .ypBlack
        view.addSubview(logoImage)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func checkToken() {
        if storage.token != nil {
            switchToApp()
        } else {
            switchToAuth()
        }
    }
    
    private func switchToApp() {
        let tabBarController = TabBarViewController()
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        window.rootViewController = tabBarController
    }
    
    private func switchToAuth() {
        let authController = AuthViewController(delegate: self)
        let navigationController = UINavigationController(rootViewController: authController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.topItem?.title = ""
        present(navigationController, animated: true)
    }
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        self.loadToken(code: code)
    }
    
    private func loadToken(code: String) {
        UIBlockingProgressHUD.show()
        oAuthService.fetchAuthToken(code: code) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                UIBlockingProgressHUD.dismiss()
                switch result {
                case .success(let token):
                    self?.navigationController?.popViewController(animated: true)
                    self?.storage.storeToken(token: token)
                    self?.switchToApp()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
