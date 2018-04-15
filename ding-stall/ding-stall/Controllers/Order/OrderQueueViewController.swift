//
//  OrderQueueViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import AVFoundation
import FirebaseDatabaseUI

/**
 The controller for the order queue view
 Order queue only contains orders have not been collected
 */
class OrderQueueViewController: OrderViewController {
    
    @IBOutlet private weak var orderQueueCollectionView: UICollectionView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!

    /// Indicate which order cell is selected, used for change the view
    private var currentSelectedCell: OrderQueueCollectionViewCell?
    /// Indicate which order model is associated with the current selected cell
    private var currentSelectedOrder: Order?
    /// Store all order models in this stall
    private var orderDict = [String: Order]()
    /// A view that indicates no order in the queue currently
    private var noOrderLabel: UIView?

    // To check isRinging property
    private var settings = Settings()
    /// Plays ringing sound every new order if successfully initialised
    private var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNoOrderLabel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)

        // Configure audioPlayer based on updated settings
        setAudioPlayer()

        loadingIndicator.startAnimating()
        checkLoadingTimeout(indicator: loadingIndicator, interval: Constants.timeoutInterval) {
            self.loadingIndicator.stopAnimating()
            self.noOrderLabel?.isHidden = false
        }
        configureCollectionView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop binding to avoid program crash
        dataSource?.unbind()
    }

    /// Prepare the label that indicates no order in queue and add
    /// it as subview of `orderQueueCollectionView`
    private func prepareNoOrderLabel() {
        let noOrderLabel = NothingToDisplayView(frame: orderQueueCollectionView.frame, message: "No orders")
        noOrderLabel.isHidden = true
        self.noOrderLabel = noOrderLabel
        orderQueueCollectionView.addSubview(noOrderLabel)
    }

    /// Bind collection view to the database
    private func configureCollectionView() {
        let query = DatabaseRef.getNodeRef(of: Order.path).queryOrdered(byChild: "stallId")
            .queryEqual(toValue: Account.stallId)
        dataSource = FUICollectionViewDataSource(query: query, populateCell: generateOrderCell)
        dataSource?.bind(to: orderQueueCollectionView)
        orderQueueCollectionView.delegate = self
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

        if loadingIndicator.isAnimating {
            loadingIndicator.stopAnimating()
        }
        noOrderLabel?.isHidden = true

        if var order = Order.deserialize(snapshot) {
            if order.status == .pending {
                audioPlayer?.play()
            }

            if settings.isAutomaticAcceptOrder && order.status == .pending {
                order.status = .accepted
                order.save()
            }

            orderDict[order.id] = order
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
            orderDict[currentSelectedOrder?.id ?? ""] = nil
            if orderDict.isEmpty {
                noOrderLabel?.isHidden = false
            }
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
        currentSelectedOrder = orderDict[currentSelectedCell?.cellTag ?? ""]
        guard
            let statusRawValue = sender.titleLabel?.text,
            let newStatus = OrderStatus(rawValue: statusRawValue) else {
                return
        }
        DialogHelpers.promptConfirm(in: self, title: "Confirm \(statusRawValue) ?",
                                    message: "Are you sure to change order status to be " + statusRawValue,
                                    cancelButtonText: "Cancel") {
                                        self.changeOrderStatus(to: newStatus)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OrderQueueViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? OrderCollectionViewCell,
            let order = orderDict[cell.cellTag ?? ""] else {
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
