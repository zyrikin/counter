//
//  UIColor+Additions.swift
//  oupai
//
//  Created by Nik Zakirin on 01/01/16.
//  Copyright © 2016 Oupai365. All rights reserved.
//

import Foundation
import NZKit

extension UIColor {
    
    class var primary: UIColor {
        return UIColor(rgb: 0xffffff)
    }
    
    class var effect: UIColor {
        return UIColor(rgb: 0x54c7fc)
    }
    
    class var background: UIColor {
        return UIColor(rgb: 0x404040)
    }
    
    class var hairline: UIColor {
        return UIColor(rgb: 0x4d4d4d)
    }
    
    class var destructive: UIColor {
        return UIColor(rgb: 0xca5253)
    }
    
    class var tableViewCellPrimaryText: UIColor {
        return UIColor.darkGray
    }
    
    class var tableViewCellSecondaryText: UIColor {
        return UIColor.gray
    }
    
    class var facebook: UIColor {
        return UIColor(rgb: 0x3b5998)
    }
}

// MARK:- These methods are called based on the selected theme
extension UIColor {
    class var darkBackground: UIColor {
        return UIColor(rgb: 0x333333)
    }
    
    class var lightBackground: UIColor {
        return UIColor(rgb: 0xeaedea)
    }
    
    class var callToAction: UIColor {
        return UIColor.effect
    }
    
    class var label1: UIColor {
        return UIColor.white
    }
    
    class var label2: UIColor {
        return UIColor.white.withAlphaComponent(0.6)
    }
    
    class var label3: UIColor {
        return UIColor.white.withAlphaComponent(0.4)
    }
    
    class var disclosure: UIColor {
        return UIColor(rgb: 0xc7c7cc)
    }
}

// MARK:- Notifications
extension UIColor {
    class var notificationSuccess: UIColor {
        return UIColor.callToAction
    }
    
    class var notificationFailure: UIColor {
        return UIColor(rgb: 0xdb151d)
    }
}
