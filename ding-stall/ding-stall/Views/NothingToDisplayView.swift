//
//  NothingToDisplayView.swift
//  ding-stall
//
//  Created by Calvin Tantio on 14/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
/**
 A filler view to tell user that there is nothing to display.
 This view is used, for example, in the menu view or order view
 when there is no menu and/or order yet.
 */
class NothingToDisplayView: UIView {

    private func createTextLabel(message: String) -> UILabel {
        let label = UILabel()
        label.text = message
        label.font = UIFont.boldSystemFont(ofSize: 40.0)

        label.numberOfLines = 0
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        label.backgroundColor = .clear

        return label
    }

    init(frame: CGRect, message: String) {
        super.init(frame: frame)

        backgroundColor = .clear
        
        let text = createTextLabel(message: message)
        addSubview(text)
        text.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        text.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        text.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
