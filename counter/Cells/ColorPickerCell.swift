//
//  ColorPickerCell.swift
//  counter
//
//  Created by Nik Zakirin on 17/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit
import ChameleonFramework

protocol ColorPickerCellDelegate: class {
    func colorPicker(cell: ColorPickerCell, didTap color: UIColor)
}

final class ColorPickerCell: UICollectionViewCell {
    
    weak var delegate: ColorPickerCellDelegate?
    
    lazy var button: PaddedButton = {
        $0.strokeColor = UIColor.white
        $0.strokeWidth = 2
        return $0
    }(PaddedButton())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        delegate?.colorPicker(cell: self, didTap: color)
    }
    
    var color: UIColor = UIColor.clear {
        didSet {
            button.backgroundColor = color
            let titleColor = UIColor(contrastingBlackOrWhiteColorOn: color, isFlat: true)
            button.setTitleColor(titleColor, for: .normal)
        }
    }
    
    override func draw(_ rect: CGRect) {
        let width = button.bounds.maxY
        button.layer.cornerRadius = width/2
        button.layer.masksToBounds = true
    }
}
