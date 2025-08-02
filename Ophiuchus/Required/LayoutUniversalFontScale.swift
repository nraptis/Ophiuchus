//
//  LayoutUniversalFontScale.swift
//  InterfaceKit
//
//  Created by Nicholas Raptis on 6/22/25.
//

import Foundation

@frozen public enum LayoutUniversalFontScale: UInt8, CaseIterable {
    case large = 128
    case medium = 64
    case small = 32
    
    public static let allCases: [LayoutUniversalFontScale] = [.large, .medium, .small]
    
}
