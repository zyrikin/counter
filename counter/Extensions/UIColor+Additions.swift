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
        return UIColor(rgb: 0xff3366)
    }
    
    class var effect: UIColor {
        return UIColor(rgb: 0x00d1d8)
    }
    
    class var extra: UIColor {
        return UIColor(rgb: 0xfffd60)
    }
    
    class var background: UIColor {
        return UIColor(rgb: 0xf7f7f8)
    }
    
    class var hairline: UIColor {
        return UIColor(rgb: 0xeeeff2)
    }
    
    class var tableViewCellPrimaryText: UIColor {
        return UIColor.darkGray
    }
    
    class var tableViewCellSecondaryText: UIColor {
        return UIColor.gray
    }
    
    class var outgoingChatBubble: UIColor {
        return UIColor(rgb: 0x00d1d8)
    }
    
    class var incomingChatBubble: UIColor {
        return UIColor(rgb: 0xf7f7f8)
    }
}

// MARK:- These methods are called based on the selected theme
extension UIColor {
    class var darkBackground: UIColor {
        return UIColor(rgb: 0x0f1111)
    }
    
    class var lightBackground: UIColor {
        return UIColor(rgb: 0xeaedea)
    }
    
    class var callToAction: UIColor {
        return UIColor.effect
    }
    
    class var facebook: UIColor {
        return UIColor(rgb: 0x3b5998)
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
