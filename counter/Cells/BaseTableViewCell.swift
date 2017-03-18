//
//  BaseTableViewCell.swift
//  counter
//
//  Created by Nik Zakirin on 11/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

extension BaseTableViewCell {
    func setupUI() {
        textLabel?.textColor = UIColor.white.withAlphaComponent(0.8)
        textLabel?.font = UIFont.defaultFont(14)
        
        detailTextLabel?.textColor = UIColor.white
        detailTextLabel?.font = UIFont.defaultFont(17)
        
        backgroundColor = UIColor.background
        accessoryView?.backgroundColor = UIColor.darkBackground
        contentView.backgroundColor = UIColor.darkBackground
        selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = UIColor.hairline.withAlphaComponent(0.7)
            return view
        }()
    }
}
