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
        
        title = "Overview".localized
        
        tableView.commonSetUp()
        prepareTableViewSections()
    }

    override func prepareTableViewSections() {
        super.prepareTableViewSections()
        
        addSection(Section.sessions.rawValue) { section in
            let headerTitle = "Sessions".localized.uppercased()
            section.headerView = SectionHeaderView(title: headerTitle)
            
            section.addRow(Row.AddSessionCell.rawValue, height: 60, configure: { row in
                row.data = "Create Session".localized
            })
        }
        
        addSection(Section.events.rawValue) { section in
            let headerTitle = "Events".localized.uppercased()
            section.headerView = SectionHeaderView(title: headerTitle)
            
            section.addRow(Row.AddEventCell.rawValue, height: 60, configure: {row in
                row.data = "Add Event".localized
            })
        }
    }
    
    @IBAction func prepareForUnWind(segue: UIStoryboardSegue) {}
}

// MARK:- UITableViewDataSource methods
extension MainViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = getRow(indexPath) else { return defaultCell(indexPath) }
        
        switch row.name {
        
        case Row.AddSessionCell.rawValue, Row.AddEventCell.rawValue:
            
            let cell: ButtonTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.buttonLabel.text = row.data as? String
            return cell
        
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
        
        guard let row = getRow(indexPath) else { return }
        
        switch row.name  {
        case Row.AddSessionCell.rawValue:
            performSegue(withIdentifier: "ShowCreateSession", sender: self)
        case Row.AddEventCell.rawValue:
            performSegue(withIdentifier: "ShowAddEvent", sender: self)
        default:
            return
        }
    }
}
