//
//  SettingsViewController.swift
//  counter
//
//  Created by Nik Zakirin on 25/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit

private enum Section: String {
    case language, resetEvents
}

private enum Row: String {
    case LanguageCell, ResetEventscell
}

final class SettingsViewController: NZBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.commonSetUp()
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: Row.LanguageCell.rawValue)
        
        title = "Settings".localized
        
        prepareTableViewSections()
        tableView.reloadData()
    }

    override func prepareTableViewSections() {
        super.prepareTableViewSections()
        
        addSection(Section.language.rawValue) { (section) in
            section.headerView = SectionHeaderView(title: "Language".localized)
            
            let supportedLanguages = Constants.SupportedLanguages.allValues
            let currentLanguage = ProfileSettings.appLanguage().description
            for language in supportedLanguages {
                section.addRow(Row.LanguageCell.rawValue, height: 60, configure: { row in
                    row.data = [
                        "language": language.description,
                        "selected": language.description == currentLanguage.description
                    ]
                })
            }
        }
    }
}

// MARK:- UITableViewDataSource/Delegate methods
extension SettingsViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = getRow(indexPath) else { return defaultCell(indexPath) }
        
        switch row.name {
            
        case Row.LanguageCell.rawValue:
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: row.name, for: indexPath) as? BaseTableViewCell {
                guard let data = row.data as? [String: Any] else { return defaultCell(indexPath) }
                
                cell.textLabel?.text = data["language"] as? String
                
                if let isSelected = data["selected"] as? Bool {
                    cell.accessoryType = isSelected ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.none
                }
                return cell
            }
            
        default:
            break
        }
        
        return defaultCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = getRow(indexPath) else { return }
        
        switch row.name {
            
        case Row.LanguageCell.rawValue:
            if let cell = tableView.cellForRow(at: indexPath) as? BaseTableViewCell,
                let text = cell.textLabel?.text,
                let uiLanguage = Constants.UILanguages(rawValue: text),
                let appLanguage = Constants.SupportedLanguages(rawValue: uiLanguage.description) {
                ProfileSettings.setAppLanguage(appLanguage)
            }
            
        default:
            break
        }
    }
}
