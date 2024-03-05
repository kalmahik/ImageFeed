//
//  AuthViewControllerDelegate.swift
//  ImageFeed
//
//  Created by kalmahik on 13.02.2024.
//

import Foundation

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ viewController: AuthViewController, didAuthenticateWithCode code: String)
}
