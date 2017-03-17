//
//  ColorPickerCell.swift
//  counter
//
//  Created by Nik Zakirin on 17/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import ChameleonFramework

final class ColorPickerCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    
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
