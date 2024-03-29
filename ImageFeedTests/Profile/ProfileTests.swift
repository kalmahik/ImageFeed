@testable import ImageFeed
import XCTest

final class ProfileTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        // given
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenterSpy()
        profilePresenter.view = profileViewController
        profileViewController.presenter = profilePresenter

        // when
        _ = profileViewController.view

        // then
        XCTAssertTrue(profilePresenter.viewDidLoadCalled)
    }

    func testAlertWasShown() {
        // given
        let profileViewController = ProfileViewControllerSpy()
        let profilePresenter = ProfilePresenter()
        profileViewController.presenter = profilePresenter
        profilePresenter.view = profileViewController

        // when
        profilePresenter.didTapLogoutButton()

        // then
        XCTAssertTrue(profileViewController.isAlertModalWasShown)
    }
}
