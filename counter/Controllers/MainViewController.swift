//
//  MainTableViewController.swift
//  counter
//
//  Created by Nik Zakirin on 11/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit
import SnapKit


private enum Section: String {
    case sessions, events
}

private enum Row: String {
    case AddSessionCell, SessionCell
    case AddEventCell, EventCell
}

final class MainViewController: NZBaseTableViewController {

    var sessions = [Session]()
    var events: [Event] = Array(EventService.shared.events)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.commonSetUp()
        prepareTableViewSections()
    }

    override func prepareTableViewSections() {
        super.prepareTableViewSections()
        
        addSection(Section.sessions.rawValue) { section in
            let headerTitle = "Sessions".uppercased()
            section.headerView = SectionHeaderView(title: headerTitle)
            
            section.addRow(Row.AddSessionCell.rawValue, height: 60, configure: { row in
                row.data = "New Session"
            })
        }
        
        addSection(Section.events.rawValue) { section in
            let headerTitle = "Events".uppercased()
            section.headerView = SectionHeaderView(title: headerTitle)
            
            section.addRow(Row.AddEventCell.rawValue, height: 60, configure: {row in
                row.data = "Add Event"
            })
        }
    }
}

// MARK:- UITableViewDataSource methods
extension MainViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = getRow(indexPath) else { return defaultCell(indexPath) }
        
        switch row.name {
        
        case Row.AddSessionCell.rawValue, Row.AddEventCell.rawValue:
            
            let cell: ButtonTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.buttonLabel.text = row.data as? String
        
        default:
            break
        }
        
        return defaultCell(indexPath)
    }
}


// MARK:- UITableViewDelegate methods
extension MainViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let section = getSection(indexPath) else { return }
        
        switch section.name  {
        case Section.sessions.rawValue:
            return
        default:
            return
        }
    }
}
