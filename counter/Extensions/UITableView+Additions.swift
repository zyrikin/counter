//
//  UITableView+Additions.swift
//  counter
//
//  Created by Nik Zakirin on 11/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func commonSetUp() {
        backgroundColor = UIColor.background
        separatorColor = UIColor.hairline
        separatorInset = UIEdgeInsets.zero
        tableFooterView = UIView()
        estimatedRowHeight = 80
    }
}
