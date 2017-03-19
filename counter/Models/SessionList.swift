//
//  SessionList.swift
//  counter
//
//  Created by Nik Zakirin on 19/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import RealmSwift

class SessionList: Object {
    dynamic var id: String = ""
    let list = List<Session>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
