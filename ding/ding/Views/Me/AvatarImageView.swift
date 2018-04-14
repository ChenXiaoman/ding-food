//
//  AvatarImageView.swift
//  ding
//
//  Created by Yunpeng Niu on 14/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

/**
 A customize `UIImageView` to display avatar.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
class AvatarImageView: UIImageView {
    /// Loads an avatar from a certain path.
    /// Parameter path: The path at which the avatar is stored.
    func load(from path: String) {
        setWebImage(at: path, placeholder: #imageLiteral(resourceName: "avatar"))
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}
