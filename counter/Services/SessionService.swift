//
//  SessionService.swift
//  counter
//
//  Created by Nik Zakirin on 19/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation
import RealmSwift

private enum Const {
    static let kSessionListPrimaryKey = "SessionListPrimaryKey"
}

final class SessionService {
    static let shared = SessionService()
    
    let realm = try! Realm()
    
    lazy var sessionList: SessionList = {
        if let list = self.realm.object(ofType: SessionList.self, forPrimaryKey: Const.kSessionListPrimaryKey) {
            return list
        } else {
            let defaultList = SessionList()
            defaultList.id = Const.kSessionListPrimaryKey
            self.add(sessionList: defaultList)
            return defaultList
        }
    }()
    
    var sessions: List<Session> {
        return sessionList.list
    }
    
    func add(sessionList: SessionList) {
        do {
            try realm.write {
                // Ensure only one list exists
                realm.add(sessionList, update: true)
            }
        }
        catch let error {
            print("Error creating SessionList: \(error)")
        }
    }
    
    func add(session: Session) {
        guard sessions.index(of: session) == nil else { return } // Don't add existing event to the list
        
        do {
            try realm.write {
                sessions.insert(session, at: sessions.startIndex)
            }
        }
        catch let error {
            print("Session Add Error: \(error)")
        }
    }
    
    func remove(session: Session) {
        guard let idx = sessions.index(of: session) else { return }
        
        do {
            try realm.write {
                sessions.remove(objectAtIndex: idx)
            }
        }
        catch let error {
            print("Session Remove Error: \(error)")
        }
    }
    
    
    func update(session: Session, name: String? = nil, duration: TimeInterval? = nil, startedAt: Date? = nil, endedAt: Date? = nil) {
        do {
            try realm.write {
                if let name = name { session.name = name }
                if let duration = duration { session.duration = duration }
                if let startedAt = startedAt { session.startedAt = startedAt }
                if let endedAt = endedAt { session.endedAt = endedAt }
            }
        }
        catch let error {
            print("Session Update Error: \(error)")
        }
    }
    
    func incrementDuration(session: Session) {
        do {
            try realm.write {
                session.duration += 1
            }
        }
        catch let error {
            print("Session Duration Increment Error: \(error)")
        }
    }
    
    func set(events: [Event], for session: Session) {
        do {
            try realm.write {
                session.events.removeAll()
                session.events.append(objectsIn: events)
            }
        }
        catch let error {
            print("Session Set Events Error: \(error)")
        }
    }
    
    func addResult(event: Event, to session: Session) {
        do {
            try realm.write {
                session.result.insert(event, at: session.result.startIndex)
            }
        }
        catch let error {
            print("Session Result Addition Error: \(error)")
        }
    }
    
    func removeLastResult(from session: Session) {
        guard session.result.count > 0 else { return }
        do {
            try realm.write {
                session.result.remove(objectAtIndex: session.result.startIndex)
            }
        }
        catch let error {
            print("Session Last Result Removal Error: \(error)")
        }
    }
    
    func remove(event: Event) {
        try! realm.write {
            realm.delete(event)
        }
    }
}
