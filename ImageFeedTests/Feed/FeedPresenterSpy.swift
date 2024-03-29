@testable import ImageFeed
import Foundation

final class FeedPresenterSpy: FeedPresenterProtocol {
    var view: ImagesListViewControllerProtocol?
    var viewDidLoadCalled = false

    func viewDidLoad() {
        viewDidLoadCalled = true
    }

    func getPhotos() -> [ImageFeed.Photo] {
        []
    }

    func fetchFeed() {
        view?.updateTableViewAnimated(from: 0, to: 0)
    }

    func fetchNextFeed(indexPath: IndexPath) {

    }

    func openDetails(indexPath: IndexPath) {

    }

    func getCellHeight(indexPath: IndexPath) -> CGFloat {
        0
    }

    func didTapLike(_ cell: ImageFeed.ImagesListCell) {

    }
}
