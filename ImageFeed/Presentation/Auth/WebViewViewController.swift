//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by kalmahik on 08.02.2024.
//

import UIKit
import WebKit

final class WebViewViewController: UIViewController {
    weak var delegate: WebViewViewControllerDelegate?
    
    override func viewDidLoad() {
        addSubViews()
        applyConstraints()
        loadWebview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeProgress()
        updateProgress()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeProgress()
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            updateProgress()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
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
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func subscribeProgress() {
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil
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
        var urlComponents = URLComponents(string: AuthURL)!
        urlComponents.queryItems = [
            URLQueryItem(name: AuthKeys.client_id.rawValue, value: AccessKey),
            URLQueryItem(name: AuthKeys.redirect_uri.rawValue, value: RedirectURI),
            URLQueryItem(name: AuthKeys.response_type.rawValue, value: AuthKeys.code.rawValue),
            URLQueryItem(name: AuthKeys.scope.rawValue, value: AccessScope)
        ]
        webView.load(URLRequest(url: urlComponents.url!))
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
            urlComponents.path == RedirectPath,
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == AuthKeys.code.rawValue})
        {
            return codeItem.value
        } else {
            return nil
        }
    }
}
