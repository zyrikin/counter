//
//  EventService.swift
//  counter
//
//  Created by Nik Zakirin on 11/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import RealmSwift

final class EventService {
    static let shared = EventService()
    
    private let realm = try! Realm()
    
    private lazy var results: Results<Event> = {
        return self.realm.objects(Event.self).sorted(byKeyPath: "createdAt", ascending: false)
    }()
    
    var events: [Event] {
        get {
            return results.map { $0.eventCopy() }
        }
    }
    
    func add(event: Event) {
        try! realm.write {
            realm.add(event.eventCopy(), update: true)
        }
    }
    
    func remove(event: Event) {
        try! realm.write {
            realm.delete(event)
        }
    }
}
