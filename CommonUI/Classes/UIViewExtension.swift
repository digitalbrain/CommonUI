//
//  UIView+Load.swift
//  
//
//  Created by Massimiliano on 04/04/2019.
//  Copyright © 2019 Massimiliano Schinco. All rights reserved.
//

import UIKit

public extension UIView {
    
    private class func instantiate<T: UIView>(nibNamed: String) -> T? {
        return Bundle.main.loadNibNamed(nibNamed, owner: self, options: nil)?.first as? T
    }
    
    class var nibName: String {
        return String(describing: self.self)
    }
    
    class func loadFromNibNamed(nibNamed: String) -> Self? {
        return instantiate(nibNamed: nibNamed)
    }
    /**
     Load View from Nib with filename that is the same of Class Name
     */
    class func loadFromNib() -> Self? {
        return instantiate(nibNamed: self.nibName)
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    func shakeAnimation(direction : Int = 1, shakes : Int = 5) {
        UIView.animate(withDuration: 0.05, animations: { () -> Void in
            self.transform = CGAffineTransform(translationX: 7.0 * CGFloat(direction), y: 0)
        },completion :{ (fish) -> Void in
            if shakes <= 0 {
                self.transform = CGAffineTransform.identity
                return;
            }
            let nshakes = shakes - 1
            self.shakeAnimation(direction: direction * -1, shakes: nshakes)
        })
    }
    
    func add(subview view: UIView , top: CGFloat, left: CGFloat, right: CGFloat)  {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: top))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: right))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -left))
        self.layoutIfNeeded()
    }

    func add(subview view: UIView , margin: UIEdgeInsets, height: CGFloat)  {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: margin.top))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: margin.right))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -margin.left))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height))
        self.layoutIfNeeded()
    }
    
    func db_setHeightConstrainConstant(_ value:CGFloat) {
        for i in 0  ..< self.constraints.count {
            let lc = self.constraints[i]
            if lc.firstItem as? NSObject == self && lc.firstAttribute == .height && lc.secondAttribute == .notAnAttribute {
                lc.constant = value
            }
        }
    }
}

extension UIButton {
    
    @IBInspectable var switchModeEnabled: Bool {
        get {
            return true
        }
        set {
            if newValue {
                self.addTarget(self, action: #selector(self.switchAction), for: .touchUpInside)
            }
        }
    }
    
    
    @IBAction func switchAction() {
        self.isSelected = !self.isSelected
    }
}
