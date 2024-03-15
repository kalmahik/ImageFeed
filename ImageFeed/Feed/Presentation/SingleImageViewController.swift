import UIKit
import LinkPresentation
import Kingfisher

class SingleImageViewController: UIViewController {
    // MARK: - Private Properties

    private var image: UIImage?
    private var photo: Photo?
    private let kfManager = KingfisherManager.shared

    // MARK: - Initializers

    init(photo: Photo) {
        super.init(nibName: nil, bundle: nil)
        self.photo = photo
    }

    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        applyConstraints()
        getCachedImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadImage()
    }

    // MARK: - Private Methods

    @objc private func didShareImage() {
        guard let image else { return }
        let activityViewController = UIActivityViewController(activityItems: [image, self], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }

    private func downloadImage() {
        guard let imageUrl = photo?.largeImageURL, let url = URL(string: imageUrl) else { return }
        UIBlockingProgressHUD.show()
        kfManager.retrieveImage(with: url) { [weak self] result in
            switch result {
            case .success(let value):
                self?.image = value.image
                self?.zoomImage.loadImage(value.image)
            case .failure:
                break
            }
            UIBlockingProgressHUD.dismiss()
        }
    }

    private func getCachedImage() {
        let cache = ImageCache.default
        guard let preview = photo?.thumbImageURL else { return }
        cache.retrieveImage(forKey: preview) { result in
            switch result {
            case .success(let value):
                self.zoomImage.loadImage(value.image ?? UIImage())
            case .failure:
                break
            }
        }
    }

    private func addSubViews() {
        [zoomImage, shareButton, backButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
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
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private lazy var zoomImage: UIZoomImageView = UIZoomImageView()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .ypBlack
        button.setImage(UIImage(named: "share"), for: .normal)
        button.addTarget(self, action: #selector(didShareImage), for: .touchUpInside)
        button.layer.cornerRadius = 25.0
        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(systemName: "chevron.left") ?? UIImage(),
            target: self,
            action: #selector(didTapBackButton)
        )
        button.tintColor = .ypWhite
        return button
    }()
}

extension SingleImageViewController: UIActivityItemSource {
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        guard let image else { return LPLinkMetadata() }
        let imageProvider = NSItemProvider(object: image)
        let metadata = LPLinkMetadata()
        metadata.imageProvider = imageProvider
        return metadata
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        photo?.largeImageURL ?? ""
    }

    func activityViewController(
        _ activityViewController: UIActivityViewController,
        itemForActivityType activityType: UIActivity.ActivityType?
    ) -> Any? {
        return nil
    }
}
