//
//  ViewController.swift
//  CommonUI
//
//  Created by digitalbrain@hotmail.it on 04/11/2018.
//  Copyright (c) 2018 digitalbrain@hotmail.it. All rights reserved.
//

import UIKit
import CommonUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func showAlert() {
        AlertViewController.show(withTitle: "Example", message: "This is a test message", buttonTitles: ["Option one", "Option two"], cancelButton: nil) { (sender) in
            
        }
    }
    
    @IBAction func goGoogle() {
        let url = URL(string:"https://www.google.com")
        let webVc = WebViewController.create(url: url!)
        webVc.show(fromVC: self)
    }
    
    
    @IBAction func showGallery() {
        
        let gallery = GalleryViewController()
        gallery.numberOfItem = 10
        gallery.configureItem = { (cell: GalleryCell, index: IndexPath) in
            let image = UIImage(named:"\(index.item).png")
            cell.imageView.image = image
    
        }
        self.present(gallery, animated: true, completion: nil)
        
    }
}

