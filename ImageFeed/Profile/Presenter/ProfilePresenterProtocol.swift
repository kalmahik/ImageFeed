import Foundation

protocol ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }

    func didTapLogoutButton()

    func didUpdateAvatar()
}
