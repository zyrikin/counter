//
//  Theme.swift
//  oupai
//
//  Created by Nik Zakirin on 7.3.17.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import UIKit
import NZKit

enum ColorScheme {
    case darkTheme
    case lightTheme
}

class Theme {
    static var appColorScheme: ColorScheme = .darkTheme {
        didSet {
            Theme.configureThemeForColorScheme(appColorScheme)
        }
    }
    
    class func configureThemeForColorScheme(_ colorScheme: ColorScheme) {
        Theme.stylizeStatusBarForColorScheme(colorScheme)
        Theme.stylizeNavigationBarForColorScheme(colorScheme)
        Theme.stylizeTabBarForColorScheme(colorScheme)
        Theme.stylizeBarButtonItemForColorScheme(colorScheme)
        Theme.stylizeTextInputsForColorScheme(colorScheme)
    }
}

// MARK:- Internal methods
private extension Theme {
    
    class func stylizeStatusBarForColorScheme(_ colorScheme: ColorScheme) {
        
        let statusBarStyle: UIStatusBarStyle = (colorScheme == .darkTheme) ? .lightContent : .lightContent;
        
        UIApplication.shared.statusBarStyle = statusBarStyle
    }
    
    class func stylizeNavigationBarForColorScheme(_ colorScheme: ColorScheme) {
        
        let tintColor: UIColor
        let barTintColor: UIColor
        let textColor: UIColor
        
        switch colorScheme {
        case .darkTheme:
            tintColor = UIColor.callToAction
            barTintColor = UIColor.darkBackground
            textColor = UIColor.white
        case .lightTheme:
            tintColor = UIColor.callToAction
            barTintColor = UIColor.white
            textColor = UIColor.darkText
        }
        
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().barTintColor = tintColor
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: textColor,
            NSFontAttributeName: UIFont.defaultFont(CGFloat(17))
        ]
        
        // Hide hairline
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage.imageWithColor(UIColor.hairline)
        UINavigationBar.appearance().setBackgroundImage(UIImage.imageWithColor(barTintColor), for: .default)
    }
    
    class func stylizeTabBarForColorScheme(_ colorScheme: ColorScheme) {
        
        let tintColor: UIColor
        let barTintColor: UIColor
        
        switch colorScheme {
        case .darkTheme:
            tintColor = UIColor.primary
            barTintColor = .white
        case .lightTheme:
            tintColor = UIColor.primary
            barTintColor = .white;
        }
        
        UITabBar.appearance().barTintColor = barTintColor;
        UITabBar.appearance().tintColor = tintColor;
        UITabBar.appearance().isTranslucent = false
//        UITabBarItem.appearance().setTitleTextAttributes([
//                NSFontAttributeName: UIFont.defaultFont(CGFloat(9)),
//                NSForegroundColorAttributeName: tintColor], forState: .Normal)
        UITabBar.appearance().backgroundImage = UIImage(named: "tab-bg")
    }
    
    class func stylizeBarButtonItemForColorScheme(_ colorScheme: ColorScheme) {
        
        let backImage = UIImage(named: "first");
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self]).setBackgroundImage(backImage, for: .normal, barMetrics: .default)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self])
            .setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.callToAction], for: .normal)
    }
    
    class func stylizeTextInputsForColorScheme(_ colorScheme: ColorScheme) {
        UITextField.appearance().tintColor = UIColor.primary
        UITextView.appearance().tintColor = UIColor.primary
    }
}
