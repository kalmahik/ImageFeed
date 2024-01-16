//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Murad Azimov on 11.01.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 16
        contentView.frame = contentView.frame.inset(by: cellInsets)
    }
    
func configCell(_ imageName: String, _ dateText: String, _ isLike: Bool) {
        pictureImageView.image = UIImage(named: imageName)
        dateLabel.text = dateText
        likeButton.setImage( UIImage(named: isLike ? "favorite_active" : "favorite_inactive"), for: .normal)
    }
}
