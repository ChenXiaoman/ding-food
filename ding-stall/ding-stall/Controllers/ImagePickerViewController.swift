//
//  ImagePickerViewController.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 30/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

// This file is taken from Eureka ( https://github.com/xmartlabs/Eureka )

import Eureka

/// Selector Controller used to pick an image
open class ImagePickerController: UIImagePickerController {

    /// The row that pushed or presented this controller
    public var row: RowOf<UIImage>!

    /// A closure to be called when the controller disappears.
    public var onDismissCallback: ((UIViewController) -> Void)?

    open override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}

extension ImagePickerController: TypedRowControllerType {
}

extension ImagePickerController: UIImagePickerControllerDelegate {
    open func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        onDismissCallback?(self)
    }

    open func imagePickerController(_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [String: Any]) {
        (row as? ImageRow)?.imageURL = info[UIImagePickerControllerImageURL] as? URL
        row.value = info[UIImagePickerControllerOriginalImage] as? UIImage
        onDismissCallback?(self)
    }
}

extension ImagePickerController: UINavigationControllerDelegate {

}
