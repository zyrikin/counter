//
//  SectionSelectionHeaderView.swift
//  counter
//
//  Created by Nik Zakirin on 18/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit

protocol SectionSelectionHeaderViewDelegate: class {
    func sectionSelectionDidTapSelectAll(headerView: SectionSelectionHeaderView)
    func sectionSelectionDidTapSelectNone(headerView: SectionSelectionHeaderView)
}

final class SectionSelectionHeaderView: UIView {
    
    weak var delegate: SectionSelectionHeaderViewDelegate?

    var titleLabel: UILabel = {
        $0.font = UIFont.defaultBoldFont(11)
        $0.textColor = UIColor.white.withAlphaComponent(0.9)
        return $0
    }(UILabel())
    
    var selectAllButton: UIButton = {
        $0.setTitle("Select All".localized, for: .normal)
        $0.setTitleColor(UIColor.callToAction, for: .normal)
        $0.setTitleColor(UIColor.callToAction.withAlphaComponent(0.2), for: .highlighted)
        $0.titleLabel?.font = UIFont.defaultFont(17)
        return $0
    }(UIButton())
    
    var selectNoneButton: UIButton = {
        $0.setTitle("Select None".localized, for: .normal)
        $0.setTitleColor(UIColor.callToAction, for: .normal)
        $0.setTitleColor(UIColor.callToAction.withAlphaComponent(0.2), for: .highlighted)
        $0.titleLabel?.font = UIFont.defaultFont(17)
        return $0
    }(UIButton())
    
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
fileprivate extension SectionSelectionHeaderView {
    func setupUI() {
        backgroundColor = UIColor.background
        
        let bottomInset = 10
        let edgeInset = 20
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self).inset(edgeInset)
            make.bottom.equalTo(self).inset(bottomInset)
        }
        
        addSubview(selectAllButton)
        selectAllButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(edgeInset)
            make.firstBaseline.equalTo(titleLabel)
        }
        
        addSubview(selectNoneButton)
        selectNoneButton.snp.makeConstraints { (make) in
            make.right.equalTo(selectAllButton.snp.left).inset(-edgeInset)
            make.firstBaseline.equalTo(selectAllButton)
        }
        
        selectAllButton.addTarget(self, action: #selector(selectAllTapped), for: .touchUpInside)
        selectNoneButton.addTarget(self, action: #selector(selectNoneTapped), for: .touchUpInside)
    }
    
    @objc func selectAllTapped() {
        delegate?.sectionSelectionDidTapSelectAll(headerView: self)
    }
    
    @objc func selectNoneTapped() {
        delegate?.sectionSelectionDidTapSelectNone(headerView: self)
    }
}
