//
//  ViewController.swift
//  ImageFeed
//
//  Created by Murad Azimov on 06.01.2024.
//

import UIKit
import Kingfisher

class ImagesListViewController: UIViewController {
    // MARK: - Constants

    static let tableContentInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    static let imageInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)

    // MARK: - Private Properties
    private let feedService = FeedService.shared
    private var feedServiceObserver: NSObjectProtocol?
    private let token = OAuthTokenStorage().token

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        addSubViews()
        applyConstraints()
        fetchFeed()
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
                self?.tableView.reloadData()
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
        let viewController = SingleImageViewController(imageName: "\(indexPath.row)")
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        fetch new data if user scroll to the last cell
//        guard isLoadingIndexPath(indexPath) else { return }
//        if self.totalItems > orders.count {
//            fetchNextPage()
//        }

//        if indexPath.row + 1 == photos.count {
//            
//        }
    }

    private func fetchFeed() {
        feedService.fetchFeed { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success:
                    break
                case .failure:
                    self?.showAlert()
                }
            }
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
        let imageUrl = feedService.photos[indexPath.row].thumbImageURL
        let dateLabel = Date().dateString
        let isLike = indexPath.row % 2 == 0
        imageListCell.selectionStyle = .none
        imageListCell.backgroundColor = .ypBlack
        imageListCell.configCell(imageUrl, dateLabel, isLike)
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
