//
//  HistoryView.swift
//  counter
//
//  Created by Nik Zakirin on 20/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import RealmSwift

final class HistoryView: UIView {

    fileprivate let layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 8
        $0.itemSize = CGSize(width: 80, height: 20)
        return $0
    }(UICollectionViewFlowLayout())
    
    fileprivate var collectionView: UICollectionView!
    fileprivate var token: NotificationToken?
    
    var session: Session! {
        didSet {
            registerNotification()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
}

fileprivate extension HistoryView {
    func setUp() {
        
        backgroundColor = UIColor.clear
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        
        collectionView.register(HistoryCell.self)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func registerNotification() {
        token = session.result.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            switch changes {
                
            case .initial:
                self?.collectionView.reloadData()
                
            case .update(_, let deletions, let insertions, let modifications):
                self?.collectionView.performBatchUpdates({ 
                    self?.collectionView.insertItems(at: insertions.map({ IndexPath(item: $0, section: 0) }))
                    self?.collectionView.deleteItems(at: deletions.map({ IndexPath(item: $0, section: 0) }))
                    self?.collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                }, completion: nil)
                
            case .error(let error):
                print("MainVC Event Section Error: \(error)")
                break
            }
        }
    }
}

extension HistoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return session.result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HistoryCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.event = session.result[indexPath.item]
        return cell
    }
}
