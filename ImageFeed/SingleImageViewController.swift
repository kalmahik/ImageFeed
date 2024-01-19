//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Admin on 19.01.2024.
//

import UIKit

class SingleImageViewController: UIViewController {
    var image: UIImage!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
    }
}
