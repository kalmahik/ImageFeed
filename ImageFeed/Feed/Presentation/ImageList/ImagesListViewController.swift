import Kingfisher
import UIKit

class ImagesListViewController: UIViewController, ImagesListViewControllerProtocol {
    // MARK: - Constants

    static let tableContentInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    static let imageInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)

    // MARK: - Public Properties

    var presenter: FeedPresenterProtocol?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FeedPresenter(self)
        tableView.dataSource = self
        tableView.delegate = self
        presenter?.viewDidLoad()
    }

    // MARK: - Public Methods

    func getTable() -> UITableView { tableView }

    func showAlert() { super.showAlert() }

    func present(viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated)
    }

    // MARK: - Private Methods

    func updateTableViewAnimated(from: Int, to: Int) {
        tableView.performBatchUpdates {
            let indexPaths = (from..<to).map { i in
                IndexPath(row: i, section: 0)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }

    // MARK: - Views

    private let tableView: UITableView = {
        let placeholder = UIImageView(image: UIImage(named: "image_placeholder"))
        placeholder.contentMode = .center
        let tableView  = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = tableContentInsets
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ImagesListCell.self, forCellReuseIdentifier: ImagesListCell.reuseIdentifier)
        tableView.separatorColor = .ypBlack
        tableView.backgroundColor = .ypBlack
        tableView.backgroundView = placeholder
        return tableView
    }()
}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openDetails(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.fetchNextFeed(indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getPhotos().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        guard let imageListCell = cell as? ImagesListCell else { return UITableViewCell() }
        guard let photo = presenter?.getPhotos()[indexPath.row] else { return UITableViewCell() }
        let dateLabel = photo.createdAt?.dateString ?? ""
        imageListCell.selectionStyle = .none
        imageListCell.backgroundColor = .ypBlack
        imageListCell.delegate = self
        imageListCell.configCell(photo.thumbImageURL, dateLabel, photo.isLiked)
        return imageListCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { presenter?.getCellHeight(indexPath: indexPath) ?? 0
    }
}

// MARK: - ImagesListCellDelegate

extension ImagesListViewController: ImagesListCellDelegate {
    func didTapLike(_ cell: ImagesListCell) {
        presenter?.didTapLike(cell)
    }
}

// MARK: - applyConstraints && addSubViews

extension ImagesListViewController {
    func addSubViews() {
        view.addSubview(tableView)
        view.backgroundColor = .ypBlack
    }

    func applyConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
