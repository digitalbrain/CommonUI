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

    @IBAction func showAlert() {
        AlertViewController.show(withTitle: "Example", message: "This is a test message", buttonTitles: ["Option one", "Option two"], cancelButton: nil) { (sender) in
            
        }
    }
}

