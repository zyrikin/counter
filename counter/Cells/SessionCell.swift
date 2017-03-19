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
    }
    
    func updateUI() {
        guard let session = session else { return }
        
        titleLabel.text = session.name
        createdAtLabel.text = "\(session.createdAt)"
    }
}
