//
//  MenuViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 24/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseDatabaseUI
import UIKit

/**
 The controller of stall's menu view
 */
class MenuViewController: UIViewController {

    @IBOutlet private var menuView: UICollectionView!

    private var stall: Stall!

    override func viewDidLoad() {
        super.viewDidLoad()
        //settleMenuView()
    }

    private func settleMenuView() {
        menuView.delegate = self
        menuView.dataSource = menuView.bind(to: Storage.reference) { collectionView, indexPath, snap in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else {
                    return UICollectionViewCell()
            }
            
            return cell
        }
    }

    @IBAction func didPressAddFoodButton(_ sender: UIButton) {
        let popupView = createAddFoodView()
        view.addSubview(popupView)
    }

    private func createAddFoodView() -> UIView {
        let numberOfViews = 5
        let addFoodView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: 0.5 * view.frame.size))
        addFoodView.center = view.center
        let textFrame = CGRect(origin: CGPoint(),
                               size: CGSize(width: addFoodView.frame.width,
                                            height: addFoodView.frame.height / numberOfViews))
        let nameText = NameTextFieldGenerator(frame: textFrame).create()
        let priceText = PriceTextFieldGenerator(frame: VerticalLayout.nextFrame(from: nameText.frame))
            .create()
        addFoodView.addSubview(nameText)
        addFoodView.addSubview(priceText)
        let nextFrame = VerticalLayout.nextFrame(from: priceText.frame)
        let buttonFrame = CGRect(origin: nextFrame.origin,
                                 size: CGSize(width: nextFrame.width * 0.5, height: nextFrame.height))
        let addButton = UIButton(frame: buttonFrame)
        let cancelButton = UIButton(frame: HorizontalLayout.nextFrame(from: addButton.frame))
        addButton.setTitle("Add", for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        addButton.addTarget(self, action: #selector(addFood), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelAdd), for: .touchUpInside)
        addFoodView.addSubview(addButton)
        addFoodView.addSubview(cancelButton)
        addFoodView.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        return addFoodView
    }

    @objc
    private func cancelAdd(_ sender: UIButton) {
        sender.superview?.removeFromSuperview()
    }

    @objc
    private func addFood() {
        print("add")
    }
}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}
