//
//  CreateSessionViewController.swift
//  counter
//
//  Created by Nik Zakirin on 12/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit

final class CreateSessionViewController: NZBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New Session".localized
        
        tableView.commonSetUp()
    }


}
