import Foundation

protocol FeedPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get set }

    func viewDidLoad()
    func getPhotos() -> [Photo]
    func fetchFeed()
    func fetchNextFeed(indexPath: IndexPath)
    func openDetails(indexPath: IndexPath)
    func getCellHeight(indexPath: IndexPath) -> CGFloat
    func didTapLike(_ cell: ImagesListCell)
}
