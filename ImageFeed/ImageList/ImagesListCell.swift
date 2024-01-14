//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Murad Azimov on 11.01.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: cellInsets)
        contentView.layer.cornerRadius = 16
        contentView.frame = contentView.frame.inset(by: cellInsets)
    }
}
