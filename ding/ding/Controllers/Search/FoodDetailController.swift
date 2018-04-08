//
//  FoodDetailViewController.swift
//  ding
//
//  Created by Chen Xiaoman on 23/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

/**
 The controller for food details view.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class FoodDetailController: UIViewController {
    /// The view to display information about the food.
    @IBOutlet weak private var foodOverviewView: FoodOverviewView!
    /// The button to add to shopping cart.
    @IBOutlet weak private var addToShoppingCartButton: MenuButton!
    /// The button to order the food immediately.
    @IBOutlet weak private var orderImmediatelyButton: MenuButton!
    /// The current food object.
    var food: Food?
    /// The id of the current stall.
    var stall: StallOverview?
    
    override func viewWillAppear(_ animated: Bool) {
        // Configures the navigation bar.
        let item = UIBarButtonItem(image: #imageLiteral(resourceName: "shopping-cart"), style: .plain, target: self, action: #selector(openShoppingCart))
        navigationItem.setRightBarButton(item, animated: animated)
        if let stallName = stall?.name {
            title = stallName
        }

        // Hides the keyboard when the user stops editing.
        hideKeyboardWhenTappedAround()

        // Displays the food information.
        guard let food = food else {
            return
        }
        foodOverviewView.load(food: food)

        // Configures the add to shopping cart button.
        if food.isSoldOut {
            orderImmediatelyButton.disable(text: Constants.soldOutButtonText)
            addToShoppingCartButton.isHidden = true
        } else if let stallId = stall?.id, ShoppingCart.has(food.id, from: stallId) {
            toggleAddToShoppingCartButton()
        }
    }

    /// Adds the food to the shopping cart when the button is pressed.
    /// - Parameter sender: The button being pressed.
    @IBAction func addToShoppingCart(_ sender: MenuButton) {
        /// Performs permission checking.
        guard checkPermission() else {
            return
        }
        guard let currentStall = stall, let currentFood = food else {
            return
        }
        ShoppingCart.add(currentFood, from: currentStall, quantity: 1)
        openShoppingCart()
        toggleAddToShoppingCartButton()
    }

    /// Order a food immediatly with order default amount 1
    @IBAction func orderImmediately(_ sender: Any) {
        /// Performs permission checking.
        guard checkPermission() else {
            return
        }
        /// Make a order of this food
        guard let currentStall = stall, let currentFood = food else {
            return
        }
        let foodAmount = [currentFood: Constants.orderDefaultAmount]
        let order = Order(stall: currentStall, food: foodAmount)
        order.save()
        
        alertOrderSuccessful()
    }
    
    /// Opens the shopping cart when the button on the navigation bar is pressed.
    @objc
    func openShoppingCart() {
        /// Performs permission checking.
        guard checkPermission() else {
            return
        }
        let id = Constants.shoppingCartControllerId
        guard let controller = storyboard?.instantiateViewController(withIdentifier: id)
            as? ShoppingCartController else {
            fatalError("Cannot find the controller.")
        }
        controller.modalPresentationStyle = .popover
        controller.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        controller.parentController = self
        present(controller, animated: true, completion: nil)
    }

    /// Toggles the button for "Add To Shopping Cart" between normal and disabled state.
    func toggleAddToShoppingCartButton() {
        if addToShoppingCartButton.isEnabled {
            addToShoppingCartButton.disable(text: "Already added")
        } else {
            addToShoppingCartButton.enable(text: "Add to Shopping Cart")
        }
    }
}
