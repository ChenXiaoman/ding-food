//
//  OrderHistoryDetailViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 12/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase
import Eureka

class OrderHistoryDetailViewController: OrderDetailViewController {

    private var review: Review?

    /// Intialize the order model by segue
    func initialize(order: Order, review: Review?) {
        super.initialize(order: order)
        self.review = review
    }

    override func viewWillAppear(_ animated: Bool) {
        populateReview()
        super.viewWillAppear(animated)
    }

    /// Populate the review details into the form
    private func populateReview() {
        guard let reviewDetail = review else {
            return
        }
        form
            +++ Section("Review")
            <<< TextRow { row in
                row.title = "Rating"
                row.value = reviewDetail.rating.description
                row.disabled = true
            }
            <<< TextAreaRow { row in
                row.value = reviewDetail.reviewText
                row.disabled = true
            }
    }
}
