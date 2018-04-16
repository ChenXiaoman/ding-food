//
//  UIImageView+WebImage.swift
//  ding
//
//  Created by Yunpeng Niu on 28/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase
import FirebaseStorageUI

/**
 Extension for `UIImageView` to provide some utility methods for web images.

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
extension UIImageView {
    /// Sets the content of a certain image view to be from web.
    /// - Parameters:
    ///    - path: The path at which the web image is stored.
    ///    - placeholder: The placeholder image to be shown before the image is loaded,
    /// whose default value is `nil`.
    func setWebImage(at path: String, placeholder: UIImage? = nil) {
        sd_setImage(with: StorageRef.getNodeRef(of: path), placeholderImage: placeholder)
    }
}
