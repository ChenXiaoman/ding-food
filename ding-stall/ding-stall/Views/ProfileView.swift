//
//  ProfileView.swift
//  ding-stall
//
//  Created by Calvin Tantio on 28/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class ProfileView: UIView {

    private struct ClassConstants {
        static let textFieldWidth = Constants.screenWidth * 0.8
        static let textFieldHeight = Constants.screenHeight * 0.1

        static let buttonWidth = textFieldWidth
        static let buttonHeight = textFieldHeight

        static let titleRectHeight = Constants.screenHeight * 0.3
    }

    var nameTextField: UITextField!
    var locationTextField: UITextField!
    var openingHourTextField: UITextField! // TODO: Change this. Should be more complex than this. May not be textField
    var descriptionTextField: UITextField!
    var filterTextField: UITextField! // TODO: Change this. Should be more complex than this. May not be textField

    var title: UILabel!

    var confirmButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewTitle()
        initTextFields()
        initButton()
        initStackView()
    }

    private func initViewTitle() {
        let titleContainer: UIView = UIView(frame:CGRect(x: Constants.screenPadding,
                                                         y: Constants.screenPadding,
                                                         width: Constants.screenWidth - 2 * Constants.screenPadding,
                                                         height: ClassConstants.titleRectHeight))
        title = UILabel()
        title.text = "Stall Profile"
        title.textAlignment = NSTextAlignment.center
        title.font = UIFont(name: "Chalkduster", size: 30)
        title.translatesAutoresizingMaskIntoConstraints = false

        titleContainer.addSubview(title)
        title.centerXAnchor.constraint(equalTo: titleContainer.centerXAnchor).isActive = true
        title.widthAnchor.constraint(equalTo: titleContainer.widthAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: titleContainer.centerYAnchor).isActive = true
        title.heightAnchor.constraint(equalTo: titleContainer.heightAnchor).isActive = true

        addSubview(titleContainer)
    }

    private func initTextFields() {
        let textFieldRect = CGRect(x: 0, y: 0, width: ClassConstants.textFieldWidth,
                                        height: ClassConstants.textFieldHeight)

        nameTextField = CustomTextField(frame: textFieldRect, placeHolder: "Name");
        locationTextField = CustomTextField(frame: textFieldRect, placeHolder: "Locaion")
        openingHourTextField = CustomTextField(frame: textFieldRect, placeHolder: "Opening hour")
        descriptionTextField = CustomTextField(frame: textFieldRect, placeHolder: "Description")
        filterTextField = CustomTextField(frame: textFieldRect, placeHolder: "Filter(s)")
    }

    private func initButton() {
        confirmButton = UIButton(type: .system)
        confirmButton.setAttributedTitle(NSAttributedString(string: "Confirm"), for: UIControlState.normal)

        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        confirmButton.titleLabel?.adjustsFontSizeToFitWidth = true
        confirmButton.titleLabel?.minimumScaleFactor = 0.1

        confirmButton.frame = CGRect(x: 0, y: 0,
            width: Constants.screenWidth - Constants.screenPadding, height: ClassConstants.buttonHeight)
    }

    private func initStackView() {
        let stackViewSubviews: [UIView] = [nameTextField, locationTextField, openingHourTextField,
                          descriptionTextField, filterTextField, confirmButton]

        let textFieldsStackView = UIStackView(arrangedSubviews: stackViewSubviews)
        textFieldsStackView.axis = .vertical
        textFieldsStackView.distribution = .equalSpacing
        textFieldsStackView.frame = CGRect(x: Constants.screenPadding,
                                           y: Constants.screenPadding + ClassConstants.titleRectHeight,
                                           width: Constants.screenWidth - 2 * Constants.screenPadding,
                                           height: Constants.screenHeight - 2 * Constants.screenPadding - ClassConstants.titleRectHeight)

        addSubview(textFieldsStackView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
