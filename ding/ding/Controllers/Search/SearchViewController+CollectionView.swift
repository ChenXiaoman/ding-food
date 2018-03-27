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
        guard let controller = storyboard?.instantiateViewController(withIdentifier: id) else {
                return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    /// Sets the number of sections.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    /// Data source for each cell.
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StallListingCell.identifier,
                                                            for: indexPath) as? StallListingCell else {
            fatalError("Unable to dequeue cell.")
        }
        let stall = StallOverview(id: "123", name: "Western Food", queueCount: 10, averageRating: 4.7, photo: #imageLiteral(resourceName: "launch-background"))
        cell.load(stall)
        return cell
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
