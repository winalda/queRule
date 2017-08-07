//
//  Utils.swift
//  queRule
//
//  Created by Erick Alberto Morales Ledesma on 06/08/17.
//  Copyright © 2017 Erick. All rights reserved.
//

import Foundation
import UIKit

func formatColours(string: String, color: UIColor) -> NSMutableAttributedString
{
    let length = string.characters.count
    let colonPosition = string.indexOf(target: ":")!
    
    let myMutableString = NSMutableAttributedString(string: string, attributes: nil)
    
    myMutableString.addAttribute(
                        NSForegroundColorAttributeName,
                        value: color,
                        range: NSRange(
                            location: 0,
                            length: length))
    
    myMutableString.addAttribute(
        NSForegroundColorAttributeName,
        value: color,
        range: NSRange(
            location: 0,
            length: colonPosition + 1))
    
    return myMutableString
}
