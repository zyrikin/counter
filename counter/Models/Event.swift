//
//  Event.swift
//  counter
//
//  Created by Nik Zakirin on 11/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit
import ChameleonFramework

class Event: Object {
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var desc: String = ""
    dynamic var colorString: String = "ffffff"
    dynamic var createdAt = Date()
    
    var color: UIColor {
        get {
            if let color = HexColor(colorString) {
                return color
            } else {
                return UIColor.white
            }
        }
        set(newColor) {
            colorString = newColor.hexValue()
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["color"]
    }
    
    override var hashValue: Int {
        return self.id.hashValue
    }
    
    func eventCopy() -> Event {
        let eventCopy = Event()
        eventCopy.id = self.id
        eventCopy.name = self.name
        eventCopy.desc = self.desc
        eventCopy.color = self.color
        eventCopy.createdAt = self.createdAt
        
        return eventCopy
    }
}

func ==(lhs: Event, rhs: Event) -> Bool {
    return lhs.id == rhs.id
}
