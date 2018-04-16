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

 - Author: Group 3 @ CS3217
 - Date: March 2018
 */
extension UIImageView {
    /// The image path that need to be refreshed.
    private static var pathToRefresh = Set<String>()

    /// Sets the content of a certain image view to be from web.
    /// - Parameters:
    ///    - path: The path at which the web image is stored.
    ///    - placeholder: The placeholder image to be shown before the image is loaded,
    /// whose default value is `nil`.
    public func setWebImage(at path: String, placeholder: UIImage? = nil) {
        if UIImageView.pathToRefresh.contains(path) {
            SDImageCache.shared().removeImage(forKey: StorageRef.getNodeRef(of: path).fullPath) {
                self.sd_setImage(with: StorageRef.getNodeRef(of: path), placeholderImage: placeholder)
            }
            UIImageView.pathToRefresh.remove(path)
        } else {
            sd_setImage(with: StorageRef.getNodeRef(of: path), placeholderImage: placeholder)
        }
    }

    /// Add an image path into set to mark it as need to refresh
    /// - Parameter: path: the image path need to be refreshed
    public static func addPathShouldBeRefreshed(_ path: String) {
        pathToRefresh.insert(path)
    }
}
