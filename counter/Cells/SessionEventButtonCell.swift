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
        $0.layer.shadowColor = Constants.Layer.shadowColor
        $0.layer.shadowRadius = 10
        $0.layer.shadowOffset = Constants.Layer.shadowOffset
        $0.layer.shadowOpacity = Constants.Layer.shadowOpacity
        return $0
    }(PaddedButton())
    
    lazy var titleLabel: UILabel = {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
        
        setup()
        
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
    
    override func draw(_ rect: CGRect) {
        guard let color = event?.color else { return }
        let lighterColor = color.lighterColor(0.5)
        button.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: button.frame, andColors: [lighterColor, color])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
            setup()
        }
    }
}

fileprivate extension SessionEventButtonCell {
    func setup() {
        let isHorizontallyCompact = traitCollection.horizontalSizeClass == .compact
        let fontSize: CGFloat = isHorizontallyCompact ? 17 : 24
        let numberOfLines = isHorizontallyCompact ? 1 : 3
        
        self.titleLabel.font = UIFont.defaultBoldFont(fontSize)
        self.titleLabel.numberOfLines = numberOfLines
    }
    
    func updateUI() {
        guard let event = event else { return }
        button.backgroundColor = event.color
        titleLabel.text = event.name
        titleLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: event.color, isFlat: true)
    }
}
