@testable import ImageFeed
import Foundation

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ProfilePresenterProtocol?
    var isAlertModalWasShown: Bool = false

    func showAlertModal(alertData: ImageFeed.AlertData) {
        isAlertModalWasShown = true
    }

    func setAvatarImage(with url: URL) {

    }

    func addSubViews() {

    }

    func applyConstraints() {

    }

}
