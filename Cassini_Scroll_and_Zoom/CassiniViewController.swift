//
//  CassiniViewController.swift
//  Cassini_Scroll_and_Zoom
//
//  Created by Rudolf Farkas on 02.08.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare(for segue:", DemoURL.NASA)
        print("prepare(for segue:", segue.identifier as Any)
        if let url = DemoURL.NASA[segue.identifier ?? ""] {
            print("prepare(for segue:", url as Any)
           if let imageVC = (segue.destination.contents as? ImageViewController) {
                imageVC.imageURL = url! as URL
                imageVC.title = (sender as? UIButton)?.currentTitle
            }
        }

    }
}

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
