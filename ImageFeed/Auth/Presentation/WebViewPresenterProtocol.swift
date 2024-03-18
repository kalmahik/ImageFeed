//
//  WebViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Murad Azimov on 18.03.2024.
//

import Foundation

public protocol WebViewPresenterProtocol {
    var view: WebViewViewControllerProtocol? { get set }
    func loadWebview()
    func didUpdateProgressValue(_ newValue: Double)
    func parseCode(from url: URL) -> String?
}
