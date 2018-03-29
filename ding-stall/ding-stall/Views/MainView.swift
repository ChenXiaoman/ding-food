//
//  MainView.swift
//  ding-stall
//
//  Created by Calvin Tantio on 29/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class MainView: UIView {

    var signUpButton: UIButton!
    var signInButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initButtons()
    }

    private func initButtons() {
        signUpButton = UIButton(type: .custom)
        signUpButton.setTitle("Sign Up", for: .normal)

        signInButton = UIButton(type: .custom)
        signInButton.setTitle("Sign In", for: .normal)

//        [signUpButton, signInButton].forEach {
//            $0?.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth - 2 * Constants.screenPadding, height: Constants.screenHeight * 0.3)
//            $0?.addTarget(self, action: #didPressButton, for: <#T##UIControlEvents#>)
//
//        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    

}
