//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Admin on 19.01.2024.
//

import UIKit

class SingleImageViewController: UIViewController {
    var imageName: String!
    
    @IBOutlet private var zoomImageView: PanZoomImageView!
    
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomImageView.imageName = imageName
    }
    
}

