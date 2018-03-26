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
    private var menuView = UICollectionView()
    private let storage = Storage()
    override func viewDidLoad() {
        super.viewDidLoad()
        settleMenuView()
    }

    private func settleMenuView() {
        menuView.dataSource = menuView.bind(to: Storage.reference) { collectionView, indexPath, snap in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
                    return UICollectionViewCell()
            }
            /* populate cell */
            return cell
        }
    }
}
