//
//  MenuViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase
import FirebaseDatabaseUI

/**
 A controller to handle showing all food in this stall's menu
 */
class MenuViewController: UIViewController {

    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var menuView: UICollectionView!

    /// A view that shows no food in menu
    private var noFoodLabel: UIView?

    /// The Firebase data source for the listing of food.
    var dataSource: FUICollectionViewDataSource?
    /// The path in database to retrieve the menu
    private let menuPath = StallDetails.path + "/\(Account.stallId)" + Food.path

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNoFoodLabel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        configureCollectionView()

        loadingIndicator.startAnimating()
        noFoodLabel?.isHidden = true
        checkLoadingTimeout(indicator: loadingIndicator, interval: Constants.timeoutInterval) {
            self.loadingIndicator.stopAnimating()
            self.noFoodLabel?.isHidden = false
        }
    }

    /// Prepare the label that indicates no food in menu and add it as subview of `menuView`
    private func prepareNoFoodLabel() {
        let noFoodLabel = NothingToDisplayView(frame: menuView.frame, message: "No food here")
        self.noFoodLabel = noFoodLabel
        menuView.addSubview(noFoodLabel)
    }

    /// Binds Firebase data source to collection view.
    private func configureCollectionView() {
        let query = DatabaseRef.getNodeRef(of: menuPath).queryOrdered(byChild: "name")
        dataSource = FUICollectionViewDataSource(query: query, populateCell: populateMenuCell)
        dataSource?.bind(to: menuView)
        menuView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop binding to avoid program crash
        dataSource?.unbind()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedItem = sender as? UIView else {
            fatalError("Select item must be an UIView")
        }
        switch segue.identifier {
        case EditFoodViewController.segueIdentifier?:
            guard
                let indexPath = menuView.indexPathForItem(at: selectedItem.center),
                let cell = menuView.cellForItem(at: indexPath) as? MenuCollectionViewCell,
                let foodId = cell.cellTag else {
                    return
            }
            guard let editFoodVC = segue.destination as? EditFoodViewController else {
                return
            }
            editFoodVC.initialize(foodId: foodId, foodPhoto: cell.foodPhoto)
        default:
            break
        }
    }
    
    @IBAction func toggleSoldOut(_ sender: UIButton) {
        // Convert the button center from local cell frame to the whole collection view frame
        guard let center = sender.superview?
            .convert(sender.center, to: sender.superview?.superview?.superview) else {
                return
        }
        guard
            let indexPath = menuView.indexPathForItem(at: center),
            let menuCell = menuView.cellForItem(at: indexPath) as? MenuCollectionViewCell,
            let foodId = menuCell.cellTag else {
                return
        }

        guard var targetFood = Account.stall?.menu?[foodId] else {
            return
        }
        targetFood.isSoldOut = !targetFood.isSoldOut
        Account.stall?.addFood(targetFood)
    }

    @IBAction func longPressToDeleteFood(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: sender.view)
        guard
            let indexPath = menuView.indexPathForItem(at: location),
            let menuCell = menuView.cellForItem(at: indexPath) as? MenuCollectionViewCell,
            let foodId = menuCell.cellTag else {
                return
        }

        DialogHelpers.promptConfirm(in: self, title: "Warning", message: "Do you want to delete this food?",
                                    cancelButtonText: "Cancel") {
                                        Account.stall?.deleteFood(by: foodId)
                                        if Account.stall?.menu?.isEmpty == true {
                                            self.noFoodLabel?.isHidden = false
                                        }
        }
    }

    /// Populates a `MenuCollectionViewCell` with the given data from database.
    /// - Parameters:
    ///    - collectionView: The collection view as the listing of food.
    ///    - indexPath: The index path of this cell.
    ///    - snapshot: The snapshot of the corresponding food object from database.
    /// - Returns: a `MenuCollectionViewCell` to use.
    private func populateMenuCell(collectionView: UICollectionView,
                                  indexPath: IndexPath,
                                  snapshot: DataSnapshot) -> MenuCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier,
                                                            for: indexPath) as? MenuCollectionViewCell else {
                                                                fatalError("Unable to dequeue a cell.")
        }
        if loadingIndicator.isAnimating {
            loadingIndicator.stopAnimating()
        }
        noFoodLabel?.isHidden = true
        if let food = Food.deserialize(snapshot) {
            cell.load(food)
        }
        return cell
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellAndInsetSize = collectionView.frame.width / CGFloat(MenuViewConstants.numCellsPerRow)
        let cellWidth = cellAndInsetSize * CGFloat(MenuViewConstants.cellRatio)
        let cellHeight = cellWidth * CGFloat(MenuViewConstants.heightWidthRatio)
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellAndInsetSize = collectionView.frame.width / CGFloat(MenuViewConstants.numCellsPerRow)
        // half the spacing because both left and right has this spacing
        return cellAndInsetSize * CGFloat(1 - MenuViewConstants.cellRatio) * 0.5
    }

}
