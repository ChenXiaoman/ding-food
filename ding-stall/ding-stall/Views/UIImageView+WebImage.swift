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
    /// Sets the content of a certain image view to be from web.
    /// - Parameters:
    ///    - path: The path at which the web image is stored.
    ///    - placeholder: The placeholder image to be shown before the image is loaded,
    /// whose default value is `nil`.
    func setWebImage(at path: String, placeholder: UIImage? = nil) {

        if UIImageView.refreshedURL.contains(path) {
            SDImageCache.shared().removeImage(forKey: StorageRef.getNodeRef(of: path).fullPath) {
                self.sd_setImage(with: StorageRef.getNodeRef(of: path), placeholderImage: placeholder)
            }
            UIImageView.refreshedURL.remove(path)
        } else {
            sd_setImage(with: StorageRef.getNodeRef(of: path), placeholderImage: placeholder)
        }
    }

    /// The image url that need to be refreshed
    private static var refreshedURL = Set<String>()

    public static func addURLShouldBeRefreshed(_ url: String) {
        refreshedURL.insert(url)
    }
}
