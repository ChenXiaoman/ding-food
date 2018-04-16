//
//  UIViewController+internetConnection.swift
//  ding
//
//  Created by Chen Xiaoman on 16/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit

extension UIViewController {
    /// A blank UIView indicating the device is offline
    static private var offlineView: UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.screenHeight))
        view.backgroundColor = UIColor.white
        let image = UIImageView(image: #imageLiteral(resourceName: "offlineImage"))
        image.frame = CGRect(x: 0, y: 0, width: Constants.offlineImageSize, height: Constants.offlineImageSize)
        // Make image in the screen center
        image.center = CGPoint(x: Constants.screenWidth / 2, y: Constants.screenHeight / 2)
        view.addSubview(image)
        return view
    }
    
    /// Checks whether the device is connected to the internet.
    /// If not connected, the page is changed to blank.
    func checkInternetConnection() {
        let connectedRef = DatabaseRef.connectedRef
        let offlineView = UIViewController.offlineView
        
        // Checks internet connection only after certain timeout interval.
        checkLoadingTimeout(indicator: nil, interval: Constants.timeoutInterval) {
            
            // Observes whether the internet is connected using FireBase.
            connectedRef.observe(.value, with: { snapshot in
                guard let connected = snapshot.value as? Bool, connected else {
                    // The internet is not connected.
                    self.view.addSubview(offlineView)
                    self.alertTimeout()
                    return
                }
                // The internet is connected.
                offlineView.removeFromSuperview()
            })
        }
    }
    
    /// Stops checking whether the internet is connected
    /// by stopping observer.
    func stopCheckingInternetConnection() {
        DatabaseRef.stopObservers(of: DatabaseRef.checkConnectionPath)
    }
}
