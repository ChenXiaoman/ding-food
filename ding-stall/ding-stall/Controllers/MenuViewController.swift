//
//  MenuViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI
import UIKit

/**
 The controller of stall's menu view
 */
class MenuViewController: NoNavigationBarViewController {

    @IBOutlet private weak var menuView: UICollectionView!

    /// The Firebase data source for the listing of stalls.
    var dataSource: FUICollectionViewDataSource?
    /// The path in database to get the menu
    private let menuPath = Stall.path + "/\(Account.stallId)" + "/menu"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let query = DatabaseRef.getNodeRef(of: menuPath)
        dataSource = FUICollectionViewDataSource(query: query, populateCell: populateMenuCell)
        dataSource?.bind(to: menuView)
        menuView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop binding to avoid program crash
        dataSource?.unbind()
    }

    /// Populates a `MenuCollectionViewCell` with the given data from database.
    /// - Parameters:
    ///    - collectionView: The collection view as the listing of food.
    ///    - indexPath: The index path of this cell.
    ///    - snapshot: The snapshot of the corresponding food object from database.
    /// - Returns: a `MenuCollectionViewCell` to use.
    private func populateMenuCell(collectionView: UICollectionView,
                                  indexPath: IndexPath,
                                  snapshot: DataSnapshot) -> MenuCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier,
                                                            for: indexPath) as? MenuCollectionViewCell else {
                                                                fatalError("Unable to dequeue a cell.")
        }
        if let food = Food.deserialize(snapshot) {
            cell.load(food)
        }
        return cell
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellAndInsetSize = collectionView.frame.width / MenuViewConstants.numCellsPerRow
        let cellWidth = cellAndInsetSize * CGFloat(MenuViewConstants.cellRatio)
        let cellHeight = cellWidth * CGFloat(MenuViewConstants.heightWidthRatio)
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellAndInsetSize = collectionView.frame.width / MenuViewConstants.numCellsPerRow
        // half the spacing because both left and right has this spacing
        return cellAndInsetSize * CGFloat(1 - MenuViewConstants.cellRatio) * 0.5
    }
}
