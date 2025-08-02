//
//  LayoutScheme.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/17/25.
//

import UIKit


public protocol LayoutScheme {
    
    static func getCornerRadius(orientation: Orientation) -> Int
    static func getLineThickness(orientation: Orientation) -> Int
    
    
    static func getValueLabelFont(orientation: Orientation,
                                             flavor: LayoutSchemeFlavor) -> UIFont
    static func getValuePaddingLeft(orientation: Orientation,
                                               squeeze: LayoutSchemeSqueeze,
                                               isSlavePresent: Bool,
                                               isAccentPresent: Bool) -> Int
    static func getValuePaddingRight(orientation: Orientation,
                                                squeeze: LayoutSchemeSqueeze,
                                                isSlavePresent: Bool,
                                                isAccentPresent: Bool) -> Int
    static func getNameLabelFont(orientation: Orientation,
                                            flavor: LayoutSchemeFlavor) -> UIFont
    static func getNameLabelVerticalSpacing(orientation: Orientation,
                                                       flavor: LayoutSchemeFlavor) -> Int
    static func getOutsideBoxPaddingTop(orientation: Orientation) -> Int
    static func getOutsideBoxPaddingBottom(orientation: Orientation) -> Int
    static func getOutsideBoxPaddingLeft(orientation: Orientation,
                                                    squeeze: LayoutSchemeSqueeze,
                                                    neighborTypeLeft: ToolInterfaceElementType?,
                                                    neighborTypeRight: ToolInterfaceElementType?) -> Int
    static func getOutsideBoxPaddingRight(orientation: Orientation,
                                                     squeeze: LayoutSchemeSqueeze,
                                                     neighborTypeLeft: ToolInterfaceElementType?,
                                                     neighborTypeRight: ToolInterfaceElementType?) -> Int
    static func getHeroPaddingLeftStacked(orientation: Orientation,
                                                     squeeze: LayoutSchemeSqueeze,
                                                     isSlavePresent: Bool,
                                                     isAccentPresent: Bool) -> Int
    static func getHeroPaddingLeftLong(orientation: Orientation,
                                                  squeeze: LayoutSchemeSqueeze,
                                                  isSlavePresent: Bool,
                                                  isAccentPresent: Bool) -> Int
    static func getHeroPaddingRightStacked(orientation: Orientation,
                                                      squeeze: LayoutSchemeSqueeze,
                                                      isSlavePresent: Bool,
                                                      isAccentPresent: Bool) -> Int
    static func getHeroPaddingRightLong(orientation: Orientation,
                                                   squeeze: LayoutSchemeSqueeze,
                                                   isSlavePresent: Bool,
                                                   isAccentPresent: Bool) -> Int
    
    static func getHeroPaddingTopStacked(orientation: Orientation,
                                                    numberOfLines: Int) -> Int
    static func getHeroPaddingBottomStacked(orientation: Orientation,
                                                       numberOfLines: Int) -> Int
    
    static func getSlavePaddingLeftStacked(orientation: Orientation,
                                                      squeeze: LayoutSchemeSqueeze,
                                                      isAccentPresent: Bool) -> Int
    static func getSlavePaddingLeftLong(orientation: Orientation,
                                                   squeeze: LayoutSchemeSqueeze,
                                                   isAccentPresent: Bool) -> Int
    
    static func getSlavePaddingRightStacked(orientation: Orientation,
                                                       squeeze: LayoutSchemeSqueeze,
                                                       isAccentPresent: Bool) -> Int
    static func getSlavePaddingRightLong(orientation: Orientation,
                                                    squeeze: LayoutSchemeSqueeze,
                                                    isAccentPresent: Bool) -> Int
    
    static func getAccentPaddingLeftStacked(orientation: Orientation,
                                                       squeeze: LayoutSchemeSqueeze,
                                                       isSlavePresent: Bool) -> Int
    static func getAccentPaddingLeftLong(orientation: Orientation,
                                                    squeeze: LayoutSchemeSqueeze,
                                                    isSlavePresent: Bool) -> Int
    
    
    static func getAccentPaddingRightStacked(orientation: Orientation,
                                                        squeeze: LayoutSchemeSqueeze,
                                                        isSlavePresent: Bool) -> Int
    static func getAccentPaddingRightLong(orientation: Orientation,
                                                     squeeze: LayoutSchemeSqueeze,
                                                     isSlavePresent: Bool) -> Int
    
    static func getHeroSpacingLong(orientation: Orientation,
                                              squeeze: LayoutSchemeSqueeze) -> Int
}

extension LayoutScheme {
    
    public static func getNameLabelTextWidth(line1: String?,
                                      line2: String?,
                                      orientation: Orientation,
                                      flavor: LayoutSchemeFlavor) -> Int {
        let font = Self.getNameLabelFont(orientation: orientation, flavor: flavor)
        return TextDimension.getTextWidth(line1: line1, line2: line2, font: font)
    }
    
    public static func getNameLabelTextWidth(line1: String?,
                                      orientation: Orientation,
                                      flavor: LayoutSchemeFlavor) -> Int {
        let font = Self.getNameLabelFont(orientation: orientation, flavor: flavor)
        return TextDimension.getTextWidth(line1: line1, font: font)
    }
    
    public static func getValueLabelTextWidth(line1: String?,
                                       line2: String?,
                                       orientation: Orientation,
                                       flavor: LayoutSchemeFlavor) -> Int {
        let font = Self.getValueLabelFont(orientation: orientation, flavor: flavor)
        return TextDimension.getTextWidth(line1: line1, line2: line2, font: font)
    }
    
    public static func getValueLabelTextWidth(line1: String?,
                                       orientation: Orientation,
                                       flavor: LayoutSchemeFlavor) -> Int {
        let font = Self.getValueLabelFont(orientation: orientation, flavor: flavor)
        return TextDimension.getTextWidth(line1: line1, font: font)
    }
    
}
