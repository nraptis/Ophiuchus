//
//  InterfaceLayoutStrategy.swift
//  InterfaceKit
//
//  Created by Nicholas Raptis on 6/27/25.
//

import Foundation

public class InterfaceLayoutStrategy {
    
    public var strength = 0
    public var fontScale = LayoutUniversalFontScale.large
    public var stackingFormatMainTabs = LayoutStackingFormat.invalid
    public var stackingFormatCreateSwatches = LayoutStackingFormat.invalid
    public var stackingFormatModeChangers = LayoutStackingFormat.invalid
    public var stackingFormatCheckBoxes = LayoutStackingFormat.invalid
    public var stackingFormatButtons = LayoutStackingFormat.invalid
    public var stackingFormatSegments = LayoutStackingFormat.invalid
    public var stackingFormatSteppers = LayoutStackingFormat.invalid
    public var stackingFormatGreenButtons = LayoutStackingFormat.invalid
    
    
    public init() {
        
    }
    
    public func isConditionActive(linkageRule: LinkageRuleCondition?) -> Bool {
        
        guard let linkageRule = linkageRule else {
            return true
        }
        
        if let stackingCategory = linkageRule.stackingCategory {
            let stackingFormat = getStackingFormat(stackingCategory: stackingCategory)
            if !linkageRule.stackingFormats.contains(stackingFormat) {
                return false
            }
        }
        
        if !linkageRule.fontScales.contains(fontScale) {
            return false
        }

        return true
    }
    
    public func getStackingFormat(stackingCategory: LayoutStackingCategory) -> LayoutStackingFormat {
        switch stackingCategory {
        case .none:
            return LayoutStackingFormat.invalid
        case .mainTabs:
            return stackingFormatMainTabs
        case .createSwatches:
            return stackingFormatCreateSwatches
        case .modeChangers:
            return stackingFormatModeChangers
        case .buttons:
            return stackingFormatButtons
        case .segments:
            return stackingFormatSegments
        case .steppers:
            return stackingFormatSteppers
        case .checkBoxes:
            return stackingFormatCheckBoxes
        }
    }
    
    public func getLayoutSchemeFlavor(toolInterfaceElementType: ToolInterfaceElementType) -> LayoutSchemeFlavor {
        LayoutSchemeFlavor.stackedLarge
    }
    
    public func getStacked(stackingCategory: LayoutStackingCategory) -> Bool {
        switch stackingCategory {
        case .none:
            return false
        case .mainTabs:
            switch stackingFormatMainTabs {
            case .invalid:
                return false
            case .long:
                return false
            case .stacked:
                return true
            }
        case .createSwatches:
            switch stackingFormatCreateSwatches {
            case .invalid:
                return false
            case .long:
                return false
            case .stacked:
                return true
            }
        case .buttons:
            switch stackingFormatButtons {
            case .invalid:
                return false
            case .long:
                return false
            case .stacked:
                return true
            }
        case .modeChangers:
            switch stackingFormatModeChangers {
            case .invalid:
                return false
            case .long:
                return false
            case .stacked:
                return true
            }
        case .segments:
            switch stackingFormatSegments {
            case .invalid:
                return false
            case .long:
                return false
            case .stacked:
                return true
            }
        case .steppers:
            switch stackingFormatSteppers {
            case .invalid:
                return false
            case .long:
                return false
            case .stacked:
                return true
            }
        case .checkBoxes:
            switch stackingFormatCheckBoxes {
            case .invalid:
                return false
            case .long:
                return false
            case .stacked:
                return true
            }
        }
    }
    
    public func getStacked(elementType: ToolInterfaceElementType) -> Bool {
        return true
    }
    
    public func getNameLabelWidth(nameLabelWidthStackedLarge: Int,
        nameLabelWidthStackedMedium: Int,
                                  nameLabelWidthStackedSmall: Int) -> Int {
        switch fontScale {
        case .large:
            return nameLabelWidthStackedLarge
        case .medium:
            return nameLabelWidthStackedMedium
        case .small:
            return nameLabelWidthStackedSmall
        }
    }
    
}
