//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Murad Azimov on 11.01.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    func configCell(_ imageName: String, _ dateText: String, _ isLike: Bool) {
        pictureImageView.image = UIImage(named: imageName)
        dateLabel.text = dateText
        likeButton.tintColor = isLike ? .ypRed : .ypWhite50
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        [pictureImageView, likeButton, gradientView, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        contentView.backgroundColor = .ypBlack
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pictureImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            pictureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            likeButton.topAnchor.constraint(equalTo: pictureImageView.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: pictureImageView.trailingAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 42),
            likeButton.widthAnchor.constraint(equalToConstant: 42),
            dateLabel.bottomAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: -8),
            dateLabel.leadingAnchor.constraint(equalTo: pictureImageView.leadingAnchor, constant: 8),
            gradientView.bottomAnchor.constraint(equalTo: pictureImageView.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: pictureImageView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: pictureImageView.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private let pictureImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        return image
    }()
    
    private let likeButton: UIButton = {
        UIButton.systemButton(
            with: UIImage(systemName: "heart.fill") ?? UIImage(),
            target: nil,
            action: nil
        )
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypWhite
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private let gradientView: UIGradientView = {
        let gradient = UIGradientView()
        gradient.startColor = .gradientStart
        gradient.endColor = .gradientEnd
        gradient.startLocation = 0
        gradient.endLocation = 1
        gradient.layer.cornerRadius = 16
        gradient.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return gradient
    }()
}
