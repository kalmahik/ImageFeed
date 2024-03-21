import Foundation

struct FeedPresenter: FeedPresenterProtocol {
    weak var view: ImagesListViewControllerProtocol?

    private let feedService = FeedService.shared
    private var photosCount: Int = 0

    init(_ view: ImagesListViewControllerProtocol) {
        self.view = view
    }

    func fetchFeed() {
        feedService.fetchFeed()
    }

    mutating func didUpdateTableViewAnimated() {
        let oldCount = photosCount
        let newCount = feedService.photos.count
        photosCount = feedService.photos.count
        if oldCount != newCount {
            view?.updateTableViewAnimated(from: oldCount, to: newCount)
        }
    }
}
