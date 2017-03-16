//
//  EventService.swift
//  counter
//
//  Created by Nik Zakirin on 11/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation

final class EventService {
    static let shared = EventService()
    
    private(set) var events = [Event]()
    
    func add(event: Event) {
        if let idx = events.index(of: event) {
            events[idx] = event
        } else {
            events.insert(event, at: events.startIndex)
        }
    }
}
