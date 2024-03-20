//
//  ProfileViewControllerProtocol.swift
//  ImageFeed
//
//  Created by kalmahik on 20.03.2024.
//

import Foundation

protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }

    func showAlertModal(alertData: AlertModel)
}
