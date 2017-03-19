//
//  SessionViewController.swift
//  counter
//
//  Created by Nik Zakirin on 19/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import RealmSwift

private enum Mode {
    case notStarted, paused, ongoing, ended
}

final class SessionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var historyView: UIView!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    
    @IBOutlet weak var undoButton: UIButton!
    
    var session: Session!
    
    fileprivate var timer: Timer?
    fileprivate var token: NotificationToken?
    
    fileprivate var mode: Mode = .notStarted {
        didSet {
            let startButton = UIBarButtonItem(title: "Start Session".localized, style: .plain, target: self, action: #selector(startResumeSession))
            let resumeButton = UIBarButtonItem(title: "Resume Session".localized, style: .plain, target: self, action: #selector(startResumeSession))
            let pauseButton = UIBarButtonItem(title: "Pause".localized, style: .plain, target: self, action: #selector(pauseSession))
            let endButton = UIBarButtonItem(title: "End Session".localized, style: .plain, target: self, action: #selector(endSession))
            let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            fixedSpace.width = 30
            
            switch mode {
            case .notStarted:
                navigationItem.rightBarButtonItems = [startButton]
                
            case .paused:
                navigationItem.rightBarButtonItems = [resumeButton]
                
            case .ongoing:
                navigationItem.rightBarButtonItems = [endButton, fixedSpace, pauseButton]
                
            case .ended:
                navigationItem.rightBarButtonItems = nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerNotifications()
        
        title = session?.name
        mode = .notStarted
        
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recalculateItem(at: self.view.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        recalculateItem(at: size)
    }
    
    func recalculateItem(at size: CGSize) {
        let l = (size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - (3*flowLayout.minimumInteritemSpacing)) / 4
        flowLayout.itemSize = CGSize(width: l, height: 100)
    }
    
    @objc func startResumeSession() {
        mode = .ongoing
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in
            if let session = self?.session {
                SessionService.shared.incrementDuration(session: session)
            }
        })
    }
    
    @objc func pauseSession() {
        mode = .paused
        timer?.invalidate()
    }
    
    @objc func endSession() {
        mode = .ended
        timer?.invalidate()
    }
    
    @IBAction func undoPressed(_ sender: UIButton) {
    }
    
    deinit {
        token?.stop()
    }
}

// MARK:- Private methods
fileprivate extension SessionViewController {
    func setupUI() {
        collectionView.backgroundColor = UIColor.background
        collectionView.delaysContentTouches = false
        
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        
        [timerView, historyView].forEach { (view) in
            view?.backgroundColor = UIColor.darkBackground
        }
        
        timerLabel.font = UIFont.defaultLightFont(24)
        timerLabel.textColor = UIColor.label1
        timerLabel.text = session.duration.timeIntervalAsString("hh:mm:ss")
        historyLabel.font = UIFont.defaultLightFont(10)
        historyLabel.textColor = UIColor.label1
        historyLabel.text = "History:".localized
        
        undoButton.setTitle("Undo".localized, for: .normal)
        undoButton.tintColor = UIColor.callToAction
    }
    
    func registerNotifications() {
        token = session.addNotificationBlock { [weak self] change in
            switch change {
            case .change(let properties):
                for property in properties {
                    if property.name == "duration" {
                        self?.timerLabel.text = self?.session.duration.timeIntervalAsString("hh:mm:ss")
                    }
                }
            case .error(let error):
                print("An error occurred: \(error)")
            case .deleted:
                print("The object was deleted.")
            }
        }
    }
}

// MARK:- UICollectionViewDataSource methods
extension SessionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return session.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SessionEventButtonCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.delegate = self
        cell.event = session.events[indexPath.item]
        return cell
    }
}

// MARK:- SessionEventButtonCellDelegate methods
extension SessionViewController: SessionEventButtonCellDelegate {
    func sessionEventButton(cell: SessionEventButtonCell, didTap event: Event) {
        
    }
}
