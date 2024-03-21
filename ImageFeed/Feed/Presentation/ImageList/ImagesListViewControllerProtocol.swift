import Foundation

protocol ImagesListViewControllerProtocol: AnyObject {
    var presenter: FeedPresenterProtocol? { get set }

    func updateTableViewAnimated(from: Int, to: Int)
}
