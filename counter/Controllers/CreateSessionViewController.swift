//
//  CreateSessionViewController.swift
//  counter
//
//  Created by Nik Zakirin on 12/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit

protocol CreateSessionControllerDelegate: class {
    func createSession(controller: CreateSessionViewController, didStart session: Session)
}

private enum Mode {
    case new, results
}

private enum Section: String {
    case info, events
}

private enum Row: String {
    case NameCell, EventCell
}

final class CreateSessionViewController: NZBaseTableViewController {
    
    weak var delegate: CreateSessionControllerDelegate?
    fileprivate var mode: Mode = .results
    
    var session: Session?

    override func viewDidLoad() {
        super.viewDidLoad()

        if session == nil {
            title = "New Session".localized
            mode = .new
            session = Session(id: UUID().uuidString, date: Date(), name: "", duration: 0, events: [Event]())
        } else {
            title = "Results".localized
        }
        
        prepareTableViewSections()
    }

    override func setUp() {
        super.setUp()
        tableView.commonSetUp()
        
        tableView.register(InputCell.self)
        tableView.register(UINib.init(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: EventCell.defaultReuseIdentifier)
    }
    
    override func prepareTableViewSections() {
        super.prepareTableViewSections()
        
        addSection(Section.info.rawValue) { section in
            section.headerView = SectionHeaderView(title: "")
            section.headerHeight = 15
            
            section.addRow(Row.NameCell.rawValue, height: 60, configure: { row in
                row.data = [
                    "placeholder": "Name".localized,
                    "value": session?.name
                ]
            })
        }
        
        addSection(Section.events.rawValue) { section in
            let headerTitle = "Events".localized.uppercased()
            section.headerView = SectionHeaderView(title: headerTitle, horizontalInset: 20)
            
            let events = EventService.shared.events
            for event in events {
                section.addRow(Row.EventCell.rawValue, height: 65, configure: { row in
                    row.data = [
                        "value": event
                    ]
                })
            }
        }
    }

    @IBAction func startPressed(_ sender: UIBarButtonItem) {
        tableView.endEditing(true)
        
        guard let session = session else { return }
        
        delegate?.createSession(controller: self, didStart: session)
    }
}

// MARK:- UITableViewDataSource methods
extension CreateSessionViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = getRow(indexPath), let dict = row.data as? [String: Any] else { return defaultCell(indexPath) }
        
        switch row.name {
            
        case Row.NameCell.rawValue:
            
            let cell: InputCell = tableView.dequeueReusableCell(for: indexPath)
            cell.isUserInteractionEnabled = (mode == .new) ? true : false
            cell.inputTextField.placeholder = dict["placeholder"] as? String
            cell.inputTextField.text = dict["value"] as? String
            cell.delegate = self
            return cell
            
        case Row.EventCell.rawValue:
            
            let cell: EventCell = tableView.dequeueReusableCell(for: indexPath)
            cell.event = dict["value"] as? Event
            return cell
            
        default:
            break
        }
        
        return defaultCell(indexPath)
    }
}

// MARK:- InputCellDelegate methods
extension CreateSessionViewController: InputCellDelegate {
    func textFieldDidBeginEditing(_ cell: InputCell, identifier: String?) {}
    
    func textFieldDidEndEditing(_ cell: InputCell, text: String, identifier: String?) {
        guard let identifier = identifier else { return }
        
        switch identifier {
        case Row.NameCell.rawValue: session?.name = text
        default: break
        }
        
        // Needed otherwise the entered text disappear
        prepareTableViewSections()
        tableView.reloadData()
    }
    
    func textField(_ cell: InputCell, didChange text: String, identifier: String?) {}
}
