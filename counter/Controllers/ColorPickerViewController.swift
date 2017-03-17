//
//  ColorPickerViewController.swift
//  counter
//
//  Created by Nik Zakirin on 17/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit

protocol ColorPickerControllerDelegate: class {
    func colorPicker(controller: ColorPickerViewController, didSelect color: UIColor)
}

final class ColorPickerViewController: UICollectionViewController {
    
    weak var delegate: ColorPickerControllerDelegate?
    
    let colors: [UIColor] = [
        UIColor.flatRed,
        UIColor.flatOrange,
        UIColor.flatYellow,
        UIColor.flatSand,
        UIColor.flatNavyBlue,
        UIColor.flatBlack,
        UIColor.flatMagenta,
        UIColor.flatTeal,
        UIColor.flatSkyBlue,
        UIColor.flatGreen,
        UIColor.flatMint,
        UIColor.flatWhite,
        UIColor.flatGray,
        UIColor.flatForestGreen,
        UIColor.flatPurple,
        UIColor.flatBrown,
        UIColor.flatPlum,
        UIColor.flatWatermelon,
        UIColor.flatLime,
        UIColor.flatPink,
        UIColor.flatMaroon,
        UIColor.flatCoffee,
        UIColor.flatPowderBlue,
        UIColor.flatBlue
        ]

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Assign Color".localized
        
        collectionView!.backgroundColor = UIColor.background
        
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView!.delaysContentTouches = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recalculateItem(at: self.view.bounds.size)
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ColorPickerCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.delegate = self
        cell.color = colors[indexPath.item]
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        recalculateItem(at: size)
    }
    
    func recalculateItem(at size: CGSize) {
        let l = (size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right) / 4
        flowLayout.itemSize = CGSize(width: l, height: l)
    }
}

extension ColorPickerViewController: ColorPickerCellDelegate {
    func colorPicker(cell: ColorPickerCell, didTap color: UIColor) {
        delegate?.colorPicker(controller: self, didSelect: color)
    }
}
