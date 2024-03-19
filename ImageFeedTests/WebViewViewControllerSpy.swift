import ImageFeed
import Foundation

final class WebViewViewControllerSpy: WebViewViewControllerProtocol {
    var presenter: ImageFeed.WebViewPresenterProtocol?
    var viewLoadCalled: Bool = false

    func load(_ request: URLRequest) {
        viewLoadCalled = true
    }

    func setProgressValue(_ newValue: Float) {

    }

    func setProgressHidden(_ isHidden: Bool) {

    }
}
