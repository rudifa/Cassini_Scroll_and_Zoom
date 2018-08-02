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
            // fetching might take a long time and block the Main queue, so dispatch it
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents, url == self?.imageURL { // url == self?.imageURL: or did url change in the meantime?
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: imageData) // UI stuff onto the main queue!
                    }
                }
            }
        }
    }

    @IBAction func doubleTap(_ sender: UITapGestureRecognizer) {
        print("doubleTap")
        fetchImage()
    }

    // view

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 10.0 // note - for scale < 1, needs centering
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
//        imageURL = DemoURL.Stanford! as URL
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("--- ImageViewController: viewWillAppear", imageURL as Any)
//        if image == nil {
            fetchImage()
//        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       print("--- ImageViewController: viewWillDisappear")
    }

}

extension ImageViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
