//
//  EmptyLayoutScheme.swift
//  InterfaceKit
//
//  Created by Nicholas Raptis on 6/27/25.
//

import UIKit

struct EmptyLayoutScheme: LayoutScheme {
    static func getCornerRadius(orientation: Orientation) -> Int {
        0
    }
    
    static func getLineThickness(orientation: Orientation) -> Int {
        0
    }
    
    static func getValueLabelFont(orientation: Orientation,
                                  flavor: LayoutSchemeFlavor) -> UIFont {
        UIFont.systemFont(ofSize: 12.0)
    }
    
    static func getValuePaddingLeft(orientation: Orientation,
                                    squeeze: LayoutSchemeSqueeze,
                                    isSlavePresent: Bool,
                                    isAccentPresent: Bool) -> Int {
        0
    }
    
    static func getValuePaddingRight(orientation: Orientation,
                                     squeeze: LayoutSchemeSqueeze,
                                     isSlavePresent: Bool,
                                     isAccentPresent: Bool) -> Int {
        0
    }
    
    static func getNameLabelFont(orientation: Orientation,
                                 flavor: LayoutSchemeFlavor) -> UIFont {
        UIFont.systemFont(ofSize: 12.0)
    }
    
    static func getNameLabelVerticalSpacing(orientation: Orientation,
                                            flavor: LayoutSchemeFlavor) -> Int {
        0
    }
    
    static func getOutsideBoxPaddingTop(orientation: Orientation) -> Int {
        0
    }
    
    static func getOutsideBoxPaddingBottom(orientation: Orientation) -> Int {
        0
    }
    
    static func getOutsideBoxPaddingLeft(orientation: Orientation,
                                         squeeze: LayoutSchemeSqueeze,
                                         neighborTypeLeft: ToolInterfaceElementType?,
                                         neighborTypeRight: ToolInterfaceElementType?) -> Int {
        0
    }
    
    static func getOutsideBoxPaddingRight(orientation: Orientation,
                                          squeeze: LayoutSchemeSqueeze,
                                          neighborTypeLeft: ToolInterfaceElementType?,
                                          neighborTypeRight: ToolInterfaceElementType?) -> Int {
        0
    }
    
    static func getHeroPaddingLeftStacked(orientation: Orientation,
                                          squeeze: LayoutSchemeSqueeze,
                                          isSlavePresent: Bool,
                                          isAccentPresent: Bool) -> Int {
        0
    }
    
    static func getHeroPaddingLeftLong(orientation: Orientation,
                                       squeeze: LayoutSchemeSqueeze,
                                       isSlavePresent: Bool,
                                       isAccentPresent: Bool) -> Int {
        0
    }
    
    static func getHeroPaddingRightStacked(orientation: Orientation,
                                           squeeze: LayoutSchemeSqueeze,
                                           isSlavePresent: Bool,
                                           isAccentPresent: Bool) -> Int { 0 }
    
    static func getHeroPaddingRightLong(orientation: Orientation,
                                        squeeze: LayoutSchemeSqueeze,
                                        isSlavePresent: Bool,
                                        isAccentPresent: Bool) -> Int {
        0
    }
    
    static func getHeroPaddingTopStacked(orientation: Orientation,
                                         numberOfLines: Int) -> Int {
        0
    }
    
    static func getHeroPaddingBottomStacked(orientation: Orientation,
                                            numberOfLines: Int) -> Int {
        0
    }
    
    static func getSlavePaddingLeftStacked(orientation: Orientation,
                                           squeeze: LayoutSchemeSqueeze,
                                           isAccentPresent: Bool) -> Int {
        0
    }
    
    static func getSlavePaddingLeftLong(orientation: Orientation,
                                        squeeze: LayoutSchemeSqueeze,
                                        isAccentPresent: Bool) -> Int {
        0
    }
    
    static func getSlavePaddingRightStacked(orientation: Orientation,
                                            squeeze: LayoutSchemeSqueeze,
                                            isAccentPresent: Bool) -> Int {
        0
    }
    
    static func getSlavePaddingRightLong(orientation: Orientation,
                                         squeeze: LayoutSchemeSqueeze,
                                         isAccentPresent: Bool) -> Int {
        0
    }
    
    static func getAccentPaddingLeftStacked(orientation: Orientation,
                                            squeeze: LayoutSchemeSqueeze,
                                            isSlavePresent: Bool) -> Int {
        0
    }
    
    static func getAccentPaddingLeftLong(orientation: Orientation,
                                         squeeze: LayoutSchemeSqueeze,
                                         isSlavePresent: Bool) -> Int {
        0
    }
    
    static func getAccentPaddingRightStacked(orientation: Orientation,
                                             squeeze: LayoutSchemeSqueeze,
                                             isSlavePresent: Bool) -> Int {
        0
    }
    
    static func getAccentPaddingRightLong(orientation: Orientation,
                                          squeeze: LayoutSchemeSqueeze,
                                          isSlavePresent: Bool) -> Int {
        0
    }
    
    static func getHeroSpacingLong(orientation: Orientation,
                                   squeeze: LayoutSchemeSqueeze) -> Int {
        0
    }
    
}
