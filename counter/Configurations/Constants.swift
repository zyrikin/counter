//
//  Constants.swift
//  oupai
//
//  Created by Nik Zakirin on 14.2.16.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Margin {
        static let Top: CGFloat = 15
        static let Left: CGFloat = 15
        static let Bottom: CGFloat = 15
        static let Right: CGFloat = 15
    }
    
    struct Layer {
        static let cornerRadius: CGFloat = 4.0
        static let borderWidth: CGFloat = 1/UIScreen.main.scale
        static let borderColor: CGColor = UIColor.hairline.cgColor
        static let shadowColor: CGColor = UIColor.black.cgColor
        static let shadowRadius: CGFloat = 2.0
        static let shadowOffset: CGSize = CGSize(width: 0, height: 1)
        static let shadowOpacity: Float = 0.1
    }
    
    struct Seconds {
        static let oneMinute: TimeInterval = 60
        static let oneHour: TimeInterval = 60 * 60
        static let oneDay: TimeInterval = 60 * 60 * 24
    }
    
    enum SupportedLanguages: String {

        case English = "en"
        case Finnish = "fi"
        
        static let allValues = [English, Finnish]
        
        var description: String {
            switch self {
            case .English:
                return "English"
            case .Finnish:
                return "Suomi"
            }
        }
    }
    
    enum UILanguages: String {
        
        case English = "English"
        case Finnish = "Suomi"
        
        static let allValues = [English.rawValue, Finnish.rawValue]
        
        var description: String {
            switch self {
            case .English:
                return "en"
            case .Finnish:
                return "fi"
            }
        }
    }
}
