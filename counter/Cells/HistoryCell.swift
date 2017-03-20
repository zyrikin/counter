//
//  HistoryCell.swift
//  counter
//
//  Created by Nik Zakirin on 20/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit

final class HistoryCell: UICollectionViewCell {

    var event: Event? {
        didSet {
            guard let event = event else { return }
            label.borderColor = event.color
            label.backgroundColor = event.color.withAlphaComponent(0.1)
            label.text = event.name
        }
    }
    
    fileprivate lazy var label: PaddedLabel = {
        $0.textColor = UIColor.white.withAlphaComponent(0.8)
        $0.font = HistoryCell.labelFont()
        $0.horizontalPadding = HistoryCell.labelHorizontalPadding()
        $0.verticalPadding = 10
        $0.cornerRadius = 3
        $0.borderWidth = Constants.Layer.borderWidth
        return $0
    }(PaddedLabel())
    
    override var intrinsicContentSize : CGSize {
        return label.intrinsicContentSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

// MARK:- Helper methods
extension HistoryCell {
    class func labelFont() -> UIFont {
        return UIFont.defaultFont(10)
    }
    
    class func labelHorizontalPadding() -> CGFloat {
        return CGFloat(20)
    }
}

fileprivate extension HistoryCell {
    func setupUI() {
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
