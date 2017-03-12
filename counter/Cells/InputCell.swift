//
//  InputCell.swift
//  counter
//
//  Created by Nik Zakirin on 12/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

final class InputCell: BaseTableViewCell {

    lazy var inputTextField: JVFloatLabeledTextField = {
        $0.font = UIFont.defaultFont(14)
        $0.textColor = UIColor.white.withAlphaComponent(0.8)
        $0.placeholderColor = $0.textColor
        $0.autocorrectionType = .no
        $0.enablesReturnKeyAutomatically = true
        $0.keyboardAppearance = .dark
        return $0
    }(JVFloatLabeledTextField())
    
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(inputTextField)
        inputTextField.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(8, 20, 8, 20))
        }
    }
}

