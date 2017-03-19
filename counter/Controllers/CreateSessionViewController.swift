//
//  CreateSessionViewController.swift
//  counter
//
//  Created by Nik Zakirin on 12/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit
import RealmSwift

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
    case NameCell, EventPickerCell
}

final class CreateSessionViewController: NZBaseTableViewController {
    
    weak var delegate: CreateSessionControllerDelegate?
    fileprivate var mode: Mode = .results
    
    var session: Session?
    let events: List<Event> = EventService.shared.events

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
        tableView.allowsMultipleSelection = true
        
        tableView.register(InputCell.self)
        tableView.register(UINib.init(nibName: "EventPickerCell", bundle: nil), forCellReuseIdentifier: EventPickerCell.defaultReuseIdentifier)
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
            let headerView = SectionSelectionHeaderView(title: headerTitle)
            headerView.delegate = self
            section.headerView = headerView
            
            for event in events {
                section.addRow(Row.EventPickerCell.rawValue, height: 65, configure: { row in
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

// MARK:- UITableViewDataSource / Delegate methods
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
            
        case Row.EventPickerCell.rawValue:
            
            let cell: EventPickerCell = tableView.dequeueReusableCell(for: indexPath)
            cell.event = dict["value"] as? Event
            cell.isEditing = self.tableView(self.tableView, canMoveRowAt: indexPath)
            return cell
            
        default:
            break
        }
        
        return defaultCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            var row = 0
            if sourceIndexPath.section < proposedDestinationIndexPath.section {
                row = self.tableView(tableView, numberOfRowsInSection: sourceIndexPath.section) - 1
            }
            return IndexPath(row: row, section: sourceIndexPath.section)
        }
        return proposedDestinationIndexPath
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
//    {
//        let fromIndex = sourceIndexPath.row
//        let toIndex = destinationIndexPath.row
//        
//        let event = events[fromIndex]
//        events.remove(at: fromIndex)
//        events.insert(event, at: toIndex)
//        
//        event.createdAt = Date()
//        EventService.shared.add(event: event)
//        
//        prepareTableViewSections()
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        for view in cell.subviews {
            if String(describing: type(of: view)) == "UITableViewCellReorderControl" {
                view.backgroundColor = UIColor.darkBackground
            }
        }
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

// MARK:- SectionSelectionHeaderViewDelegate methods
extension CreateSessionViewController: SectionSelectionHeaderViewDelegate {
    func sectionSelectionDidTapSelectAll(headerView: SectionSelectionHeaderView) {
        let eventSection = 1
        let totalRows = tableView.numberOfRows(inSection: eventSection)
        for row in 0..<totalRows {
            tableView.selectRow(at: IndexPath(row: row, section: eventSection), animated: true, scrollPosition: .none)
        }
    }
    
    func sectionSelectionDidTapSelectNone(headerView: SectionSelectionHeaderView) {
        let eventSection = 1
        let totalRows = tableView.numberOfRows(inSection: eventSection)
        for row in 0..<totalRows {
            tableView.deselectRow(at: IndexPath(row: row, section: eventSection), animated: true)
        }
    }
}
