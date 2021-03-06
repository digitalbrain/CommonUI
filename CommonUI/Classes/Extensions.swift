//
//  Created by DigitalBrain on 10/04/18.
//  Copyright © 2018 Massimiliano Schinco. All rights reserved.
//

import UIKit
public extension UIView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = (newValue > 0)
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var rotatioAngle : CGFloat {
        get {
            return 0
        }
        set {
            transform = CGAffineTransform(rotationAngle: newValue / 180 * CGFloat(Double.pi) )
        }
    }
    
    func performShake(direction : Int, shakes : Int) {

        UIView.animate(withDuration: 0.05, animations: { () -> Void in
            self.transform = CGAffineTransform(translationX: 7.0 * CGFloat(direction), y: 0)
            },completion :{ (fish) -> Void in
                if shakes <= 0 {
                    
                    self.transform = CGAffineTransform.identity
                    return;
                }
                let nshakes = shakes - 1
                self.performShake(direction: direction * -1, shakes: nshakes)
        
        })
    }
    
    func add(subview view: UIView , margin: UIEdgeInsets)  {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: margin.top))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: margin.right))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -margin.bottom))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -margin.left))
        self.layoutIfNeeded()
    }

}


public extension UIColor {
    

    func darker() -> UIColor {
        return self.darker(amount: 0.25)
    }
    
    func lighter() -> UIColor {
        return self.lighter(amount: 0.25)
    }
    
    
    func lighter(amount : CGFloat = 0.25) -> UIColor {
        return hueColorWithBrightnessAmount(amount: 1 + amount)
    }
    
    func darker(amount : CGFloat = 0.25) -> UIColor {
        return hueColorWithBrightnessAmount(amount:1 - amount)
    }
    
    func hueColorWithBrightnessAmount(amount: CGFloat) -> UIColor {
        var hue         : CGFloat = 0
        var saturation  : CGFloat = 0
        var brightness  : CGFloat = 0
        var alpha       : CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor( hue: hue,
                            saturation: saturation,
                            brightness: brightness * amount,
                            alpha: alpha )
        } else {
            return self
        }
        
        
    }
    
}

