//
//  Event.swift
//  counter
//
//  Created by Nik Zakirin on 11/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import UIKit

struct Event: Hashable {
    let id: String
    var name: String = ""
    var description: String = ""
    var color: UIColor = UIColor.white
    
    var hashValue: Int {
        return self.id.hashValue
    }
}

func ==(lhs: Event, rhs: Event) -> Bool {
    return lhs.id == rhs.id
}
