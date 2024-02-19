//
//  ViewController.swift
//  ImageFeed
//
//  Created by Murad Azimov on 06.01.2024.
//

import UIKit

let tableContentInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
let imageInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)

class ImagesListViewController: UIViewController {
    
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        let imageName = "\(indexPath.row)"
        let dateLabel = Date().dateString
        let isLike = indexPath.row % 2 == 0
        cell.configCell(imageName, dateLabel, isLike)
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        addSubViews()
        applyConstraints()
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        guard let imageListCell = cell as? ImagesListCell else { return UITableViewCell() }
        imageListCell.selectionStyle = .none
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = UIImage(named: "\(indexPath.row)")
        guard let image else { return 0 }
        let originalRatio =  image.size.height / image.size.width
        let imageViewWidth = tableView.bounds.width - imageInsets.right - imageInsets.left
        let cellHeight = imageViewWidth * originalRatio + imageInsets.bottom
        return cellHeight
    }
}
