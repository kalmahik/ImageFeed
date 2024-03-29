import Foundation
@testable import ImageFeed
import XCTest

final class FeedTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        // given
        let feedViewController = ImagesListViewController()
        let feedPresenter = FeedPresenterSpy()
        feedPresenter.view = feedViewController
        feedViewController.presenter = feedPresenter

        // when
        _ = feedViewController.view

        // then
        XCTAssertTrue(feedPresenter.viewDidLoadCalled)
    }

    func testDetailsWasOpened() {
        // given
        let feedViewController = FeedViewControllerSpy()
        let feedPresenter = FeedPresenterSpy()
        feedPresenter.view = feedViewController
        feedViewController.presenter = feedPresenter

        // when
        feedPresenter.fetchFeed()

        // then
        XCTAssertTrue(feedViewController.tableWasUpdated)
    }
}
