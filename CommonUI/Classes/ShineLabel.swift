//
//  ShineLabel.swift
//  NuminaSDK_Test
//
//  Created by Massimiliano on 23/04/18.
//  Copyright © 2018 Massimiliano Schinco. All rights reserved.
//

import UIKit

open class ShineLabel: UILabel {
    var attributedString: NSMutableAttributedString?
    var characterAnimationDurations = [Double]()
    var characterAnimationDelays = [Double]()
    var displaylink: CADisplayLink?
    var beginTime: CFTimeInterval = 0
    var endTime: CFTimeInterval = 0
    var isFadedOut = false
    var completion: (() -> Void)?
    var fadeoutDuration: CFTimeInterval = 0.5
    var singleLetterDuration: CFTimeInterval = 0.02
    var isAutoStart = false
    var isShining: Bool {
        return self.displaylink?.isPaused ?? false
    }
    var isVisible: Bool {
        return false == isFadedOut
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setText(text)
    }
    
    internal func commonInit() {
        singleLetterDuration = 0.02
        fadeoutDuration = 0.5
        isAutoStart = false
        isFadedOut = true
        textColor = self.textColor ?? UIColor.white
        characterAnimationDurations = []
        characterAnimationDelays = []
        displaylink = CADisplayLink(target: self, selector: #selector(self.updateAttributedString))
        displaylink?.isPaused = true
        displaylink?.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    
    override open func didMoveToWindow() {
        if nil != window && isAutoStart {
            shine()
        }
    }
    
    open func startAnimation(withDuration duration: CFTimeInterval) {
        self.beginTime = CACurrentMediaTime()
        self.endTime = TimeInterval(beginTime + singleLetterDuration * Double(attributedText?.length ?? 0))
        self.displaylink?.isPaused = false
    }
 
    open func setText(_ text: String?) {
        self.setAttributedText(NSAttributedString(string: text ?? ""))
    }
    
    open func setAttributedText(_ attributedText: NSAttributedString?) {
      
        attributedString = initialAttributedString(from: attributedText)
        super.attributedText = attributedString
        characterAnimationDelays = []
        characterAnimationDurations = []
        for i in 0..<(attributedText?.length ?? 0) {
            characterAnimationDelays.append(Double(i) * singleLetterDuration)
            characterAnimationDurations.append(singleLetterDuration)
        }
    }
    
    open func shine() {
        shine(withCompletion: nil)
    }
    
    open func shine(withCompletion completion: (() -> ())?) {
        self.completion = completion
        isFadedOut = false
        self.startAnimation(withDuration: singleLetterDuration * Double(attributedText?.length ?? 0))
    }
    
    open func fadeOut() {
        fadeOut(withCompletion: nil)
    }
    
    open func fadeOut(withCompletion completion:(()->())?) {
        if !isShining && !isFadedOut {
            self.completion = completion
            // self.fadedOut = YES;
            UIView.animate(withDuration: TimeInterval(fadeoutDuration), animations: {() -> Void in
                self.alpha = 0
            }, completion: {(_ finished: Bool) -> Void in
                DispatchQueue.main.async(execute: {() -> Void in
                    self.setAttributedText(self.attributedString)
                    self.alpha = 1
                    completion?()
                  
                })
            })
        }
    }
    
    @objc func updateAttributedString() {
        let now: CFTimeInterval = CACurrentMediaTime()
        for i in 0 ..< (attributedString?.length ?? 0) {

            attributedString?.enumerateAttribute(NSAttributedString.Key.foregroundColor, in: NSRange(location: i, length: 1), options: .longestEffectiveRangeNotRequired, using: { (value, range, stop) in
                
                let color = value as? UIColor
                let currentAlpha: CGFloat =  color?.cgColor.alpha ?? 1
                let shouldUpdateAlpha: Bool = (self.isFadedOut && currentAlpha > 0) || (!self.isFadedOut && currentAlpha < 1) || ((now - self.beginTime)) >= (self.characterAnimationDelays[i])
                if !shouldUpdateAlpha {
                    return
                }
                var percentage = CGFloat((Float(now - self.beginTime) - Float(self.characterAnimationDelays[i])) / (Float(self.characterAnimationDurations[i])))
                if self.isFadedOut {
                    percentage = 1 - percentage
                }
                let aColor: UIColor = self.textColor.withAlphaComponent(percentage)
             
                self.attributedString?.addAttribute(NSAttributedString.Key.foregroundColor, value: aColor, range: range)
                
            })
         
        }
        super.attributedText = attributedString
        if now > endTime {
            displaylink?.isPaused = true
            completion?()
        }
    }
    
    open func initialAttributedString(from attributedString: NSAttributedString?) -> NSMutableAttributedString? {
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString ?? NSAttributedString())
        let color: UIColor? = textColor.withAlphaComponent(0)
        if let aColor = color {
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: aColor, range: NSRange(location: 0, length: mutableAttributedString.length ))
        }
        return mutableAttributedString
    }
}
