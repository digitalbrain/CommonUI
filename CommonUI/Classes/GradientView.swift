//
//  UIView+Gradient.swift
//  LottomaticaBollettinoDemo
//
//  Created by Massimiliano on 05/07/18.
//  Copyright © 2018 Massimiliano Schinco. All rights reserved.
//

import UIKit
@IBDesignable
public class GradientView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    @IBInspectable public var color1: UIColor = .white { didSet { configureGradient() } }
    @IBInspectable public var color2: UIColor = .blue  { didSet { configureGradient() } }
    @IBInspectable public var degrees: CGFloat = 0     { didSet { configureGradient() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradient()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    private func configureGradient() {
        
       // y = mx

        let x: CGFloat = self.degrees / 360.0
        

        /*let a = pow(sin(Float(2.0 * .pi * ((x + 0.75) / 2.0))),2.0)
        let b = pow(sinf(Float(2 * Float.pi * ((x+0.0)/2))),2);
        let c = pow(sinf(Float(2 * Float.pi*((x+0.25)/2))),2);
        let d = pow(sinf(Float(2*.pi*((x+0.5)/2))),2);*/
        
     
        let a = pow(sin(CGFloat(2.0 * .pi * ((x + 0.75) / 2.0))), 2.0)
        let b = pow(sin(CGFloat(2.0 * .pi * ((x + 0.0) / 2.0))),2.0);
        let c = pow(sin(CGFloat(2.0 * .pi * ((x + 0.25) / 2.0))),2.0);
        let d = pow(sin(CGFloat(2.0 * .pi * ((x + 0.5) / 2.0))),2.0);
        gradientLayer.endPoint = CGPoint(x: CGFloat(c),y: CGFloat(d))
        gradientLayer.startPoint = CGPoint(x: CGFloat(a),y:CGFloat(b))
  
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
    
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}


extension FloatingPoint {
    var toRadians: Self { return self * .pi / 180 }
    var toDegrees: Self { return self * 180 / .pi }
}
