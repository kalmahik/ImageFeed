//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Murad Azimov on 11.01.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet var like: UIButton!
    @IBOutlet var picture: UIImageView!
    @IBOutlet var date: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: cellInsets)
        contentView.layer.cornerRadius = 16
    }
}
