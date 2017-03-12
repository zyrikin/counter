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
}

fileprivate extension BaseTableViewCell {
    func setupUI() {
        textLabel?.textColor = UIColor.white.withAlphaComponent(0.8)
        textLabel?.font = UIFont.defaultFont(14)
        
        detailTextLabel?.textColor = UIColor.white
        detailTextLabel?.font = UIFont.defaultFont(17)
        
        backgroundColor = UIColor.background
        contentView.backgroundColor = UIColor.background
        selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = UIColor.hairline.withAlphaComponent(0.7)
            return view
        }()
    }
}
