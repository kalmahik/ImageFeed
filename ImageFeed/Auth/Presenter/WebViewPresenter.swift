import Foundation

final class WebViewPresenter: WebViewPresenterProtocol {
    weak var view: WebViewViewControllerProtocol?
    var authHelper: AuthHelperProtocol

    init(authHelper: AuthHelperProtocol) {
        self.authHelper = authHelper
    }

    func viewDidLoad() {
        didUpdateProgressValue(0)
        view?.load(authHelper.authRequest())
    }

    func didUpdateProgressValue(_ newValue: Double) {
        let newProgressValue = Float(newValue)
        let shouldHideProgress = shouldHideProgress(for: newProgressValue)
        view?.setProgressValue(newProgressValue)
        view?.setProgressHidden(shouldHideProgress)
    }

    func shouldHideProgress(for value: Float) -> Bool {
        value >= 1.0
    }

    func parseCode(from url: URL) -> String? {
        authHelper.parseCode(from: url)
    }
}
