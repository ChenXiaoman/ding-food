//
//  SearchViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 22/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 The controller for search (stall listing) view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class SearchViewController: UIViewController {
    /// The collection view used to show the listing of stalls.
    @IBOutlet private weak var stallListing: UICollectionView!

    override func viewWillAppear(_ animated: Bool) {
        // Hides the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
        stallListing.delegate = self
        stallListing.dataSource = self
    }
}
