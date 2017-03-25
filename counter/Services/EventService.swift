//
//  EventService.swift
//  counter
//
//  Created by Nik Zakirin on 11/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import RealmSwift

private enum Const {
    static let kEventListPrimaryKey = "EventListPrimaryKey"
}

final class EventService {
    static let shared = EventService()
    
    let realm = try! Realm()
    
    lazy var eventList: EventList = {
        if let list = self.realm.object(ofType: EventList.self, forPrimaryKey: Const.kEventListPrimaryKey) {
            return list
        } else {
            let defaultList = EventList()
            defaultList.id = Const.kEventListPrimaryKey
            self.add(eventList: defaultList)
            return defaultList
        }
    }()

    var events: List<Event> {
        return eventList.list
    }
    
    func add(eventList: EventList) {
        do {
            try realm.write {
                // Ensures only one list exists
                realm.add(eventList, update: true)
            }
        }
        catch let error {
            print("Error creating EventList: \(error)")
        }
    }
    
    func add(event: Event) {
        guard events.index(of: event) == nil else { return } // Don't add existing event to the list
        
        do {
            try realm.write {
                events.insert(event, at: events.startIndex)
            }
        }
        catch let error {
            print("Event Add Error: \(error)")
        }
    }
    
    func moveEvent(from: Int, to: Int) {
        guard
            from >= events.startIndex, from <= events.endIndex,
            to >= events.startIndex, to <= events.endIndex else { return }
        
        do {
            try realm.write {
                events.move(from: from, to: to)
            }
        }
        catch let error {
            print("Event Update Error: \(error)")
        }
    }
    
    func update(event: Event, name: String? = nil, desc: String? = nil, color: UIColor? = nil) {
        do {
            try realm.write {
                if let name = name { event.name = name }
                if let desc = desc { event.desc = desc }
                if let color = color { event.color = color }
            }
        }
        catch let error {
            print("Event Update Error: \(error)")
        }
    }
    
    func remove(event: Event) {
        guard let idx = events.index(of: event) else { return }
        
        try! realm.write {
            events.remove(objectAtIndex: idx)
        }
    }
    
    func removeAllEvents() {
        try! realm.write {
            events.removeAll()
        }
    }
}
