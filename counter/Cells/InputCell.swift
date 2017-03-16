//
//  InputCell.swift
//  counter
//
//  Created by Nik Zakirin on 12/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

protocol InputCellDelegate: class {
    func textFieldDidBeginEditing(_ cell: InputCell, identifier: String?)
    func textFieldDidEndEditing(_ cell: InputCell, text: String, identifier: String?)
    func textField(_ cell: InputCell, didChange text: String, identifier: String?)
}

final class InputCell: BaseTableViewCell {
    
    weak var delegate: InputCellDelegate?
    
    var identifier: String?

    lazy var inputTextField: JVFloatLabeledTextField = {
        $0.font = UIFont.defaultFont(14)
        $0.textColor = UIColor.white
        $0.placeholderColor = UIColor.white.withAlphaComponent(0.8)
        $0.autocorrectionType = .no
        $0.enablesReturnKeyAutomatically = true
        $0.keyboardAppearance = .dark
        $0.delegate = self
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

// MARK:- UITextFieldDelegate methods
extension InputCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing(self, identifier: identifier)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(self, text: textField.text ?? "", identifier: identifier)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text else { return true }
        
        let newStr = (textFieldText as NSString).replacingCharacters(in: range, with: string)
        delegate?.textField(self, didChange: newStr, identifier: identifier)
        return true
    }
}
