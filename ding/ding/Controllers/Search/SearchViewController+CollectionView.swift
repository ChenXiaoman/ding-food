//
//  SearchViewController+CollectionView.swift
//  ding
//
//  Created by Yunpeng Niu on 27/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Extension for `SearchViewController` so that it can manage the collection view.
 */
extension SearchViewController: UICollectionViewDelegate {
    /// Jumps to stall details view when a certain is selected.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = Constants.stallDetailControllerId
        guard let controller = storyboard?.instantiateViewController(withIdentifier: id)
            as? StallDetailController else {
                return
        }
        
        // Pass in Firebase stall overview reference at selected index path
//        controller.stallOverviewRef = stallOverViewObjects?.ref(for:
//            indexPath.fireBaseCollectionIndex(in: stallListing))
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    /// Sets the size of each cell (to fit 11/12 cells per row).
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: StallListingCell.width, height: StallListingCell.height)
    }
}
