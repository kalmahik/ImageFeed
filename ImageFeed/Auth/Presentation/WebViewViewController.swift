import UIKit
import WebKit

final class WebViewViewController: UIViewController {
    // MARK: - Public Properties

    weak var delegate: WebViewViewControllerDelegate?

    // MARK: - Private Properties

    private var estimatedProgressObservation: NSKeyValueObservation?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        applyConstraints()
        loadWebview()
        updateProgress()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeProgress()
    }

    // MARK: - Private Methods

    private func addSubViews() {
        view.addSubview(webView)
        view.addSubview(progressView)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func subscribeProgress() {
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 self?.updateProgress()
             }
        )
    }

    private func unsubscribeProgress() {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
    }

    private func updateProgress() {
        let progressValue = Float(webView.estimatedProgress)
        progressView.setProgress(progressValue, animated: true)
        progressView.isHidden = progressValue >= 1.0
    }

    private func loadWebview() {
        var urlComponents = URLComponents(string: AuthConstants.authURL) ?? URLComponents()
        urlComponents.queryItems = [
            URLQueryItem(name: AuthKeys.clientID.rawValue, value: AuthConstants.accessKey[0]),
            URLQueryItem(name: AuthKeys.redirectUri.rawValue, value: AuthConstants.redirectURI),
            URLQueryItem(name: AuthKeys.responseType.rawValue, value: AuthKeys.code.rawValue),
            URLQueryItem(name: AuthKeys.scope.rawValue, value: AuthConstants.accessScope)
        ]
        webView.load(URLRequest(url: urlComponents.url ?? NetworkConstants.defaultBaseURL))
    }

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()

    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .ypBlack
        progressView.trackTintColor = .ypGray
        return progressView
    }()

}

extension WebViewViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let code = parseCode(from: navigationAction) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }

    private func parseCode(from navigationAction: WKNavigationAction) -> String? {
        if
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == AuthConstants.redirectPath,
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == AuthKeys.code.rawValue}) {
            return codeItem.value
        } else {
            return nil
        }
    }
}
