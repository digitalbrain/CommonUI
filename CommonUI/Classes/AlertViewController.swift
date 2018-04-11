//
//  AlertViewController.swift
//  NuminaSDK_Test
//
//  Created by Massimiliano on 10/04/18.
//  Copyright © 2018 Massimiliano Schinco. All rights reserved.
//

import UIKit

open class AlertViewController: UIViewController {
   
    var configuration: AlertViewConfiguration = AlertViewConfiguration()
    
    @IBOutlet weak var titleLbl: UILabel?
    @IBOutlet weak var messageLbl: UILabel?
    @IBOutlet weak var buttonContainer: UIStackView?
    @IBOutlet weak var dialogView: UIView?
    
    var dismissCompletion: ((_ sender: UIButton) -> ())?
    
    private var message: String?
    private var buttonTitles: [String]?
    private var cancelTitle: String?
    

    
    public static func show(withTitle title: String?, message: String?, buttonTitles: [String]? = nil, cancelButton: String? = nil, configuration: AlertViewConfiguration = AlertViewConfiguration(), targetViewController: UIViewController? = nil, completion: ((_ sender: UIButton?) -> ())? = nil) {
        let bundle = Bundle(for: self.self)
       
        if let alert = UIStoryboard(name: "CommonUI.bundle/CommonUI", bundle: bundle).instantiateViewController(withIdentifier: "Alert") as? AlertViewController {
            alert.dismissCompletion = completion
            alert.modalPresentationStyle = .overCurrentContext
            alert.modalTransitionStyle = .crossDissolve
            alert.title = title
            alert.message = message
            alert.configuration = configuration
            alert.buttonTitles = buttonTitles
            alert.cancelTitle = cancelButton
            let targetVC = targetViewController ?? getTopViewController()
            targetVC?.present(alert, animated: true, completion: nil)
        } else {
            
            debugPrint("\n******** CommonUI - Error ********\nAlertViewController can't create alert")
        }

        
    }
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        
    }
    
    open func configure() {
        self.titleLbl?.font = configuration.titleFont
        self.titleLbl?.textColor = configuration.titleColor
        self.messageLbl?.font = configuration.messageFont
        self.messageLbl?.textColor = configuration.messageColor
        self.titleLbl?.text = self.title
        self.messageLbl?.text = self.message
        
        for i in 0 ..< (self.buttonTitles?.count ?? 0) {
            
            let btn = AlertViewControllerHelper.createButton(font: self.configuration.buttonFont, color: self.configuration.buttonTextColor, title: self.buttonTitles?[i] ?? "")
            btn.tag = i
            self.buttonContainer?.addArrangedSubview(btn)
            btn.addTarget(self, action: #selector(dismissDialog(sender:)), for: .touchUpInside)
           
        }
        
        let cancel = AlertViewControllerHelper.createButton(font: configuration.cancelButtonFont, color: configuration.cancelButtonColor, title: self.cancelTitle ?? "Cancel")
        cancel.tag = -1
        self.buttonContainer?.addArrangedSubview(cancel)
        cancel.addTarget(self, action: #selector(dismissDialog(sender:)), for: .touchUpInside)
        
    }
    
    
    @objc open func dismissDialog(sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        self.dismissCompletion?(sender)
    }
    
    
    open override func viewWillAppear(_ animated: Bool) {
        
        self.dialogView?.transform = self.initialTransformFor(animation: self.configuration.animation)
        super.viewWillAppear(animated)
        
        let coordinator = self.transitionCoordinator
        coordinator?.animate(alongsideTransition: { (coordinator) in
            self.dialogView?.transform = .identity
        }, completion: nil)
    }
    
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let coordinator = self.transitionCoordinator
        coordinator?.animate(alongsideTransition: { (coordinator) in
            self.dialogView?.transform = self.initialTransformFor(animation: self.configuration.animation)
        }, completion: nil)
    }
    
    
    func initialTransformFor(animation: AlertViewControllerAnimation) -> CGAffineTransform {
        switch animation {
        case .none:
            return .identity
        case .bottom:
            return CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
        case .top:
            return CGAffineTransform(translationX: 0, y: -self.view.frame.size.height)
        }
    }
}


public struct AlertViewConfiguration {
    
    public var animation: AlertViewControllerAnimation = .bottom
    
    public var titleColor: UIColor = UIColor.black
    public var titleFont: UIFont = UIFont.boldSystemFont(ofSize: 18)

    public var messageColor: UIColor = UIColor.black
    public var messageFont: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)

    public var buttonFont = UIFont.boldSystemFont(ofSize: 17)
    public var buttonTextColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    public var cancelButtonFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
    public var cancelButtonColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    public var backgroudColor: UIColor = UIColor.black.withAlphaComponent(0.8)
    public var dialogBackgroudColor: UIColor = UIColor.white
    public var dialogCornerRadius: CGFloat = 5
    
    public init() {}
}


public enum AlertViewControllerAnimation {
    case none
    case bottom
    case top
}


fileprivate func getTopViewController() -> UIViewController? {
    var topViewController = UIApplication.shared.delegate?.window??.rootViewController
    while (topViewController?.presentedViewController != nil) {
        topViewController = topViewController?.presentedViewController
    }
    return topViewController
}



fileprivate class AlertViewControllerHelper {
    
    static  func createButton(font: UIFont, color: UIColor, title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(color, for: .normal)
        btn.setTitleColor(color.darker(), for: .highlighted)
        btn.titleLabel?.font = font
        btn.setTitle(title, for: .normal)
        
        btn.addConstraint(NSLayoutConstraint(item: btn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44))
        return btn
    }
}
