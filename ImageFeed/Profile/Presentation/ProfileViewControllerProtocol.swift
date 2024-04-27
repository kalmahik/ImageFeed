import Foundation

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }

    func showAlertModal(alertData: AlertData)
    func setAvatarImage(with url: URL)
    func addSubViews()
    func applyConstraints()
}
