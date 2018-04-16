//
//  UIViewController+internetConnection.swift
//  ding
//
//  Created by Chen Xiaoman on 16/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

extension UIViewController {
    static private var offlineView: UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.screenHeight))
        view.backgroundColor = UIColor.blue
        return view
    }
    
    func checkInternetConnection() {
        let connectedRef = DatabaseRef.connectedRef
        let offlineView = UIViewController.offlineView
        connectedRef.observe(.value, with: { snapshot in
            guard let connected = snapshot.value as? Bool, connected else {
                self.view.addSubview(offlineView)
                return
            }
            offlineView.removeFromSuperview()
        })
    }
}
