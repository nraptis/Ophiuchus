//
//  WiseLayoutFormat.swift
//  InterfaceKit
//
//  Created by Nicholas Raptis on 6/21/25.
//

import Foundation

@frozen public enum LayoutStackingFormat: UInt8 {
    case invalid
    case long
    case stacked
    var isStacked: Bool {
        switch self {
        case .invalid:
            return false
        case .long:
            return false
        case .stacked:
            return true
        }
    }
}
