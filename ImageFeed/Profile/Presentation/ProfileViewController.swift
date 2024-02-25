//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Murad Azimov on 18.01.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    private lazy var storage = OAuthTokenStorage()
    private lazy var profileService: ProfileService = ProfileService.shared

    override func viewDidLoad() {
        addSubViews()
        applyConstraints()
        loadProfile()
    }
    
    private func loadProfile() {
        profileService.fetchProfile() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    print(profile)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            rootStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            rootStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            rootStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            avatarStack.widthAnchor.constraint(equalTo: rootStack.widthAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            avatarImage.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    private func addSubViews() {
        rootStack.addArrangedSubview(avatarStack)
        rootStack.addArrangedSubview(configureLabel("Firstname and lastname", size: 23))
        rootStack.addArrangedSubview(configureLabel("nickname", color: .ypGray))
        rootStack.addArrangedSubview(configureLabel("Description"))
        avatarStack.addArrangedSubview(avatarImage)
        avatarStack.addArrangedSubview(exitButton)
        view.addSubview(rootStack)
        view.backgroundColor = .ypBlack
    }
    
    private let rootStack: UIStackView =  {
        let rootStack: UIStackView = UIStackView()
        rootStack.translatesAutoresizingMaskIntoConstraints = false
        rootStack.axis = NSLayoutConstraint.Axis.vertical
        rootStack.distribution = UIStackView.Distribution.fill
        rootStack.alignment = UIStackView.Alignment.leading
        rootStack.spacing = 8
        return rootStack
    }()
    
    private let avatarStack: UIStackView = {
        let hStack: UIStackView = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = NSLayoutConstraint.Axis.horizontal
        hStack.distribution = UIStackView.Distribution.equalCentering
        hStack.alignment = UIStackView.Alignment.center
        return hStack
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar_placeholder"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward") ?? UIImage(),
            target: self,
            action: #selector(didTapButton)
        )
        button.tintColor = .ypRed
        button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        return button
    }()
    
    private func configureLabel(_ text: String, size: CGFloat = 13, color: UIColor = .ypWhite, type: UIFont.FontType = .regular) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = color
        label.font = UIFont.font(type: type, size: size)
        return label
    }
    
    @objc private func didTapButton() {
        storage.storeToken(token: nil)
    }
}
