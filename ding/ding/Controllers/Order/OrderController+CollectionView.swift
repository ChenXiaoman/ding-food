//
//  OrderController+CollectionView.swift
//  ding
//
//  Created by Yunpeng Niu on 31/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 Extension for `OrderController` so that it can manage the collection view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
extension OrderController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = Constants.orderDetailControllerId
        guard let controller = storyboard?.instantiateViewController(withIdentifier: id)
            as? OrderDetailViewController else {
                return
        }
        // Passes in the `Order` object displayed at this cell.
        if let order = orders[indexPath.totalItem(in: collectionView)] {
            controller.order = order
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension OrderController: UICollectionViewDelegateFlowLayout {
    /// Sets the size of each cell.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: OngoingOrderCell.width, height: OngoingOrderCell.height)
    }
}
