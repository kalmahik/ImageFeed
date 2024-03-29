@testable import ImageFeed
import UIKit

final class FeedViewControllerSpy: ImagesListViewControllerProtocol {
    var presenter: ImageFeed.FeedPresenterProtocol?
    var tableWasUpdated = false

    func addSubViews() {

    }

    func applyConstraints() {

    }

    func present(viewController: UIViewController, animated: Bool) {

    }

    func getTable() -> UITableView {
        UITableView()
    }

    func updateTableViewAnimated(from: Int, to: Int) {
        tableWasUpdated = true
    }

    func showAlert() {

    }
}
