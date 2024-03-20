import Foundation

protocol ProfilePresenterProtocol {
//    var profileService: ProfileService { get }
//    var profileImageService: ProfileImageService { get }
//    var profileLogoutService: ProfileLogoutService { get }
    var view: ProfileViewControllerProtocol? { get set }
    func didTapLogoutButton()
}
