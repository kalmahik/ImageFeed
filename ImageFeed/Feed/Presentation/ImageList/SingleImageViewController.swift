//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Murad Azimov on 11.01.2024.
//

import UIKit
import LinkPresentation

class SingleImageViewController: UIViewController {
    private var imageName: String = ""
    
    init(imageName: String) {
        super.init(nibName: nil, bundle: nil)
        self.imageName = imageName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        view.addSubview(zoomImage)
        view.addSubview(shareButton)
        view.addSubview(backButton)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            zoomImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            zoomImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            zoomImage.topAnchor.constraint(equalTo: view.topAnchor),
            zoomImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            shareButton.widthAnchor.constraint(equalToConstant: 50),
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 42),
            backButton.widthAnchor.constraint(equalToConstant: 42),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    @objc private func didShareImage() {
        let image = UIImage(named: imageName) ?? UIImage()
        let activityViewController = UIActivityViewController(activityItems: [image, self], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    private lazy var zoomImage: UIPanZoomImageView = {
        let zoomImage = UIPanZoomImageView(named: self.imageName)
        zoomImage.translatesAutoresizingMaskIntoConstraints = false
        zoomImage.imageName = imageName
        return zoomImage
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .ypBlack
        button.setImage(UIImage(named: "share"), for: .normal)
        button.addTarget(self, action: #selector(didShareImage), for: .touchUpInside)
        button.layer.cornerRadius = 25.0
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton.systemButton(with: UIImage(systemName: "chevron.left") ?? UIImage(), target: self, action: #selector(didTapBackButton))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .ypWhite
        return button
    }()
}

extension SingleImageViewController: UIActivityItemSource {
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let image = UIImage(named: imageName) ?? UIImage()
        let imageProvider = NSItemProvider(object: image)
        let metadata = LPLinkMetadata()
        metadata.imageProvider = imageProvider
        return metadata
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any { imageName }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return nil
    }
}

