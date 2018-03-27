//
//  UIViewsLayout.swift
//  ding-stall
//
//  Created by Jiang Chunhui on 26/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

class VerticalLayout {

    static func nextFrame(from originFrame: CGRect) -> CGRect {
        let newOrigin = CGPoint(x: originFrame.origin.x,
                                y: originFrame.origin.y + originFrame.height)
        return CGRect(origin: newOrigin, size: originFrame.size)
    }
    
}

class HorizontalLayout {

    static func nextFrame(from originFrame: CGRect) -> CGRect {
        let newOrigin = CGPoint(x: originFrame.origin.x + originFrame.width,
                                y: originFrame.origin.y)
        return CGRect(origin: newOrigin, size: originFrame.size)
    }
}
