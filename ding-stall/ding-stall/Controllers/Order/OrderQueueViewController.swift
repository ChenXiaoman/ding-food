//
//  OrderQueueViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI
import AVFoundation

/**
 The controller for the order queue view
 Order queue only contains orders have not been collected
 */
class OrderQueueViewController: OrderViewController {
    
    @IBOutlet private weak var orderQueueCollectionView: UICollectionView!

    /// Indicate which order cell is selected, used for change the view
    private var currentSelectedCell: OrderQueueCollectionViewCell?
    /// Indicate which order model is associated with the current selected cell
    private var currentSelectedOrder: Order?
    /// Store all order models in this stall
    private var orderDict = [IndexPath: Order]()
  
    /// The customer names of all orders
    private var nameDict = [String: String]()

    // To check isRinging property
    private var settings = Settings()
    /// Plays ringing sound every new order if successfully initialised
    private var audioPlayer: AVAudioPlayer?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)

        // Configure audioPlayer based on updated settings
        setAudioPlayer()

        let query = DatabaseRef.getNodeRef(of: Order.path).queryOrdered(byChild: "stallId")
            .queryEqual(toValue: Account.stallId)
        dataSource = FUICollectionViewDataSource(query: query, populateCell: generateOrderCell)
        dataSource?.bind(to: orderQueueCollectionView)
        orderQueueCollectionView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop binding to avoid program crash
        dataSource?.unbind()
    }

    private func setAudioPlayer() {
        guard settings.isRinging else {
            audioPlayer = nil
            return
        }

        audioPlayer = Audio.setupPlayer(fileName: "bell", loop: 0)
    }

    /// Generate a `OrderQueueCollectionViewCell` with the given data from database.
    /// - Parameters:
    ///    - CollectionView: The Collection view as the listing of orders.
    ///    - indexPath: The index path of this cell.
    ///    - snapshot: The snapshot of the corresponding order object from database.
    /// - Returns: a `OrderQueueCollectionViewCell` to use.
    private func generateOrderCell(collectionView: UICollectionView,
                                   indexPath: IndexPath,
                                   snapshot: DataSnapshot) -> OrderQueueCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                                OrderQueueCollectionViewCell.identifier,
                                                            for: indexPath) as? OrderQueueCollectionViewCell else {
                                                                fatalError("Unable to dequeue a cell.")
        }

        if var order = Order.deserialize(snapshot) {
            if order.status == .pending {
                audioPlayer?.play()
            }

            if settings.isAutomaticAcceptOrder && order.status == .pending {
                order.status = .accepted
                order.save()
            }

            orderDict[indexPath] = order
            populateOrderCell(cell: cell, model: order)
        }

        return cell
    }

    /// Change the status of `currentSelectedOrder` to the new status
    /// The status label in the view will also be changed
    /// - Parameter: newStatus: The new status to be changed
    private func changeOrderStatus(to newStatus: OrderStatus) {
        // Change the model
        currentSelectedOrder?.status = newStatus
        // If the order is collected or rejected, it will be removed
        // from this list
        guard newStatus.isOngoingOrderStatus else {
            currentSelectedCell = nil
            currentSelectedOrder = nil
            return
        }
        currentSelectedOrder?.save()
        // Change the view
        currentSelectedCell?.setStatus(to: newStatus)
        // Set to nil to avoid affecting subsequent status change
        currentSelectedCell = nil
        currentSelectedOrder = nil
    }

    /// Handle pressing an order status button
    /// `currentSelectedCell` and `currentSelectedOrder` will be assigned by corresponding
    /// order cell and order model values
    @IBAction func pressStatusButton(_ sender: UIButton) {
        // Convert the button center from local cell frame to the whole collection view frame
        guard let center = sender.superview?
            .convert(sender.center, to: sender.superview?.superview?.superview) else {
                return
        }
        guard let indexPath = orderQueueCollectionView.indexPathForItem(at: center) else {
            return
        }
        currentSelectedCell = orderQueueCollectionView.cellForItem(at: indexPath) as? OrderQueueCollectionViewCell
        currentSelectedOrder = orderDict[indexPath]
        guard
            let statusRawValue = sender.titleLabel?.text,
            let newStatus = OrderStatus(rawValue: statusRawValue) else {
                return
        }
        DialogHelpers.promptConfirm(in: self, title: "Confirm \(statusRawValue) ?",
                                    message: "Are you sure to change order status to be " + statusRawValue) {
                                        self.changeOrderStatus(to: newStatus)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OrderQueueViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let order = orderDict[indexPath] else {
            return
        }
        loadOrderDetailViewController(order: order, animated: true)
    }

    private func loadOrderDetailViewController(order: Order, animated: Bool) {
        let id = Constants.orderDetailControllerId
        guard let orderDetailVC = storyboard?.instantiateViewController(withIdentifier: id)
            as? OrderDetailViewController else {
                fatalError("Could not find the controller for order detail")
        }
        orderDetailVC.initialize(order: order)
        navigationController?.pushViewController(orderDetailVC, animated: animated)
    }
}
