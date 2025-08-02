//
//  UIFont+StringWidth.swift
//  It's You
//
//  Created by Nicholas Raptis on 5/20/25.
//

import UIKit

public extension UIFont {
    
    func stringWidth(_ text: String) -> CGFloat {
        let fontAttribute = [NSAttributedString.Key.font: self]
        let size = text.size(withAttributes: fontAttribute)
        let widthi = Int(size.width)
        let fraction = size.width - CGFloat(widthi)
        if fraction >= 0.5 {
            // PROVEN! Do *NOT* change this, otherwise
            // it may spill to another line.
            return CGFloat(Int(size.width + 1.5))
        } else {
            // PROVEN! Do *NOT* change this, otherwise
            // it may spill to another line.
            return CGFloat(Int(size.width + 2.0))
        }
    }
}
