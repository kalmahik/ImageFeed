@testable import ImageFeed
import XCTest

final class ProfileTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        // given
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenterSpy(profileViewController)
        profileViewController.presenter = profilePresenter

        // when
        _ = profileViewController.view

        // then
        XCTAssertTrue(profilePresenter.viewDidLoadCalled)
    }
}
