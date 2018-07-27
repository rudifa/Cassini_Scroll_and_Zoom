//
//  ImageViewController.swift
//  Cassini_Scroll_and_Zoom
//
//  Created by Rudolf Farkas on 27.07.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    // model
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }

    private func fetchImage() {
        if let url = imageURL {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                image = UIImage(data: imageData)
            }
        }
    }


    // view

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 10.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }

    fileprivate var imageView = UIImageView()

    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageURL = DemoURL.Stanford! as URL
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }

    private func centerScrollViewContents() {
        imageView.frame.origin.x = max(0, (scrollView.bounds.width - imageView.frame.size.width) / 2)
        imageView.frame.origin.y = max(0, (scrollView.bounds.height - imageView.frame.size.height) / 2)
    }

}
