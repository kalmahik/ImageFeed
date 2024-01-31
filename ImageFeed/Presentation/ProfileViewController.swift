//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Murad Azimov on 18.01.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let rootStack: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        configureRootStack()
    }
    
    private func configureRootStack() {
        rootStack.translatesAutoresizingMaskIntoConstraints = false
        rootStack.axis = NSLayoutConstraint.Axis.vertical
        rootStack.distribution = UIStackView.Distribution.fill
        rootStack.alignment = UIStackView.Alignment.leading
        rootStack.spacing = 8
    
        rootStack.addArrangedSubview(configureAvatarContainer())
        rootStack.addArrangedSubview(configureLabel("Firstname and lastname", size: 23))
        rootStack.addArrangedSubview(configureLabel("nickname", color: .ypGray))
        rootStack.addArrangedSubview(configureLabel("Description"))
        
        view.addSubview(rootStack)
        
        rootStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        rootStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        rootStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
    }
    
    private func configureAvatarContainer() -> UIView {
        let hStack: UIStackView = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = NSLayoutConstraint.Axis.horizontal
        hStack.distribution = UIStackView.Distribution.equalCentering
        hStack.alignment = UIStackView.Alignment.center
        
        hStack.addArrangedSubview(configureAvatar())
        hStack.addArrangedSubview(configureExitButton())
        
        rootStack.addSubview(hStack)
        hStack.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true

        return hStack
    }
    
    private func configureAvatar() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "avatar_placeholder"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return imageView
    }
    
    private func configureExitButton() -> UIButton {
        let button = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward")!,
            target: self,
            action: #selector(didTapButton)
        )
        button.tintColor = .ypRed
        button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        return button
    }
    
    private func configureLabel(_ text: String, size: CGFloat = 13, color: UIColor = .ypWhite, type: UIFont.FontType = .regular) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = color
        label.font = UIFont.font(type: type, size: size)
        return label
    }
    
    @objc private func didTapButton() {
        print("Hello world!")
    }
}
