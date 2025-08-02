//
//  BrainyLinkageRuleCondition.swift
//  InterfaceKit
//
//  Created by Nicholas Raptis on 6/22/25.
//

import Foundation

public struct LinkageRuleCondition {
    public let stackingFormats: Set<LayoutStackingFormat>
    public let stackingCategory: LayoutStackingCategory?
    public let fontScales: Set<LayoutUniversalFontScale>
    public init(stackingCategory: LayoutStackingCategory?,
                stackingFormats: [LayoutStackingFormat],
                fontScales: [LayoutUniversalFontScale]) {
        self.stackingCategory = stackingCategory
        self.stackingFormats = Set(stackingFormats)
        self.fontScales = Set(fontScales)
    }
    
}

