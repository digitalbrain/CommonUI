//
//  UIDeviceExtension.swift
//  
//
//  Created by Massimiliano on 13/05/2019.
//  Copyright © 2019 Massimiliano Schinco. All rights reserved.
//

import Foundation
import  UIKit
public extension UIDevice {
    
    var isIpad: Bool {
        return self.userInterfaceIdiom == .pad 
    }
    
    static var is_iPad: Bool {
        return UIDevice.current.isIpad
    }
}
