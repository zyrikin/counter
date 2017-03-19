//
//  MainTableViewController.swift
//  counter
//
//  Created by Nik Zakirin on 11/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import NZKit
import SnapKit
import RealmSwift

private enum Section: String {
    case sessions, events
}

private enum Row: String {
    case AddSessionCell, SessionCell
    case AddEventCell, EventCell
}

final class MainViewController: NZBaseTableViewController {
    
    let events: List<Event> = EventService.shared.events
    var eventsToken: NotificationToken?
    
    let sessions: List<Session> = SessionService.shared.sessions
    var sessionsToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Overview".localized
        
        tableView.commonSetUp()
        tableView.register(UINib.init(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: EventCell.defaultReuseIdentifier)
        tableView.register(UINib.init(nibName: "SessionCell", bundle: nil), forCellReuseIdentifier: SessionCell.defaultReuseIdentifier)
        
        eventsToken = events.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            
            case .initial:
                self?.prepareTableViewSections()
                self?.tableView.reloadData()
                
            case .update(_, _, _, _):
                self?.prepareTableViewSections()
                self?.tableView.reloadData()
                
            case .error(let error):
                print("MainVC Event Section Error: \(error)")
                break
            }
        }
        
        sessionsToken = sessions.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            switch changes {
                
            case .initial:
                self?.prepareTableViewSections()
                self?.tableView.reloadData()
                
            case .update(_, _, _, _):
                self?.prepareTableViewSections()
                self?.tableView.reloadData()
                
            case .error(let error):
                print("MainVC Session Section Error: \(error)")
                break
            }
        }
    }

    override func prepareTableViewSections() {
        super.prepareTableViewSections()
        
        addSection(Section.sessions.rawValue) { section in
            let headerTitle = "Sessions".localized.uppercased()
            section.headerView = SectionHeaderView(title: headerTitle)
            
            for session in sessions {
                section.addRow(Row.SessionCell.rawValue, height: 80, configure: { row in
                    row.data = session
                })
            }
            
            section.addRow(Row.AddSessionCell.rawValue, height: 60, configure: { row in
                row.data = "Create Session".localized
            })
        }
        
        addSection(Section.events.rawValue) { section in
            let headerTitle = "Events".localized.uppercased()
            section.headerView = SectionHeaderView(title: headerTitle)
            
            for event in events {
                section.addRow(Row.EventCell.rawValue, height: 65, configure: { row in
                    row.data = event
                })
            }
            
            section.addRow(Row.AddEventCell.rawValue, height: 60, configure: { row in
                row.data = "Add Event".localized
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let nvc = segue.destination as? UINavigationController else { return }
        
        switch identifier {
        case "ShowAddEvent":
            if let vc = nvc.topViewController as? CreateEventViewController {
                vc.delegate = self
                vc.event = sender as? Event
            }
            
        case "ShowCreateSession":
            if let vc = nvc.topViewController as? CreateSessionViewController {
                vc.delegate = self
                vc.session = sender as? Session
            }
            
        default:
            break
        }
    }
    
    deinit {
        eventsToken?.stop()
        sessionsToken?.stop()
    }
    
    @IBAction func prepareForUnWind(segue: UIStoryboardSegue) {}
}

// MARK:- UITableViewDataSource methods
extension MainViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = getRow(indexPath) else { return defaultCell(indexPath) }
        
        switch row.name {
        
        case Row.AddSessionCell.rawValue, Row.AddEventCell.rawValue:
            
            let cell: ButtonTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.buttonLabel.text = row.data as? String
            return cell
            
        case Row.EventCell.rawValue:
            
            let cell: EventCell = tableView.dequeueReusableCell(for: indexPath)
            cell.event = row.data as? Event
            return cell
            
        case Row.SessionCell.rawValue:
            
            let cell: SessionCell = tableView.dequeueReusableCell(for: indexPath)
            cell.session = row.data as? Session
            return cell
        
        default:
            break
        }
        
        return defaultCell(indexPath)
    }
}


// MARK:- UITableViewDelegate methods
extension MainViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let row = getRow(indexPath) else { return }
        
        switch row.name  {
        case Row.AddSessionCell.rawValue:
            performSegue(withIdentifier: "ShowCreateSession", sender: self)
        case Row.SessionCell.rawValue:
            performSegue(withIdentifier: "ShowCreateSession", sender: row.data)
        case Row.AddEventCell.rawValue:
            performSegue(withIdentifier: "ShowAddEvent", sender: self)
        case Row.EventCell.rawValue:
            performSegue(withIdentifier: "ShowAddEvent", sender: row.data)
        default:
            return
        }
    }
}

// MARK:- CreateEventControllerDelegate methods
extension MainViewController: CreateEventControllerDelegate {
    func createEvent(controller: CreateEventViewController, didSave event: Event) {
        navigationController?.dismiss(animated: true, completion: nil)
        
        EventService.shared.add(event: event)
        
        // Highlight the newly saved event cell
        if let row = events.index(of: event) {
            let indexPath = IndexPath(row: row, section: 1)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.animateFocus()
            }
        }
    }
}

// MARK:- CreateSessionControllerDelegate methods
extension MainViewController: CreateSessionControllerDelegate {
    func createSession(controller: CreateSessionViewController, didCreate session: Session) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
