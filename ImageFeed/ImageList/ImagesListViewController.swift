//
//  ViewController.swift
//  ImageFeed
//
//  Created by Murad Azimov on 06.01.2024.
//

import UIKit

let tableContentInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
let cellInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)

class ImagesListViewController: UIViewController {
    
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = tableContentInsets
        tableView.showsVerticalScrollIndicator = false
    }
    
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        cell.pictureImageView.image = UIImage(named: "\(indexPath.row)")
        cell.dateLabel.text = Date().dateString
        cell.likeButton.setImage( UIImage(named: indexPath.row % 2 == 0 ? "favorite_active" : "favorite_inactive"), for: .normal)
    }
}

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    
}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = UIImage(named: "\(indexPath.row)")
        guard let image else { return 0 }
        let originalRatio =  image.size.height / image.size.width
        let imageViewWidth = tableView.bounds.width - cellInsets.right - cellInsets.left
        let cellHeight = imageViewWidth * originalRatio + cellInsets.bottom
        return cellHeight
    }
}
