//
//  TextDimension.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/17/25.
//

import UIKit

public struct TextDimension {
    
    
    
    public static func getLineHeight(font: UIFont) -> Int {
        let lineHeight = Int(font.lineHeight + 1.5)
        return lineHeight
    }
    
    public static func getNumberOfLines(line1: String?,
                                        line2: String?) -> Int {
        
        var numberOfLines = 0
        if line1 != nil { numberOfLines += 1 }
        if line2 != nil { numberOfLines += 1 }
        return numberOfLines
    }
    
    private static let textMinimumWidth = 12
    public static func getTextWidth(line1: String?,
                                    line2: String?,
                                    font: UIFont) -> Int {
        var width1 = CGFloat(0.0)
        if let line1 = line1 {
            width1 = font.stringWidth(line1)
        }
        var width2 = CGFloat(0.0)
        if let line2 = line2 {
            width2 = font.stringWidth(line2)
        }
        var result = Int(max(width1, width2) + 0.5)
        if result < Self.textMinimumWidth {
            result = Self.textMinimumWidth
        }
        return result
    }
    
    public static func getTextWidth(line1: String?,
                                    font: UIFont) -> Int {
        var width = CGFloat(0.0)
        if let line1 = line1 {
            width = font.stringWidth(line1)
        }
        var result = Int(width + 0.5)
        if result < Self.textMinimumWidth {
            result = Self.textMinimumWidth
        }
        return result
    }
    
}
