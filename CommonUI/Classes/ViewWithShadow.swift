//
//  ViewWithShadow.swift
//  CommonUI
//
//  Created by Massimiliano on 12/10/2018.
//

import UIKit

@IBDesignable

open class ViewWithShadow: UIView {
    
    
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowRadius: CGFloat = 1.0
    @IBInspectable var shadowOpacity: CGFloat = 1.0
    @IBInspectable var shadowXOffset: CGFloat = 1.0
    @IBInspectable var shadowYOffset: CGFloat = 1.0
    
    private var shadowLayer: CAShapeLayer!
    
    override open func layoutSubviews() {
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        super.layoutSubviews()
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
            shadowLayer.fillColor = self.backgroundColor?.cgColor ?? UIColor.white.cgColor
            
            shadowLayer.shadowColor = self.shadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: self.shadowXOffset, height: self.shadowYOffset)
            shadowLayer.shadowOpacity = Float(self.shadowOpacity)
            shadowLayer.shadowRadius = self.shadowRadius
            self.layer.insertSublayer(shadowLayer, at: 0)
            
        } else {
            shadowLayer.removeFromSuperlayer()
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: CGRect(x:self.bounds.origin.x,y:self.bounds.origin.y - self.shadowYOffset - 1 ,width:self.bounds.width, height: self.bounds.height + shadowYOffset*2), cornerRadius: self.cornerRadius).cgPath
            shadowLayer.fillColor = self.backgroundColor?.cgColor ?? UIColor.white.cgColor
            
            shadowLayer.shadowColor = self.shadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: self.shadowXOffset, height: self.shadowYOffset)
            shadowLayer.shadowOpacity = Float(self.shadowOpacity)
            shadowLayer.shadowRadius = self.shadowRadius
            self.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
}


