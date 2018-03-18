//
//  UserViewController.swift
//  DingPod
//
//  Created by Jiang Chunhui on 17/03/18.
//  Copyright © 2018年 JCH. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var user: User?
    // TODO: replace this dummy id
    var order = Order(id: "0")
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func makeOrder(food: Food, quantity: Int) {
        order.add(food: food, quantity: quantity)
    }

    func confirmOrder() {
        order.confirm()
        // TODO: add this order into queue
    }

    func makeReview(text: String, rating: Rating, toOrder order: inout Order) {
        // TODO: replace this dummy id
        let newReview = Review(id: "0", rating: rating, reviewText: text)
        order.addReview(newReview)
    }

    func notify(order: Order) {
        //TODO: create a view for this order
        //TODO: make the phone vibrate
    }
}
