//
//  ColorIndicatorView.swift
//  counter
//
//  Created by Nik Zakirin on 16/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit

@IBDesignable
final class ColorIndicatorView: NeverClearView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    @IBInspectable var color: UIColor = .white {
        didSet {
            backgroundColor = color
        }
    }
    
    @IBInspectable var strokeColor: UIColor = .white {
        didSet {
            layer.borderColor = strokeColor.cgColor
        }
    }
    
    @IBInspectable var strokeColorWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = strokeColorWidth
        }
    }
    
    @IBInspectable var strokeWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = strokeWidth
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
    }
}

fileprivate extension ColorIndicatorView {
    func setUp() {
        
    }
}

