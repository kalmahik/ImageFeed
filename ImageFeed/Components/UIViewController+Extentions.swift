import UIKit

struct Action {
    let buttonText: String
    let action: ((_: UIAlertAction) -> Void)?
    let style: UIAlertAction.Style
}

struct AlertModel {
    let title: String
    let message: String
    let actions: [Action]

}

private let defaultAlertData = AlertModel(
    title: "Что-то пошло не так(",
    message: "Не удалось войти в систему",
    actions: [Action(buttonText: "ОК", action: nil, style: .default)]
)

extension UIViewController {
    func showAlert(alertData: AlertModel = defaultAlertData) {
        let alert = UIAlertController(title: alertData.title, message: alertData.message, preferredStyle: .alert)
        alertData.actions.forEach {
            let action = UIAlertAction(title: $0.buttonText, style: $0.style, handler: $0.action)
            alert.addAction(action)
        }
        alert.view.accessibilityIdentifier = "Alert"
        DispatchQueue.main.async {
            (self.presentedViewController ?? self).present(alert, animated: true, completion: nil)
        }
    }
}
