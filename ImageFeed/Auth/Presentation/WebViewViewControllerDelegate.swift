//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by kalmahik on 08.02.2024.
//

import Foundation

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ viewController: WebViewViewController, didAuthenticateWithCode code: String)
}
