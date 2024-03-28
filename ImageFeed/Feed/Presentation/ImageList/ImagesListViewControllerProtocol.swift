import UIKit

protocol ImagesListViewControllerProtocol: AnyObject {
    var presenter: FeedPresenterProtocol? { get set }

    func addSubViews()
    func applyConstraints()
    func present(viewController: UIViewController, animated: Bool)
    func getTable() -> UITableView
    func updateTableViewAnimated(from: Int, to: Int)
    func showAlert()
}
