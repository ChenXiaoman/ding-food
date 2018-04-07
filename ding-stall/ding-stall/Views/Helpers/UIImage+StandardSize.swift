//
//  UIImage+StandardSize.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 04/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// Compress an image to avoid large-size image
    /// - Return: the data of compressed image, nil if it cannot be compressed
    var standardData: Data? {
        let originalImageSize = self.size.width * self.size.height
        var quality = CGFloat(Constants.standardImageSize) / originalImageSize
        if quality > 1 {
            quality = 1
        }
        return UIImageJPEGRepresentation(self, quality)
    }
}
