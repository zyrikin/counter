//
//  ButtonTableViewCell.swift
//  counter
//
//  Created by Nik Zakirin on 12/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit

final class ButtonTableViewCell: BaseTableViewCell {

    @IBOutlet weak var buttonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonLabel.textColor = UIColor.callToAction
        buttonLabel.font = UIFont.defaultBoldFont(17)
        if #available(iOS 10.0, *) {
            buttonLabel.adjustsFontForContentSizeCategory = true
        } else {
            buttonLabel.adjustsFontSizeToFitWidth = true
            buttonLabel.minimumScaleFactor = 0.7
        }
    }

}
