//
//  LayoutSchemeFlavor.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/17/25.
//

import Foundation

public struct LayoutSchemeFlavor {
    
    public let stackingFormat: LayoutStackingFormat
    public let fontScale: LayoutUniversalFontScale
    
    public var isStacked: Bool {
        stackingFormat.isStacked
    }
    
    public var isLong: Bool {
        stackingFormat.isLong
    }
}
