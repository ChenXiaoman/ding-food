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

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
extension SearchViewController: UICollectionViewDelegate {
    /// Jumps to stall details view when a certain is selected.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = Constants.stallDetailControllerId
        guard let controller = storyboard?.instantiateViewController(withIdentifier: id)
            as? StallDetailController else {
            return
        }
        // Passes in the `id` of `StallOverview` displayed at this cell.
        if let stallId = stallIds[indexPath.totalItem(in: collectionView)] {
            controller.stallKey = stallId
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    /// Sets the size of each cell.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: StallListingCell.width, height: StallListingCell.height)
    }
}
