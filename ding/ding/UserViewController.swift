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
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func makeOrder(food: Food, quantity: Int) {
        order.add(food: food, quantity: quantity)
    }

    func confirmOrder() {
        order.confirm()
        // TODO: add this order into queue
        guard timer == nil else {
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: refreshOrder)
    }

    func makeReview(text: String, rating: Rating, toOrder order: inout Order) {
        // TODO: replace this dummy id
        let newReview = Review(id: "0", rating: rating, reviewText: text)
        order.addReview(newReview)
    }

    func refreshOrder(timer: Timer) {
        let orders = Set<Order>()
        //TODO: fetch orders from database
        let notifiedOrders = orders.filter { $0.shouldNotify }
        guard !notifiedOrders.isEmpty else {
            return
        }
        notifiedOrders.forEach { notify(order: $0) }
    }

    func notify(order: Order) {
        //TODO: create a view for this order
        //TODO: make the phone vibrate
    }
}
