//
//  Session.swift
//  counter
//
//  Created by Nik Zakirin on 11/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation

struct Session {
    let id: String
    let name: String
    var duration: TimeInterval = 0
    var events: [Event]
}
