//
//  LayoutSchemeFlavor.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/17/25.
//

import Foundation

@frozen public enum LayoutSchemeFlavor: UInt8, Comparable {
    case long = 4
    case stackedLarge = 3
    case stackedMedium = 2
    case stackedSmall = 1
    
    public static func < (lhs: LayoutSchemeFlavor, rhs: LayoutSchemeFlavor) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    public var isStacked: Bool {
        switch self {
        case .long:
            false
        case .stackedLarge:
            true
        case .stackedMedium:
            true
        case .stackedSmall:
            true
        }
    }
    
    public var isLong: Bool {
        switch self {
        case .long:
            true
        case .stackedLarge:
            false
        case .stackedMedium:
            false
        case .stackedSmall:
            false
        }
    }
}
