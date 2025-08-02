//
//  TextIconPackable.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/17/25.
//

import Foundation

public protocol TextIconPackable {
    func getTextIcon(orientation: Orientation,
                     layoutSchemeFlavor: LayoutSchemeFlavor,
                     numberOfLines: Int,
                     isDarkModeEnabled: Bool,
                     isEnabled: Bool) -> (any TextIconable)    
}
