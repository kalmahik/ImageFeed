//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by kalmahik on 20.03.2024.
//

import Foundation

final class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewControllerProtocol?

    init(_ view: ProfileViewController) {
        self.view = view
    }

    func didTapLogoutButton() {
        let alertData = AlertModel(
            title: "Пока, пока!",
            message: "Уверены, что хотите выйти?",
            actions: [
                Action(buttonText: "Нет", action: nil, style: .cancel),
                Action(buttonText: "Да", action: logoutAction, style: .destructive)
            ]
        )
        view?.showAlertModal(alertData: alertData)
    }

    private lazy var profileService = ProfileService.shared
    private lazy var profileImageService = ProfileImageService.shared
    private lazy var profileLogoutService = ProfileLogoutService.shared

    private func logoutAction() {
        profileLogoutService.logout()
    }
}
