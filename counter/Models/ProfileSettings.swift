//
//  ProfileSettings.swift
//  oupai
//
//  Created by Nik Zakirin on 01/03/16.
//  Copyright © 2016 Oupai365. All rights reserved.
//

import Foundation

private enum ProfileSettingsConst: String {
    case kAppLanguage
    case kAppCurrency
}

final class ProfileSettings {
    
    class func appLanguage() -> Constants.SupportedLanguages {
        /*  Prefer user selected language if available
         *  Otherwise, fallback to device locale */
        if let code = UserDefaults.standard.object(forKey: ProfileSettingsConst.kAppLanguage.rawValue) as? String,
            let language = Constants.SupportedLanguages(rawValue: code) {
            return language
        } else {
            if let deviceLanguage = Bundle.preferredLocalizations(from: supportedLanguages).first,
                let code = Constants.SupportedLanguages(rawValue: deviceLanguage) {
                return code
            } else {
                return Constants.SupportedLanguages.English
            }
        }
    }
    
    class func setAppLanguage(_ code: Constants.SupportedLanguages) {
        
        let previousAppLanguage = appLanguage().rawValue
        
        // Persist app language
        UserDefaults.standard.set(code.rawValue, forKey: ProfileSettingsConst.kAppLanguage.rawValue)
        UserDefaults.standard.synchronize()
        
        // Update localization table
        Localization.sharedInstance.setLocale(code.rawValue)
        
        // Broadcast if language changed
        if previousAppLanguage != code.rawValue {
            NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.ApplicationLanguageChanged.rawValue), object: nil)
        }
    }
    
    /// These codes should correspond to the Localizable.strings file name
    static var supportedLanguages: [String] = [
        "en",
        "fi"
    ]
    
    class var languageMapping: [String: String]! {
        
        guard let
            path = Bundle.main.path(forResource: "languages", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            else { return nil }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
            guard let languages = json as? NSArray else { return nil }
    
            var mapping = [String: String]()
            for language in languages {
                if let
                    language = language as? [String: String],
                    let code = language["code"],
                    let name = language["name"] {
                    mapping[code] = name
                }
            }
            return mapping
            
        } catch {
            return nil
        }
    }
}
