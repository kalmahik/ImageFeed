import Foundation

protocol FeedPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get set }

    func fetchFeed()

    mutating func didUpdateTableViewAnimated()
}
