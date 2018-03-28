//
//  UIImageView+WebImage.swift
//  ding
//
//  Created by Yunpeng Niu on 28/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import FirebaseStorageUI

/**
 Extension for `UIImageView` to provide some utility methods for web images.
 */
extension UIImageView {
    func setWebImage(at path: String, placeholder: UIImage? = nil) {
        sd_setImage(with: StorageRef.getNodeRef(of: path), placeholderImage: placeholder)
    }
}
