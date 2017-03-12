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

private enum Row: String {
    static let kAddSessionCellIdentifier = "AddSessionCell"
    static let kSessionCellIdentifier = "SessionCell"
    static let kAddEventCelIdentifier = "AddEventCell"
    static let kEventCellIdentifier = "EventCell"
    static let kHeaderIdentifier = "Header"
}

final class MainTableViewController: NZBaseTableViewController {

    var sessions = [Session]()
    var events: [Event] = Array(EventService.shared.events)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.commonSetUp()
        prepareTableViewSections()
        
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: Const.kHeaderIdentifier)
    }

    override func prepareTableViewSections() {
        super.prepareTableViewSections()
        
        addSection("Sessions") { section in
            let headerTitle = "Sessions"
            section.headerView = SectionHeaderView(title: headerTitle)
            
            section.addRow(<#T##name: String##String#>, height: <#T##CGFloat?#>, configure: <#T##(NZRow) -> Void#>)
        }
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return sessions.count > 0 ? sessions.count : 1
        default:
            return events.count > 0 ? events.count : 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier: String
        
        switch indexPath.section {
        case 0:
            identifier = (sessions.count == 0 || indexPath.row == sessions.count-1) ? Const.kAddSessionCellIdentifier : Const.kSessionCellIdentifier
        case 1:
            identifier = (events.count == 0 || indexPath.row == events.count-1) ? Const.kAddEventCelIdentifier : Const.kEventCellIdentifier
        default:
            identifier = ""
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UITableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Const.kHeaderIdentifier)!
        
        view.contentView.backgroundColor = UIColor.darkBackground
        
        let headerText = section == 0 ? "Sessions".uppercased() : "Events".uppercased()
        
        let headerLabelTag = 1001
        if let headerLabel = view.contentView.viewWithTag(headerLabelTag) as? UILabel {
            headerLabel.text = headerText
        } else {
            let label = UILabel()
            label.tag = headerLabelTag
            label.textColor = UIColor.white.withAlphaComponent(0.9)
            label.font = UIFont.defaultBoldFont(11)
            
            view.contentView.addSubview(label)
            label.snp.makeConstraints { make in
                make.left.bottom.equalToSuperview().inset(15)
            }
            
            label.text = headerText
        }
        
        return view
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
