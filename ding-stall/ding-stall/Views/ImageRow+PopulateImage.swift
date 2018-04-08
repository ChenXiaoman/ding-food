//
//  ImageRow+PopulateImage.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 08/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import Eureka

extension ImageRow {

    /// Populate the image row with the given image data
    /// - Parameters:
    ///    - data: the image data
    ///    - error: the error thrown during download
    func populateImage(data: Data?, error: Error?) {

        guard let imageData = data, error == nil else {
            return
        }
        let image = UIImage(data: imageData)
        value = image
        updateCell()
    }
}
