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
        // given
        let authHelper = AuthHelper()
        let webviewController = WebViewViewControllerSpy()
        let webViewPresenter = WebViewPresenter(authHelper: authHelper)
        webviewController.presenter = webViewPresenter
        webViewPresenter.view = webviewController

        // when
        webViewPresenter.viewDidLoad()

        // then
        XCTAssertTrue(webviewController.viewLoadCalled)
    }

    func testProgressVisibleWhenLessThenOne() {
        // given
        let authHelper = AuthHelper()
        let webViewPresenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 0.6

        // when
        let shouldHideProgress = webViewPresenter.shouldHideProgress(for: progress)

        // then
        XCTAssertFalse(shouldHideProgress)
    }

    func testProgressHiddenWhenOne() {
        // given
        let authHelper = AuthHelper()
        let webViewPresenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 1.0

        // when
        let shouldHideProgress = webViewPresenter.shouldHideProgress(for: progress)

        // then
        XCTAssertTrue(shouldHideProgress)
    }

    func testAuthHelperAuthURL() {
        // given
        let authHelper = AuthHelper()

        // when
        let url = authHelper.authURL()
        let urlString = url.absoluteString

        // then
        XCTAssertTrue(urlString.contains(AuthConstants.authURL))
        XCTAssertTrue(urlString.contains(AuthConstants.accessKey))
        XCTAssertTrue(urlString.contains(AuthConstants.redirectURI))
        XCTAssertTrue(urlString.contains(AuthKeys.code.rawValue))
        XCTAssertTrue(urlString.contains(AuthConstants.accessScope))
    }

    func testCodeFromURL() {
        // given
        let authHelper = AuthHelper()

        var urlComponents = URLComponents(string: "https://unsplash.com/oauth/authorize/native")!
        urlComponents.queryItems = [
            URLQueryItem(name: AuthKeys.code.rawValue, value: "test code")
        ]

        // when
        let code = authHelper.parseCode(from: urlComponents.url!)
        XCTAssertEqual(code, "test code")
    }
}
