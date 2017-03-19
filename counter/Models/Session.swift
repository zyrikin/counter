//
//  Session.swift
//  counter
//
//  Created by Nik Zakirin on 11/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import RealmSwift

class Session: Object {
    dynamic var id: String = UUID().uuidString
    dynamic var createdAt: Date = Date()
    
    dynamic var name: String = ""
    dynamic var duration: TimeInterval = 0
    dynamic var startedAt: Date = Date()
    dynamic var endedAt: Date = Date()
    let events = List<Event>() // Populated at creation as the session's events
    let result = List<Event>() // Populated as counter during a session
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
