//
//  SessionEventButtonCell.swift
//  counter
//
//  Created by Nik Zakirin on 19/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit
import ChameleonFramework

protocol SessionEventButtonCellDelegate: class {
    func sessionEventButton(cell: SessionEventButtonCell, didTap event: Event)
}

final class SessionEventButtonCell: UICollectionViewCell {
    
    weak var delegate: SessionEventButtonCellDelegate?
    
    lazy var button: PaddedButton = {
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        return $0
    }(PaddedButton())
    
    lazy var titleLabel: UILabel = {
        $0.font = UIFont.defaultBoldFont(24)
        $0.numberOfLines = 3
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    var event: Event? {
        didSet {
            updateUI()
        }
    }
    
    var color: UIColor = UIColor.clear {
        didSet {
            button.backgroundColor = color
            titleLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: color, isFlat: true)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        button.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(20)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        guard let event = event else { return }
        delegate?.sessionEventButton(cell: self, didTap: event)
    }
}

fileprivate extension SessionEventButtonCell {
    func updateUI() {
        guard let event = event else { return }
        color = event.color
        titleLabel.text = event.name
    }
}
