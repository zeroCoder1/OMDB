//
//  UIViewExtensions.swift
//  testOmdb
//
//  Created by shrutesh sharma on 25/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fadeIn(_ duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {
        (finished: Bool) -> Void in }) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(_ duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {
        (finished: Bool) -> Void in }) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    func addShadow(_ offeset:CGSize, cornerRadius:CGFloat, shadowColor:CGColor)  {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = offeset
        self.layer.shadowRadius = 3.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
}
