//
//  CreateEventViewController.swift
//  counter
//
//  Created by Nik Zakirin on 12/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit

private enum Section: String {
    case info
}

private enum Row: String {
    case NameCell, DescriptionCell, ColorCell
}

final class CreateEventViewController: NZBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Event".localized

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
            section.addRow(Row.NameCell.rawValue, height: 60, configure: { row in
                row.data = "Name".localized
            })
            
            section.addRow(Row.DescriptionCell.rawValue, height: 60, configure: { row in
                row.data = "Description".localized
            })
            
            section.addRow(Row.ColorCell.rawValue, height: 60, configure: { row in
                row.data = "Color".localized
            })
        }
    }
}

// MARK:- UITableViewDataSource methods
extension CreateEventViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = getRow(indexPath) else { return defaultCell(indexPath) }
        
        switch row.name {
            
        case Row.NameCell.rawValue, Row.DescriptionCell.rawValue:
            
            let cell: InputCell = tableView.dequeueReusableCell(for: indexPath)
            cell.inputTextField.placeholder = row.data as? String
            return cell
            
        case Row.ColorCell.rawValue:
            
            let cell: SelectColorCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = row.data as? String
            return cell
            
        default:
            break
        }
        
        return defaultCell(indexPath)
    }

}
