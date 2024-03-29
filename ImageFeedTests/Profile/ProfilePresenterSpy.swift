@testable import ImageFeed
import Foundation

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol?
    var viewDidLoadCalled: Bool = false

    func viewDidLoad() {
        viewDidLoadCalled = true
    }

    func didTapLogoutButton() {
    }

    func getProfile() -> ImageFeed.Profile? {
        return nil
    }

    func getProfileImageUrl() -> URL? {
        return nil
    }

}
