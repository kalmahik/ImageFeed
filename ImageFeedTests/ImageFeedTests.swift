@testable import ImageFeed
import XCTest

final class WebViewTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        // given
        let webviewController = WebViewViewController()
        let webViewPresenter = WebViewPresenterSpy()
        webviewController.presenter = webViewPresenter
        webViewPresenter.view = webviewController

        // when
         _ = webviewController.view

         // then
         XCTAssertTrue(webViewPresenter.viewDidLoadCalled)
    }

    func testPresenterCallsLoadRequest() {
        let authHelper = AuthHelper()
        let webviewController = WebViewViewControllerSpy()
        let webViewPresenter = WebViewPresenter(authHelper: authHelper)
        webviewController.presenter = webViewPresenter
        webViewPresenter.view = webviewController

        // when
        webViewPresenter.loadWebview()

         // then
        XCTAssertTrue(webviewController.viewLoadCalled)
    }
}
