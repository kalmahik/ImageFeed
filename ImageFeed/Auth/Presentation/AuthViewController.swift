import UIKit

final class AuthViewController: UIViewController {
    // MARK: - Private Properties

    private weak var delegate: AuthViewControllerDelegate?

    // MARK: - Initializers

    init(delegate: AuthViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - UIViewController(*)

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        applyConstraints()
    }

    // MARK: - Private Methods

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
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    @objc private func didTapLoginButton() {
        let webviewController = WebViewViewController()
        let webViewPresenter = WebViewPresenter()
        webviewController.presenter = webViewPresenter
        webViewPresenter.view = webviewController
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
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 16
        return button
    }()
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ viewController: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
    }
}
