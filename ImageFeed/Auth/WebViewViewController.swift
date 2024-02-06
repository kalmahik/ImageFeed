//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Murad Azimov on 06.02.2024.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate {
    private lazy var webView: WKWebView = WKWebView()
    
    
    override func loadView() {//почему этот метод
        webView.navigationDelegate = self
        view = webView ///или         view.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = buildAuthURL()
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func buildAuthURL() -> URL {
        let urlComponents = URLComponents(string: AuthURLString)
        guard var urlComponents else { return DefaultBaseURL }
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: AccessKey),
            URLQueryItem(name: "redirect_uri", value: RedirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: AccessScope)
        ]
        return urlComponents.url ?? DefaultBaseURL
    }
}
