//
//  String+Contain.swift
//  ding
//
//  Created by Chen Xiaoman on 17/3/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

extension String {
    /// Check if a string contains substring
    func contains(subString: String) -> Bool {
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

    /// Returns a string which could be used to perform Firebase query such that those
    /// values starting with this string will be returned.
    ///
    /// Reason: The f8ff character used in the query above is a very high code point
    /// in the Unicode range. Because it is after most regular characters in Unicode,
    /// the query matches all values starting with this string.
    ///
    /// _(Adapted from an older version of Firebase documentation)_
    var queryStartedWith: String {
        return self + "\u{f8ff}"
    }
}
