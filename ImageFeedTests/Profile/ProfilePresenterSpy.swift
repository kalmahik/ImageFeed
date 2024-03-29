@testable import ImageFeed
import Foundation

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var view: ImageFeed.ProfileViewControllerProtocol?
    var viewDidLoadCalled: Bool = false

    init(_ view: ImageFeed.ProfileViewControllerProtocol) {
        self.view = view
    }

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
