//
//  String+Additions.swift
//  oupai
//
//  Created by Nik Zakirin on 16/02/16.
//  Copyright © 2016 Oupai365. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var localizedString: String {
        return Localization.sharedInstance.localizedStringForKey(self)
    }
    
    func localizedPluralString(_ count: Int) -> String {
        switch count {
        case 1:
            return Localization.sharedInstance.localizedStringForKey(self+"_one")
        default:
            return Localization.sharedInstance.localizedStringForKey(self+"_many")
        }
    }
    
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    
    var isValidEmail: Bool {
        
        let strictFilter = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//        let laxFilter = ".+@.+\\.[A-Za-z]{2}[A-Za-z]*"
        let emailRegex = strictFilter
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex);
        
        let result = emailTest.evaluate(with: self);
        
        return result
    }
    
    var isValidPassword: Bool {
        return self.characters.count >= 8
    }
    
    func attributedText(
        _ highlightText: String,
        fontSize: CGFloat = 17.0,
        highlightColor: UIColor = .primary,
        highlightFont: UIFont? = nil,
        textColor: UIColor = UIColor.gray,
        font: UIFont? = nil,
        strikethrough: Bool = false
        ) -> NSAttributedString {
        
        var attributes = [NSFontAttributeName : font ?? UIFont.defaultBoldFont(fontSize),
                          NSForegroundColorAttributeName : textColor]
        
        if strikethrough {
            attributes[NSStrikethroughColorAttributeName] = UIColor.red.withAlphaComponent(0.5)
            attributes[NSStrikethroughStyleAttributeName] = NSUnderlineStyle.styleSingle.rawValue as NSNumber
        }
        
        let attStr = NSMutableAttributedString(string: self, attributes: attributes)
        
        let range = (self as NSString).range(of: highlightText, options: .caseInsensitive)
        
        if range.location != NSNotFound {
            let boldedAttributes = [NSFontAttributeName : highlightFont ?? UIFont.defaultHeavyFont(fontSize),
                                    NSForegroundColorAttributeName : highlightColor]
            attStr.addAttributes(boldedAttributes, range: range)
        }
        
        return attStr
    }
    
    static func GUIDString() -> String {
        return UUID().uuidString
    }
}
