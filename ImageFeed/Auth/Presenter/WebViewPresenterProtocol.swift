import Foundation

protocol WebViewPresenterProtocol {
    var view: WebViewViewControllerProtocol? { get set }
    func loadWebview()
    func didUpdateProgressValue(_ newValue: Double)
    func parseCode(from url: URL) -> String?
}
