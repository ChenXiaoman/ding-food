//
//  Food+PhotoPath.swift
//  ding-stall
//
//  Created by Yunpeng Niu on 16/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import DingBase

extension Food {
    /// Provide a new path for the stall photo if it has changed
    static var newPhotoPath: String {
        return Food.path + "/\(Account.stallId)" + "/\(Food.getAutoId)"
    }
}
