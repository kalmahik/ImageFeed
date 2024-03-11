//
//  UIPanZoomImageView.swift
//  ImageFeed
//
//  Created by Admin on 23.01.2024.
//

import UIKit
import Kingfisher

class UIPanZoomImageView: UIScrollView {

    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    convenience init(photo: Photo?) {
        self.init(frame: .zero)
        guard let photo else { return }
        imageView.kf.setImage(with: URL(string: photo.largeImageURL))
        imageView.kf.indicatorType = .activity
    }

    private func commonInit() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        minimumZoomScale = 1
        maximumZoomScale = 3
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delegate = self

        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapRecognizer)
    }

    @objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        setZoomScale(zoomScale == 1 ? 2 : 1, animated: true)
    }
}

extension UIPanZoomImageView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { imageView }
}
