//
//  CreateEventViewController.swift
//  counter
//
//  Created by Nik Zakirin on 12/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit

protocol CreateEventControllerDelegate: class {
    func createEvent(controller: CreateEventViewController, didSave event: Event)
}

private enum Mode {
    case edit, new
}

private enum Section: String {
    case info
}

private enum Row: String {
    case NameCell, DescriptionCell, ColorCell
}

final class CreateEventViewController: NZBaseTableViewController {
    
    weak var delegate: CreateEventControllerDelegate?
    fileprivate var mode: Mode = .edit
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.setContentInsetWhenKeyboardIsShown()
        
        if event == nil {
            title = "New Event".localized
            mode = .new
            event = Event()
        } else {
            title = "Edit Event".localized
        }
        
        prepareTableViewSections()
    }
    
    override func setUp() {
        super.setUp()
        tableView.commonSetUp()
        
        tableView.register(InputCell.self)
        tableView.register(SelectColorCell.self)
    }
    
    override func prepareTableViewSections() {
        super.prepareTableViewSections()
        
        addSection(Section.info.rawValue) { section in
            section.headerView = SectionHeaderView(title: "")
            section.headerHeight = 15
            
            section.addRow(Row.NameCell.rawValue, height: 60, configure: { row in
                row.data = [
                    "placeholder": "Name".localized,
                    "value": event?.name
                ]
            })
            
            section.addRow(Row.DescriptionCell.rawValue, height: 60, configure: { row in
                row.data = [
                    "placeholder": "Description".localized,
                    "value": event?.desc
                ]
            })
            
            section.addRow(Row.ColorCell.rawValue, height: 60, configure: { row in
                row.data = [
                    "placeholder": "Color".localized,
                    "value": event?.color ?? UIColor.white
                ]
            })
        }
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        tableView.endEditing(true)
        
        guard let event = event else { return }
        
        delegate?.createEvent(controller: self, didSave: event)
    }
}

// MARK:- UITableViewDataSource / Delegate methods
extension CreateEventViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = getRow(indexPath), let dict = row.data as? [String: Any] else { return defaultCell(indexPath) }
        
        switch row.name {
            
        case Row.NameCell.rawValue, Row.DescriptionCell.rawValue:
            
            let cell: InputCell = tableView.dequeueReusableCell(for: indexPath)
            cell.identifier = row.name
            cell.inputTextField.placeholder = dict["placeholder"] as? String
            cell.inputTextField.text = dict["value"] as? String
            cell.delegate = self
            return cell
            
        case Row.ColorCell.rawValue:
            
            let cell: SelectColorCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = dict["placeholder"] as? String
            if let color = dict["value"] as? UIColor {
                cell.color = color
            }
            return cell
            
        default:
            break
        }
        
        return defaultCell(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let row = getRow(indexPath) else { return }
        
        switch row.name {
            
        case Row.ColorCell.rawValue:
            if let colorPickerVC = UIStoryboard(name: "ColorPicker", bundle: nil).instantiateInitialViewController() as? ColorPickerViewController {
                colorPickerVC.delegate = self;
                navigationController?.pushViewController(colorPickerVC, animated: true)
            }
            
        default:
            break
        }
    }
}

// MARK:- InputCellDelegate methods
extension CreateEventViewController: InputCellDelegate {
    func textFieldDidBeginEditing(_ cell: InputCell, identifier: String?) {}
    
    func textFieldDidEndEditing(_ cell: InputCell, text: String, identifier: String?) {
        guard let identifier = identifier, let event = event else { return }
        
        switch identifier {
        case Row.NameCell.rawValue: EventService.shared.update(event: event, name: text)
        case Row.DescriptionCell.rawValue: EventService.shared.update(event: event, desc: text)
        default: break
        }
    }
    
    func textField(_ cell: InputCell, didChange text: String, identifier: String?) {}
}

// MARK:- ColorPickerControllerDelegate methods
extension CreateEventViewController: ColorPickerControllerDelegate {
    func colorPicker(controller: ColorPickerViewController, didSelect color: UIColor) {
        guard let event = event else { return }
        
        EventService.shared.update(event: event, color: color)
        
        _ = navigationController?.popViewController(animated: true)
        
        prepareTableViewSections()
        tableView.reloadData()
    }
}
