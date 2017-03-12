//
//  SectionHeaderView.swift
//  Oupai
//
//  Created by Nik Zakirin on 4.9.16.
//  Copyright © 2016 Oupai365. All rights reserved.
//

import UIKit

class SectionHeaderView: UIView {
    var titleLabel: UILabel = {
        $0.font = UIFont.defaultBoldFont(11)
        $0.textColor = UIColor.white.withAlphaComponent(0.9)
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    convenience init(title: String) {
        self.init()
        titleLabel.text = title
    }
}

// MARK:- Private methods
private extension SectionHeaderView {
    func setupUI() {
        backgroundColor = UIColor.darkBackground
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self).inset(15)
            make.bottom.equalTo(self).inset(10)
        }
    }
}
