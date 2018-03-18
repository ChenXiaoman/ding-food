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
    
    /// Get a string between specified prefix and suffix
    /// exclusive of prefix and suffix
    /// by chopping the redundant characters on the two sides.
    /// If the substring doesn't exist, return an empty string
    /// If there are more than one such string, only returns the first encountered
    /// the first encountered string
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

