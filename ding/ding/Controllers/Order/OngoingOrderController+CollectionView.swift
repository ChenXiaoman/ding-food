//
//  OngoingOrderController+CollectionView.swift
//  ding
//
//  Created by Yunpeng Niu on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Extension for `OngoingOrderController` so that it can manage the collection view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
extension OngoingOrderController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension OngoingOrderController: UICollectionViewDelegateFlowLayout {
    /// Sets the size of each cell.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: OngoingOrderCell.width, height: OngoingOrderCell.height)
    }
}
