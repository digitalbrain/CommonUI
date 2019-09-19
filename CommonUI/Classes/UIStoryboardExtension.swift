//
//  UIStoryboard.swift
//  
//
//  Created by Massimiliano on 15/04/2019.
//  Copyright © 2019 Massimiliano Schinco. All rights reserved.
//

import Foundation

public extension UIStoryboard {
    static func storyboard(withName name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: Bundle.main)
    }
    
     func viewController <T : UIViewController > (type: T.Type) -> T? {
        return self.instantiateViewController(withIdentifier: T.defaultStoryboardID) as? T
    }
}
