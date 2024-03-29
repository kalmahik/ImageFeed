import Kingfisher
import UIKit

class ProfileViewController: UIViewController, ProfileViewControllerProtocol {

    // MARK: - Public Properties

    var presenter: ProfilePresenterProtocol?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        applyConstraints()
        presenter?.viewDidLoad()
    }

    // MARK: - Public Methods

    func showAlertModal(alertData: AlertData) {
        showAlert(alertData: alertData)
    }

    func setAvatarImage(with url: URL) {
        avatarImage.kf.setImage(with: url)
    }

    // MARK: - Views

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

    private lazy var avatarImage: UIImageView = {
        let placeholder = UIImage(named: "avatar_placeholder")
        let imageView = UIImageView(image: placeholder)
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        let url = presenter?.getProfileImageUrl()
        guard let url else { return imageView }
        imageView.kf.setImage(with: url, placeholder: placeholder)
        return imageView
    }()

    private lazy var exitButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward") ?? UIImage(),
            target: self,
            action: #selector(didTapLogoutButton)
        )
        button.tintColor = .ypRed
        button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        return button
    }()

    private func configureLabel(
        _ text: String,
        size: CGFloat = 13,
        color: UIColor = .ypWhite,
        weight: UIFont.Weight = .regular
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = color
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        return label
    }

    // MARK: - Private Methods

    @objc private func didTapLogoutButton() {
        presenter?.didTapLogoutButton()
    }
}

// MARK: - applyConstraints && addSubViews

extension ProfileViewController {
    func applyConstraints() {
        NSLayoutConstraint.activate([
            rootStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            rootStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            rootStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            avatarStack.widthAnchor.constraint(equalTo: rootStack.widthAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 70),
            avatarImage.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    func addSubViews() {
        rootStack.addArrangedSubview(avatarStack)
        avatarStack.addArrangedSubview(avatarImage)
        avatarStack.addArrangedSubview(exitButton)
        guard let profile = presenter?.getProfile() else { return }
        rootStack.addArrangedSubview(configureLabel(profile.name, size: 23, weight: .bold))
        rootStack.addArrangedSubview(configureLabel(profile.loginName, color: .ypGray))
        rootStack.addArrangedSubview(configureLabel(profile.bio))
        view.addSubview(rootStack)
        view.backgroundColor = .ypBlack
    }
}
