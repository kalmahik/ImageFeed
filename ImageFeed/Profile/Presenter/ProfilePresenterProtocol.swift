import Foundation

protocol ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }

    init(_ view: ProfileViewControllerProtocol)

    func viewDidLoad()
    func didTapLogoutButton()
    func getProfile() -> Profile?
    func getProfileImageUrl() -> URL?
}
