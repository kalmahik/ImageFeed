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
        if oAuthTokenStorage.token != nil {
            switchToApp()
        } else {
            switchToAuth()
        }
    }
    
    private func switchToApp() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "TabBarViewController")
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
        self.loadData(code: code)
    }
    
    private func loadData(code: String) {
        oAuthService.fetchAuthToken(code: code) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let token):
                    self?.navigationController?.popViewController(animated: true)
                    self?.oAuthTokenStorage.storeToken(token: token)
                    self?.switchToApp()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
