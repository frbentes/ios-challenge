//
//  StringUtils.swift
//  Challenge
//
//  Created by Fredyson Costa Marques Bentes on 22/07/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

public class StringUtils {
    
    ///
    /// Formats a Swift string to strike through its entire text
    ///
    /// - Parameter text: String
    ///
    /// - Returns: NSAttributedString
    ///
    public static func strikeText(text: String) -> NSAttributedString {
        let attrString: NSMutableAttributedString = NSMutableAttributedString(string:text)
        attrString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, text.characters.count))
        
        return attrString
    }
    
    ///
    /// Formats a Swift string to strike through part of its text
    ///
    /// - Parameter text: String
    /// - Parameter length: Int
    ///
    /// - Returns: NSAttributedString
    ///
    public static func strikeSubText(text: String, length: Int) -> NSAttributedString {
        let attrString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attrString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, length))
        
        return attrString
    }

}