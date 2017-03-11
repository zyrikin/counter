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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

fileprivate extension BaseTableViewCell {
    func setupUI() {
        backgroundColor = UIColor.background
        contentView.backgroundColor = UIColor.clear
        selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = UIColor.hairline.withAlphaComponent(0.2)
            return view
        }()
    }
}
