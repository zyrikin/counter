//
//  SessionCell.swift
//  counter
//
//  Created by Nik Zakirin on 19/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit

final class SessionCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var disclosure: UIImageView!
    
    @IBOutlet weak var eventsTitle: UILabel!
    @IBOutlet weak var eventsValue: UILabel!
    
    @IBOutlet weak var totalTitle: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    
    @IBOutlet weak var durationTitle: UILabel!
    @IBOutlet weak var durationValue: UILabel!
    
    
    var session: Session? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = UIColor.label1
        titleLabel.font = UIFont.defaultFont(17)
        createdAtLabel.textColor = UIColor.label2
        createdAtLabel.font = UIFont.defaultFont(10)
        disclosure.tintColor = UIColor.disclosure
        
        eventsTitle.text = "Events".localized
        totalTitle.text = "Total Count".localized
        durationTitle.text = "Duration".localized
        
        [eventsTitle, totalTitle, durationTitle].forEach { (label) in
            label?.textColor = UIColor.label2
            label?.font = UIFont.defaultBoldFont(10)
        }
        
        [eventsValue, totalValue, durationValue].forEach { (label) in
            label?.textColor = UIColor.label1
            label?.font = UIFont.defaultLightFont(24)
        }
    }
    
    func updateUI() {
        guard let session = session else { return }
        
        titleLabel.text = session.name
        createdAtLabel.text = "\(session.createdAt)"
        
        eventsValue.text = "\(session.events.count)"
        totalValue.text = "\(session.result.count)"
        durationValue.text = session.duration.timeIntervalAsString("hh:mm:ss")
    }
}
