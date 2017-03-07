//
//  Localization.swift
//  oupai
//
//  Created by Nik Zakirin on 28.2.16.
//  Copyright © 2016 Oupai365. All rights reserved.
//

import Foundation

final class Localization {
    
    static let sharedInstance = Localization()
    
    fileprivate var localizationTable = [String: String]()
    
    // MARK: - Public functions
    func setLocale(_ locale: String) {
        loadBaseLocalizations(locale: locale)
        
        loadTargetLocalizations(locale: locale)
    }
    
    func localizedStringForKey(_ key: String) -> String {
        return localizationTable[key] ?? ""
    }
    
    // MARK: - Private functions
    private func loadBaseLocalizations(locale: String) {
        localizationTable = getLocalizations(filename: "Localizable.strings", locale: locale)
    }
    
    private func loadTargetLocalizations(locale: String) {
        var localizationFilename: String?
        
        #if OUPAI
            localizationFilename = "Oupai.strings"
        #endif
        
        if let filename = localizationFilename {
            let localizations = getLocalizations(filename: filename, locale: locale)
            
            localizations.forEach { key, value in
                localizationTable[key] = value
            }
        }
    }
    
    private func getLocalizations(filename: String, locale: String) -> [String: String] {
        let directory = String(format: "%@.lproj", arguments: [locale])
        
        guard let path = Bundle.main.path(forResource: filename, ofType: "", inDirectory: directory) else {
            fatalError("Unable to find \(filename)")
        }
        
        guard let dict = NSDictionary(contentsOfFile: path) as? [String: String] else {
            fatalError("Unable to import translations from \(path)")
        }
        
        return dict
    }
}
