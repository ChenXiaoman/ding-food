//
//  ViewController.swift
//  ding
//
//  Created by Yunpeng Niu on 16/03/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ref = Database.database().reference()
        ref.child("weather").observeSingleEvent(of: .value, with: { snapshot in
            print(snapshot.value ?? 0)
        })
    }
}
