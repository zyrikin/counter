//
//  Theme.swift
//  oupai
//
//  Created by Nik Zakirin on 7.3.17.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import UIKit

enum ColorScheme {
    case darkTheme
    case lightTheme
}

class Theme {
    static var appColorScheme: ColorScheme = .darkTheme {
        didSet {
            Theme.configureThemeForColorScheme(appColorScheme)
            Theme.stylizeHUD()
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
        let textColor: UIColor
        
        switch colorScheme {
        case .darkTheme:
            tintColor = .darkBackgroundColor()
            textColor = .white
        case .lightTheme:
            tintColor = .primaryColor();
            textColor = .white
        }
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = tintColor
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: textColor,
            NSFontAttributeName: UIFont.defaultFont(CGFloat(17))
        ]
        
//        // Hide hairline
//        UINavigationBar.appearance().translucent = false
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage.imageWithColor(tintColor), forBarMetrics: .Default)
    }
    
    class func stylizeTabBarForColorScheme(_ colorScheme: ColorScheme) {
        
        let tintColor: UIColor
        let barTintColor: UIColor
        
        switch colorScheme {
        case .darkTheme:
            tintColor = .primaryColor();
            barTintColor = .white
        case .lightTheme:
            tintColor = .primaryColor();
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
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [OUNavigationController.self]).setBackgroundImage(backImage, for: .normal, barMetrics: .default)
    }
    
    class func stylizeTextInputsForColorScheme(_ colorScheme: ColorScheme) {
        UITextField.appearance().tintColor = UIColor.primaryColor()
        UITextView.appearance().tintColor = UIColor.primaryColor()
    }
}
