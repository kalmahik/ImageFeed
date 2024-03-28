import Foundation

final class ProfilePresenter: ProfilePresenterProtocol {

    // MARK: - Public Properties

    weak var view: ProfileViewControllerProtocol?

    // MARK: - Private Properties

    private lazy var profileService = ProfileService.shared
    private lazy var profileImageService = ProfileImageService.shared
    private lazy var profileLogoutService = ProfileLogoutService.shared
    private var profileImageServiceObserver: NSObjectProtocol?

    // MARK: - Initializers

    init(_ view: ProfileViewControllerProtocol) {
        self.view = view
    }

    // MARK: - Public Methods

    func viewDidLoad() {
        addObserver()
        view?.addSubViews()
        view?.applyConstraints()
    }

    func didTapLogoutButton() {
        let alertData = AlertModel(
            title: "Пока, пока!",
            message: "Уверены, что хотите выйти?",
            actions: [
                Action(buttonText: "Нет", action: nil, style: .cancel),
                Action(buttonText: "Да", action: logoutAction, style: .destructive)
            ]
        )
        view?.showAlertModal(alertData: alertData)
    }

    func getProfile() -> Profile? {
        profileService.profile
    }

    func getProfileImageUrl() -> URL? {
        let avatarURL = profileImageService.profileImageURL
        guard let avatarURL else { return nil}
        return URL(string: avatarURL)
    }

    // MARK: - Private Methods

    private func addObserver() {
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                self?.didUpdateAvatar()
            }
        didUpdateAvatar()
    }

    private func didUpdateAvatar() {
        guard let url = getProfileImageUrl() else { return }
        view?.setAvatarImage(with: url)
    }

    private func logoutAction() {
        profileLogoutService.logout()
    }
}
