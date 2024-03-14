import UIKit
import Kingfisher

class ImagesListViewController: UIViewController {
    // MARK: - Constants

    static let tableContentInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    static let imageInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)

    // MARK: - Private Properties
    private let feedService = FeedService.shared
    private var feedServiceObserver: NSObjectProtocol?
    private let token = OAuthTokenStorage.shared.token
    private var photosCount: Int = 0

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        addSubViews()
        applyConstraints()
        feedService.fetchFeed()
        addObserver()
    }

    // MARK: - Private Methods

    private func addObserver() {
        feedServiceObserver = NotificationCenter.default
            .addObserver(
                forName: FeedService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                self?.updateTableViewAnimated()
            }
    }

    private func updateTableViewAnimated() {
        let oldCount = photosCount
        let newCount = feedService.photos.count
        photosCount = feedService.photos.count
        if oldCount != newCount {
            tableView.performBatchUpdates {
                let indexPaths = (oldCount..<newCount).map { i in
                    IndexPath(row: i, section: 0)
                }
                tableView.insertRows(at: indexPaths, with: .automatic)
            }
        }
    }

    private func addSubViews() {
        view.addSubview(tableView)
        view.backgroundColor = .ypBlack
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private let tableView: UITableView = {
        let tableView  = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = tableContentInsets
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ImagesListCell.self, forCellReuseIdentifier: ImagesListCell.reuseIdentifier)
        tableView.separatorColor = .ypBlack
        tableView.backgroundColor = .ypBlack
        return tableView
    }()
}

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = feedService.photos[indexPath.row]
        let viewController = SingleImageViewController(photo: photo)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == feedService.photos.count {
            feedService.fetchFeed()
        }
    }
}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedService.photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        guard let imageListCell = cell as? ImagesListCell else { return UITableViewCell() }
        let photo = feedService.photos[indexPath.row]
        let dateLabel = photo.createdAt?.dateString ?? ""
        imageListCell.selectionStyle = .none
        imageListCell.backgroundColor = .ypBlack
        imageListCell.delegate = self
        imageListCell.configCell(photo.thumbImageURL, dateLabel, photo.isLiked)
        return imageListCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let photo = feedService.photos[indexPath.row]
        let insets = ImagesListViewController.imageInsets
        let originalRatio =  photo.size.height / photo.size.width
        let imageViewWidth = tableView.bounds.width - insets.right - insets.left
        let cellHeight = imageViewWidth * originalRatio + insets.bottom
        return cellHeight
    }
}

extension ImagesListViewController: ImagesListCellDelegate {
    func didTapLike(_ cell: ImagesListCell) {
        cell.setLikeEnabled(false)
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let photo = feedService.photos[indexPath.row]
        feedService.changeLike(photoId: photo.id, isLike: !photo.isLiked) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newPhoto):
                    cell.setIsLiked(newPhoto.isLiked)
                case .failure:
                    self.showAlert()
                }
                cell.setLikeEnabled(true)
            }
        }
    }
}
