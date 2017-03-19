//
//  EventPickerCell.swift
//  counter
//
//  Created by Nik Zakirin on 18/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit

final class EventPickerCell: BaseTableViewCell {

    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var colorIndicatorView: ColorIndicatorView!
    
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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionButton.isSelected = selected;
    }
    
    func updateUI() {
        guard let event = event else { return }
        
        colorIndicatorView.color = event.color
        titleLabel.text = event.name
        descriptionLabel.text = event.desc
    }
    
    override var showsReorderControl: Bool {
        get {
            return true // short-circuit to on
        }
        set { }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing == false {
            return // ignore any attempts to turn it off
        }
        
        super.setEditing(editing, animated: animated)
    }
}
