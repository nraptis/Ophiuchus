//
//  ToolInterfaceElementSliderWidthCategory.swift
//  Ophiuchus
//
//  Created by Nick on 8/28/25.
//

import Foundation

@frozen public enum ToolInterfaceElementSliderWidthCategory: UInt8 {
    case fullWidth
    case stretch
    case halfWidthLeft // There may be a 1 pixel difference
    case halfWidthRight // There may be a 1 pixel difference
}
