//
//  LinearLoader.swift
//  Yess
//
//  Created by Massimiliano on 03/04/17.
//  Copyright © 2017 Digital Brain. All rights reserved.
//

import UIKit

class LinearLoader: UIView {

    var timer: Timer?
    
    func startAnimating() {
        self.stopAnimating()
        self.alpha = 1
        self.cornerRadius = 2
        self.transform = CGAffineTransform(scaleX: 0.00001, y: 1)
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
    }
    
    
    func stopAnimating()  {
        self.alpha = 0
        self.timer?.invalidate()
    }
    
    
    @objc func animate() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.transform = .identity
            self.alpha = 0.5
        }) { (finish) in
           DispatchQueue.main.async {
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.00001, y: 1)
                     self.alpha = 1
                }, completion: nil)

            }
        }
    }

}
