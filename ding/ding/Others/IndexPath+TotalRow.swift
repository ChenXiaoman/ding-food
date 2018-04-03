//
//  IndexPath+FirebaseCollectionIndex.swift
//  ding
//
//  Created by Chen Xiaoman on 28/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Extension for `IndexPath` to support total row calculation.
 */
extension IndexPath {
    /// Returns the total row number of the index path in a certain collection
    /// view, which is an accumulation of the items in all previous sections.
    /// - Parameter collectionView: The collection view this index path is in.
    /// - Returns: The total item number.
    func totalItem(in collectionView: UICollectionView) -> Int {
        return row + Array(0..<section).reduce(0, { sum, section in
            return sum + collectionView.numberOfItems(inSection: section)
        })
    }
    
    /// Returns the total row number of the index path in a certain table
    /// view, which is an accumulation of the items in all previous sections.
    /// - Parameter tableview: The tableview view this index path is in.
    /// - Returns: The total row number.
    func totalRow(in tableview: UITableView) -> Int {
        return row + Array(0..<section).reduce(0, { sum, section in
            return sum + tableview.numberOfRows(inSection: section)
        })
    }
}
