//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Murad Azimov on 11.01.2024.
//

import UIKit
import LinkPresentation

class SingleImageViewController: UIViewController {
    var imageName: String!
    
    @IBOutlet private weak var zoomImageView: PanZoomImageView!
    
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareImageButton(_ sender: UIButton) {
        let image = UIImage(named: imageName)!
        let activityViewController = UIActivityViewController(activityItems: [image, self], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        zoomImageView.imageName = imageName
    }
    
}

extension SingleImageViewController: UIActivityItemSource {
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let image = UIImage(named: imageName)!
        let imageProvider = NSItemProvider(object: image)
        let metadata = LPLinkMetadata()
        metadata.imageProvider = imageProvider
        return metadata
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "123"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return nil
    }
}

