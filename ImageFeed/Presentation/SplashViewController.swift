//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by kalmahik on 12.02.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    // MARK: - Private Properties

    private let oAuthService = OAuthService.shared
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let storage = OAuthTokenStorage()

    // MARK: - UIViewController(*)

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkToken()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        applyConstraints()
    }

    // MARK: - Private Methods

    private func addSubViews() {
        view.backgroundColor = .ypBlack
        view.addSubview(logoImage)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func checkToken() {
        storage.token != nil ? fetchProfile() : switchToAuth()
    }

    private func switchToApp() {
        let tabBarController = TabBarViewController()
        guard let window = UIApplication.shared.windows.first else { return }
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
    func authViewController(_ viewController: AuthViewController, didAuthenticateWithCode code: String) {
        self.loadToken(code: code)
    }

    private func loadToken(code: String) {
        UIBlockingProgressHUD.show()
        oAuthService.fetchAuthToken(code: code) { [weak self] result in
            DispatchQueue.main.async {
                UIBlockingProgressHUD.dismiss()
                switch result {
                case .success(let token):
                    self?.navigationController?.popViewController(animated: true)
                    self?.storage.storeToken(token: token)
                    self?.fetchProfile()
                case .failure:
                    self?.showAlert()
                }
            }
        }
    }

    private func fetchProfile() {
        UIBlockingProgressHUD.show()
        profileService.fetchProfile { [weak self] result in
            DispatchQueue.main.async {
                UIBlockingProgressHUD.dismiss()
                switch result {
                case .success(let profile):
                    self?.profileImageService.fetchProfileImageURL(username: profile.username) { _ in }
                    self?.switchToApp()
                case .failure:
                    self?.showAlert()
                }
            }
        }
    }
}
