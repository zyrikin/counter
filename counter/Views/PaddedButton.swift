//
//  PaddedButton.swift
//  oupai
//
//  Created by Nik Zakirin on 02/03/16.
//  Copyright © 2016 Oupai365. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

@IBDesignable
final class PaddedButton: UIButton {
    
    fileprivate lazy var spinner: NVActivityIndicatorView = UIFactory.activityIndicator(30, color: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    @IBInspectable var horizontalPadding: CGFloat = 0.0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    @IBInspectable var verticalPadding: CGFloat = 0.0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var titleColor: UIColor = .white {
        didSet {
            setTitleColor(titleColor, for: .normal)
            spinner.color = titleColor
        }
    }
    
    @IBInspectable var strokeColor: UIColor = .white {
        didSet {
            layer.borderColor = strokeColor.cgColor
        }
    }
    
    @IBInspectable var strokeWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = strokeWidth
        }
    }
    
    override var intrinsicContentSize : CGSize {
        let s = super.intrinsicContentSize
        return CGSize(width: s.width + horizontalPadding, height: s.height + verticalPadding)
    }
    
    func setInProgress(_ isInProgress: Bool = true, hideText: Bool = false) {
        
        if hideText && isInProgress {
            setTitleColor(.clear, for: .normal)
            spinner.snp.remakeConstraints { make in
                make.center.equalTo(self.snp.center)
            }
        } else {
            setTitleColor(titleColor, for: .normal)
            spinner.snp.remakeConstraints { make in
                make.right.equalTo(self.snp.rightMargin).offset(-20)
                make.centerY.equalTo(self.snp.centerY)
            }
        }
        
        if isInProgress {
            self.isEnabled = false
            spinner.isHidden = false
            spinner.startAnimating()
        }
        else {
            self.isEnabled = true
            spinner.stopAnimating()
        }
    }
}

private extension PaddedButton {
    
    func setupView() {
        
        adjustsImageWhenHighlighted = false
        
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside])
        
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.right.equalTo(self.snp.rightMargin).offset(-20)
        }
    }
    
    @objc func touchDown() {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .curveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }, completion: nil)
    }
    
    @objc func touchUp() {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .curveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
