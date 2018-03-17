//
//  String+Contain.swift
//  ding
//
//  Created by Chen Xiaoman on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

extension String {
    /// Check if a string contains substring
    func contains(subString: String) -> Bool{
        return self.range(of: subString) != nil
    }
    
    /// Get a string with specified prefix and suffix
    /// by chopping the redundant characters on the two sides.
    func getTextBetween(prefix: String, suffix: String) -> String {
        let stringChopLeft = self.components(separatedBy: prefix)
        if stringChopLeft.count <= 1 {
            // No substring has this prefix
            return ""
        }
        
        let stringChopRight = stringChopLeft[1].components(separatedBy: suffix)
        if let string = stringChopRight.first {
            return string
        }
        // No subtring has this suffix
        return ""
        
    }
}

