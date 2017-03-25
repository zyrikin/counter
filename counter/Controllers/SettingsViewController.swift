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
    case language, reset
}

private enum Row: String {
    case LanguageCell, ResetEventsCell
}

final class SettingsViewController: NZBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.commonSetUp()
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: Row.LanguageCell.rawValue)
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: Row.ResetEventsCell.rawValue)
        
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
        
        addSection(Section.reset.rawValue) { (section) in
            section.headerView = SectionHeaderView(title: "")
            section.headerHeight = 30
            
            section.addRow(Row.ResetEventsCell.rawValue, configure: { (row) in
                row.data = "Delete All Events".localized
            })
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
            
        case Row.ResetEventsCell.rawValue:
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: row.name, for: indexPath) as? BaseTableViewCell {
                cell.textLabel?.text = row.data as? String
                return cell
            }
            
        default:
            break
        }
        
        return defaultCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = getSection(indexPath) else { return }
        
        switch section.name {
        
        case Section.reset.rawValue:
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor.white
            cell.contentView.backgroundColor = UIColor.destructive
            cell.selectedBackgroundView = {
                let view = UIView()
                view.backgroundColor = UIColor.destructive.darkerColor(0.3)
                return view
            }()

            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let row = getRow(indexPath) else { return }
        
        switch row.name {
            
        case Row.LanguageCell.rawValue:
            if let cell = tableView.cellForRow(at: indexPath) as? BaseTableViewCell,
                let text = cell.textLabel?.text,
                let uiLanguage = Constants.UILanguages(rawValue: text),
                let appLanguage = Constants.SupportedLanguages(rawValue: uiLanguage.description) {
                ProfileSettings.setAppLanguage(appLanguage)
            }
            
        case Row.ResetEventsCell.rawValue:
            EventService.shared.removeAllEvents()
            
        default:
            break
        }
    }
}
