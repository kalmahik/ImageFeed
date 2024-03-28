import Foundation

final class FeedPresenter: FeedPresenterProtocol {
    weak var view: ImagesListViewControllerProtocol?

    // MARK: - Private Properties
    private var feedServiceObserver: NSObjectProtocol?
    private let feedService = FeedService.shared
    private var photosCount: Int = 0

    init(_ view: ImagesListViewControllerProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        view?.addSubViews()
        view?.applyConstraints()
        fetchFeed()
        addObserver()
    }

    func getPhotos() -> [Photo] { feedService.photos }

    func fetchFeed() { feedService.fetchFeed() }

    func fetchNextFeed(indexPath: IndexPath) {
        if indexPath.row + 1 == feedService.photos.count {
            feedService.fetchFeed()
        }
    }

    func openDetails(indexPath: IndexPath) {
        let photo = feedService.photos[indexPath.row]
        let viewController = SingleImageViewController(photo: photo)
        viewController.modalPresentationStyle = .fullScreen
        view?.present(viewController: viewController, animated: true)
    }

    func getCellHeight(indexPath: IndexPath) -> CGFloat {
        guard let table = view?.getTable() else { return 0 }
        let photo = feedService.photos[indexPath.row]
        let insets = ImagesListViewController.imageInsets
        let originalRatio =  photo.size.height / photo.size.width
        let imageViewWidth = table.bounds.width - insets.right - insets.left
        return imageViewWidth * originalRatio + insets.bottom
    }

    func didTapLike(_ cell: ImagesListCell) {
        cell.setLikeEnabled(false)
        guard let table = view?.getTable(),
        let indexPath = table.indexPath(for: cell) else { return }
        let photo = feedService.photos[indexPath.row]
        feedService.changeLike(photoId: photo.id, isLike: !photo.isLiked) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newPhoto):
                    cell.setIsLiked(newPhoto.isLiked)
                case .failure:
                    self.view?.showAlert()
                }
                cell.setLikeEnabled(true)
            }
        }
    }

    private func addObserver() {
        feedServiceObserver = NotificationCenter.default
            .addObserver(
                forName: FeedService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                self?.didUpdateTableViewAnimated()
            }
    }

    private func didUpdateTableViewAnimated() {
        let oldCount = photosCount
        let newCount = feedService.photos.count
        photosCount = feedService.photos.count
        if oldCount != newCount {
            view?.updateTableViewAnimated(from: oldCount, to: newCount)
        }
    }
}
