//
//  SelectColorCell.swift
//  counter
//
//  Created by Nik Zakirin on 12/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit

final class SelectColorCell: BaseTableViewCell {

    lazy var titleLabel: UILabel = {
        $0.font = UIFont.defaultFont(14)
        $0.textColor = UIColor.white.withAlphaComponent(0.8)
        return $0
    }(UILabel())
    
    var color: UIColor = UIColor.white {
        didSet {
            self.colorView.color = color
        }
    }
    
    private lazy var colorView: CircleView = {
        $0.strokeWidth = 1
        $0.strokeColor = UIColor.white
        return $0
    }(CircleView())

    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(contentView).inset(UIEdgeInsetsMake(8, 20, 8, 20))
        }
        
        let disclosure = UIImageView(image: UIImage(named: "icn_disclosure"))
        disclosure.tintColor = titleLabel.textColor
        contentView.addSubview(disclosure)
        disclosure.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-20)
            make.centerY.equalTo(contentView)
        }
        
        colorView.color = UIColor.red
        contentView.addSubview(colorView)
        colorView.snp.makeConstraints { make in
            make.right.equalTo(disclosure.snp.left).inset(-15)
            make.centerY.equalTo(contentView)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
    }
}
