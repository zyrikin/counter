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
    
    private(set) var events = Set<Event>()
}
