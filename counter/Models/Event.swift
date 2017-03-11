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
    let name: String
    let description: String
    let color: UIColor
    
    var hashValue: Int {
        return self.id.hashValue
    }
}

func ==(lhs: Event, rhs: Event) -> Bool {
    return lhs.id == rhs.id
}
