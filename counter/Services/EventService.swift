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
    
    private lazy var results: Results<Event> = {
        return self.realm.objects(Event.self).sorted(byKeyPath: "createdAt", ascending: false)
    }()
    
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
    
//    var events: [Event] {
//        get {
//            return results.map { $0.eventCopy() }
//        }
//    }
    
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
        do {
            try realm.write {
                events.insert(event, at: events.startIndex)
            }
        }
        catch let error {
            print("Event Add Error: \(error)")
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
    
//    func add(event: Event) {
//        do {
//            try realm.write {
//                realm.add(event.eventCopy(), update: true)
//            }
//        }
//        catch let error {
//            print("Error: \(error)")
//        }
//        
//    }
    
    func remove(event: Event) {
        try! realm.write {
            realm.delete(event)
        }
    }
}
