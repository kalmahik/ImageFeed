//
//  ViewController.swift
//  ImageFeed
//
//  Created by Murad Azimov on 06.01.2024.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    @IBOutlet private var tableView: UITableView!
    
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        cell.picture.image = UIImage(named: "\(indexPath.row)")
        cell.date.text = Date().dateString
        let image = UIImage(named: indexPath.row % 2 == 0 ? "favorite_active" : "favorite_inactive")
        cell.like.setImage(image, for: .normal)
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
        let image = UIImage(named: "\(indexPath.row)") ?? UIImage()
        let originalRatio =  image.size.height / image.size.width
        let imageViewWidth = tableView.bounds.width
        let cellHeight = imageViewWidth * originalRatio + 8
        return cellHeight
    }
}
