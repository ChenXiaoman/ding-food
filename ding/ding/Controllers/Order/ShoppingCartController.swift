//
//  ShoppingCartController.swift
//  ding
//
//  Created by Yunpeng Niu on 29/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

/**
 The controller for the shopping cart.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class ShoppingCartController: FormViewController {
    /// The format for food row tag in the form.
    private static let foodRowTagFormat = "%@-%@"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configures the indicator for empty shopping cart.
        if ShoppingCart.shoppingCarts.isEmpty {
            form +++ Section("") <<< TextRow { row in
                row.value = "Nothing here yet..."
                row.disabled = true
                row.cell.textField.textAlignment = .center
            }
            return
        }

        // Configures the form to show all orders up to now.
        addForm()
    }

    /// Populates the form content according to the food inside the `ShoppingCart`s.
    private func addForm() {
        for (stallId, cart) in ShoppingCart.shoppingCarts {
            // Adds a new section for each stall.
            let section = Section(cart.stall.name)
            section.tag = stallId
            form +++ section

            // Adds a new `StepperRow` for each food.
            for (foodId, food) in cart.food {
                let name = food.food.name
                let quantity = food.quantity
                section <<< makeFoodRow(stallId: stallId, foodId: foodId, foodName: name, quantity: quantity)
            }

            // Adds a "Submit" `ButtonRow` for each stall.
            section <<< makeSubmitButton(stallId: stallId)
        }
    }

    /// The factory method for a new `StepperRow` to display food.
    /// - Parameters:
    ///    - stallId: The id of the stall this food belongs to.
    ///    - foodId: The id of this food.
    ///    - foodName: The displayed name of this food.
    ///    - quantity: The current amount of this food ordered.
    /// - Returns: A new `StepperRow` to display this food.
    private func makeFoodRow(stallId: String, foodId: String, foodName: String, quantity: Int) -> StepperRow {
        // The tag of this food row.
        let rowTag = String(format: ShoppingCartController.foodRowTagFormat, stallId, foodId)

        return StepperRow { row in
            row.title = foodName
            row.value = Double(quantity)
            row.tag = rowTag
            // Hides this row when its value becomes 0.
            row.hidden = Condition.function([rowTag]) { _ in
                return row.value == 0
            }
        }.onChange { row in
            guard let value = row.value else {
                return
            }
            // Updates the model whenever the row's value is changed.
            ShoppingCart.change(foodId, from: stallId, quantity: Int(value))
        }
    }

    /// The factory method for a new `ButtonRow` to act as the submit button for this stall.
    /// - Parameter stallId: The id of the stall this order belongs to.
    /// - Returns: A new `ButtonRow` to act as the submit button.
    private func makeSubmitButton(stallId: String) -> ButtonRow {
        return ButtonRow { row in
            row.title = "Submit"
        }.onCellSelection { _, row in
            guard let order = ShoppingCart.shoppingCarts[stallId]?.toOrder() else {
                return
            }
            // Submits the order, removes the order record and closes the shopping cart.
            order.save()
            ShoppingCart.shoppingCarts[stallId] = nil
            self.dismiss(animated: true, completion: nil)
        }
    }
}
