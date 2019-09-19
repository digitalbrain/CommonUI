//
//  UIViewExtension.swift
//
//
//  Created by Massimiliano on 22/03/2019.
//  Copyright © 2019 Massimiliano Schinco. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    static var defaultStoryboardID: String {
        return String(describing: self.self)
    }
    
    var isModal: Bool {
        return self.presentingViewController != nil
    }
    

    
    @IBAction func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }

    func presentInsideNavigationFrom(parent: UIViewController, style: NavigationControllerStyle , transparent: Bool = false, popOverOnIpad: Bool = false) {
        let navigationController = UINavigationController.create(transparent: transparent, rootVc: self, style: style)
        if popOverOnIpad && UIDevice.is_iPad == true {
            navigationController.modalPresentationStyle = .popover
            navigationController.modalTransitionStyle = .coverVertical
            navigationController.preferredContentSize = CGSize(width: 400, height: 650)
            navigationController.popoverPresentationController?.sourceView = parent.view
            navigationController.popoverPresentationController?.sourceRect = CGRect(x: parent.view.bounds.midX, y: parent.view.bounds.midY, width: 0, height: 0)
            navigationController.popoverPresentationController?.permittedArrowDirections = []
        }
        parent.present(navigationController, animated: true, completion: nil)
    }
   
    static var  AppCurrentViewController: UIViewController? {
        get {
            
            var vc = UIApplication.shared.keyWindow?.rootViewController
            while ((vc?.presentedViewController) != nil) {
                vc = vc?.presentedViewController
            }
            return vc
        }
    }
    
    func getChild<T:UIViewController>(type: T.Type) -> T? {
        for child in self.children {
            if let childT = child as? T {
                return childT
            }
        }
        return nil
    }
    
    func parent<T:UIViewController>(type: T.Type) -> T? {
        return self.parent as? T
    }
    
    func enableDismissKeyboardOnTouch() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



extension UINavigationController {
    
    static func create(transparent: Bool = true, rootVc: UIViewController? = nil, style: NavigationControllerStyle ) -> UINavigationController {
        let navigationController = rootVc != nil ? UINavigationController(rootViewController: rootVc!) : UINavigationController()
        navigationController.update(style: style, transparent: transparent)
        navigationController.view.backgroundColor = .white
        return navigationController
    }
    
    func update(style: NavigationControllerStyle, transparent: Bool) {
     
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.shadowImage = UIImage()
        self.isTransparent = transparent
        self.navigationBar.tintColor =  style.backgroudColor
        self.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor :  style.titleColor ?? UIColor.black,
             NSAttributedString.Key.font : style.titleFont ?? UIFont.boldSystemFont(ofSize: 14)];
        
    }
    
    @IBInspectable var isTransparent: Bool {
        get {
            return false
        } set {
            if newValue == true {
                self.navigationBar.setBackgroundImage(UIImage(), for: .default)
                self.navigationBar.shadowImage = UIImage()
                self.navigationBar.isTranslucent = true
            } else {
                self.navigationBar.setBackgroundImage(UIImage(), for: .default)
                self.navigationBar.shadowImage = UIImage()
                self.navigationBar.isTranslucent = false
            }
        }
    }
}

public struct NavigationControllerStyle {
    public var backgroudColor: UIColor?
    public var titleColor: UIColor?
    public var titleFont: UIFont?
    
    public init(backgroudColor: UIColor?, titleColor: UIColor?, titleFont: UIFont?) {
        self.backgroudColor = backgroudColor
        self.titleFont = titleFont
        self.titleColor = titleColor
    }
}
