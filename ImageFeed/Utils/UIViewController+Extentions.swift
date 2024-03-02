//
//  UIViewController+Extentions.swift
//  ImageFeed
//
//  Created by Murad Azimov on 27.02.2024.
//

import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: ((_: UIAlertAction) -> Void)?
}

private let defaultAlertData = AlertModel(
    title: "Что-то пошло не так(",
    message: "Не удалось войти в систему",
    buttonText: "ОК",
    completion: nil
)

extension UIViewController {    
    func showAlert(alertData: AlertModel = defaultAlertData) {
        let alert = UIAlertController(title: alertData.title, message: alertData.message, preferredStyle: .alert)
        let action = UIAlertAction(title: alertData.buttonText, style: .default, handler: alertData.completion)
        alert.addAction(action)
        alert.view.accessibilityIdentifier = "Alert"
        DispatchQueue.main.async { [weak self] in
            self?.getTopView()?.present(alert, animated: true, completion: nil)
        }
    }
    
    func getTopView() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                return topController
            }
        }
        return nil
    }
}