//
//  WiseLayoutFormat.swift
//  InterfaceKit
//
//  Created by Nicholas Raptis on 6/21/25.
//

import Foundation

@frozen public enum LayoutStackingFormat: UInt8, CaseIterable {
    case invalid
    case stacked
    case long
    
    public static let allCases: [LayoutStackingFormat] = [.invalid, .stacked, .long]
    public static let allLongFormats: [LayoutStackingFormat] = [.long, .invalid]
    public static let allStackedFormats: [LayoutStackingFormat] = [.long, .invalid]
    
    public var isStacked: Bool {
        switch self {
        case .long:
            return false
        default:
            return true
        }
    }
    
    public var isLong: Bool {
        switch self {
        case .long:
            return true
        default:
            return false
        }
    }
}
