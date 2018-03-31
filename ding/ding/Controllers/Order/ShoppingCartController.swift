//
//  ShoppingCartController.swift
//  ding
//
//  Created by Yunpeng Niu on 29/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The controller for the shopping cart.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class ShoppingCartController: UIViewController {
    /// A collection view that is used to display shopping cart.
    @IBOutlet weak private var shoppingCart: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        shoppingCart.delegate = self
        shoppingCart.dataSource = self
    }
}

extension ShoppingCartController: UICollectionViewDelegate {

}

extension ShoppingCartController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingCartCell.identifier,
                                                      for: indexPath) as? ShoppingCartCell else {
            fatalError("Unable to dequeue cell.")
        }
        return cell
    }
}
