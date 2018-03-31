//
//  FoodDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 23/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI

class FoodDetailViewController: UIViewController {
    /// The current food object.
    var food: Food?
    /// The current stall key.
    var stallKey: String?
    
    /// View displaying current food's info.
    @IBOutlet private weak var foodImageView: UIImageView!
    @IBOutlet private weak var foodNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var foodDescriptionLabel: UILabel!
    
    /// The text format to display price.
    private static let priceFormat = "$%.1f"
    /// The text format to display description.
    private static let descriptionFormat = "\"%@\""
    
    override func viewWillAppear(_ animated: Bool) {
        foodImageView.setWebImage(at: food?.photoPath, placeholder: #imageLiteral(resourceName: "food-icon"))
        foodNameLabel.text = food?.name
        priceLabel.text = String(format: FoodDetailViewController.priceFormat, food?.price ?? "")
        // Display description only when it is not empty
        if let description = food?.description {
            foodDescriptionLabel.text = String(format: FoodDetailViewController.descriptionFormat, description)
        } else {
            foodDescriptionLabel.removeFromSuperview()
        }

        // Configures the navigation bar.
        let item = UIBarButtonItem(image: #imageLiteral(resourceName: "shopping-cart"), style: .plain, target: self, action: #selector(openShoppingCart))
        navigationItem.setRightBarButton(item, animated: animated)
    }

    /// Opens the shopping cart when the button on the navigation bar is pressed.
    @objc
    func openShoppingCart() {
        
    }
}
