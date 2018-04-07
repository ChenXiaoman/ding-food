//
//  OrderView.swift
//  ding
//
//  Created by Chen Xiaoman on 7/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI

class OrderView: UIView {
    @IBOutlet weak private var stallName: UILabel!
    @IBOutlet weak private var stallPhoto: UIImageView!
    @IBOutlet weak private var orderStatus: OrderStatusLabel!
    @IBOutlet weak private var orderTime: UILabel!
    
    /// The format to display order time.
    private static let timeFormat = "Ordered at: %@"
    
    /// Loads data into and populate a `OrderView`.
    /// - Parameter order: The `Order` object as the data source.
    func load(_ order: Order) {
        // Loads order.
        orderStatus.load(order.status)
        orderTime.text = String(format: OrderView.timeFormat, "\(order.createdAt)")
        // Loads the related stall overview.
        let path = "\(StallOverview.path)/\(order.stallId)"
        DatabaseRef.observeValueOnce(of: path, onChange: loadStoreOverview)
    }
    
    /// Loads data (about stall) into a `OrderView`.
    /// - Parameter snapshot: The database snapshot containing a `StallOverview` object.
    private func loadStoreOverview(from snapshot: DataSnapshot) {
        guard let stall = StallOverview.deserialize(snapshot) else {
            return
        }
        stallPhoto.setWebImage(at: stall.photoPath, placeholder: #imageLiteral(resourceName: "stall-placeholder"))
        stallPhoto.clipsToBounds = true // Use for enable corner radius
        stallName.text = stall.name
        
        // Stop observer after getting stall details
        DatabaseRef.stopObservers(of: "\(StallOverview.path)/\(stall.id)")
    }
}
