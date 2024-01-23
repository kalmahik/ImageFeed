//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Murad Azimov on 11.01.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet private var pictureImageView: UIImageView!
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var dateLabel: UILabel!
    
    func configCell(_ imageName: String, _ dateText: String, _ isLike: Bool) {
        pictureImageView.image = UIImage(named: imageName)
        dateLabel.text = dateText
        let image = UIImage(named:  "favorite")?.withRenderingMode(.alwaysTemplate)
        likeButton.setImage(image, for: .normal)
        likeButton.tintColor = isLike ? .ypRed : .ypWhite50
    }
}
