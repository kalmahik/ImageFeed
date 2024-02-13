//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Murad Azimov on 05.02.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    private var delegate: AuthViewControllerDelegate?

    init(delegate: AuthViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        view.backgroundColor = .ypBlack
        view.addSubview(logoImage)
        view.addSubview(loginButton)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    @objc private func didTapButton() {
        let webviewController = WebViewViewController()
        webviewController.delegate = self
        self.navigationController?.pushViewController(webviewController, animated: true)
    }
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo_unsplash"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .ypWhite
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.ypBlack, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.titleLabel?.font =  UIFont.font(type: .bold, size: 17)
        button.layer.cornerRadius = 16
        return button
    }()
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
    }
}
