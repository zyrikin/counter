//
//  EventCell.swift
//  counter
//
//  Created by Nik Zakirin on 16/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit

final class EventCell: BaseTableViewCell {

    @IBOutlet weak var colorIndicatorView: ColorIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var disclosure: UIImageView!
    
    
    var event: Event? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = UIColor.label1
        titleLabel.font = UIFont.defaultFont(16)
        descriptionLabel.textColor = UIColor.label2
        descriptionLabel.font = UIFont.defaultFont(13)
        disclosure.tintColor = UIColor.disclosure
    }
    
    func updateUI() {
        guard let event = event else { return }
        
        colorIndicatorView.color = event.color
        titleLabel.text = event.name
        descriptionLabel.text = event.description
    }
}
