//
//  IndexPath+FirebaseCollectionIndex.swift
//  ding
//
//  Created by Chen Xiaoman on 28/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 An extension to get the index in firebase collection
 for a indexpath in collection view
 */
extension IndexPath {
    
    /// Get the index in firebase collection
    /// for a indexpath in the collection view
    func fireBaseCollectionIndex(in collectionView: UICollectionView) -> UInt {
        var tatalItemsInPreviousSection: Int = 0
        for sectionNumber in 0...section {
            let itemsInSection = collectionView.numberOfItems(inSection: sectionNumber)
            tatalItemsInPreviousSection += itemsInSection
        }
        return UInt(tatalItemsInPreviousSection + row)
    }
}
