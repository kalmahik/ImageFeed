//
//  ImagesListCellDelegate.swift
//  ImageFeed
//
//  Created by Murad Azimov on 10.03.2024.
//

import Foundation

protocol ImagesListCellDelegate: AnyObject {
    func didTapLike(_ cell: ImagesListCell)
}
