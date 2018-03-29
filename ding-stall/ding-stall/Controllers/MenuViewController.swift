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
class MenuViewController: UIViewController {

    @IBOutlet private weak var menuView: UICollectionView!

    private var stall: Stall!

    override func viewDidLoad() {
        DatabaseRef.observeValue(of: Stall.path + "/\(Account.stallId)") { snap in
            self.stall = Stall.deserialize(snap)
            self.menuView.delegate = self
            self.menuView.dataSource = self
            self.menuView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case AddFoodViewController.identifier?:
            guard let addFoodVC = segue.destination as? AddFoodViewController else {
                return
            }
            addFoodVC.stall = self.stall
        default:
            break
        }

    }
}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stall.menu?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier,
                                                            for: indexPath) as? MenuCollectionViewCell else {
                                                                fatalError("Unable to dequeue a cell.")
        }

        cell.load(stall?.getFood(at: indexPath.item))
        return cell
    }
}
