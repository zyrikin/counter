//
//  UIFont+Additions.swift
//  oupai
//
//  Created by Nik Zakirin on 7.3.17.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func defaultFont(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
//        return (UIFont(name: "OpenSans", size: size))!
    }
    
    class func defaultBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
//        return (UIFont(name: "OpenSans-Semibold", size: size))!
    }
    
    class func defaultHeavyFont(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
//        return (UIFont(name: "OpenSans-Bold", size: size))!
    }
    
    class func defaultLightFont(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
//    class func defaultLightFont(_ size: CGFloat) -> UIFont {
//        return (UIFont(name: "OpenSans-Light", size: size))!
//    }
//    
//    class func defaultItalicFont(_ size: CGFloat) -> UIFont {
//        return (UIFont(name: "OpenSans-Italic", size: size))!
//    }
//    
//    class func defaultLightItalicFont(_ size: CGFloat) -> UIFont {
//        return (UIFont(name: "OpenSansLight-Italic", size: size))!
//    }
//    
//    class func defaultSemiBoldItalicFont(_ size: CGFloat) -> UIFont {
//        return (UIFont(name: "OpenSans-SemiboldItalic", size: size))!
//    }
}
