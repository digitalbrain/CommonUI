//
//  UITableViewExtension.swift
//  
//
//  Created by Massimiliano on 04/04/2019.
//  Copyright © 2019 Massimiliano Schinco. All rights reserved.
//

import UIKit

public extension UITableView {
    /**
     Assume that the class type and the identifier are the same
     */
    func dequeue<T: UITableViewCell>(classType: T.Type, identifier: String? = nil) -> T? {
        return self.dequeueReusableCell(withIdentifier: identifier ?? T.defaultIdentifier ) as? T
    }
    
    func createOrDequeue<T: UITableViewCell>(classType: T.Type, identifier: String? = nil) -> T {
        return self.dequeue(classType: classType, identifier: identifier) ?? T.loadFromNib()!
    }
}
