//
//  AnyAnyTextIconPackable.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/23/25.
//

import Foundation

public class AnyTextIconPackable: TextIconPackable {
    
    private let wrapped: any TextIconPackable
    public init(_ wrapped: some TextIconPackable) {
        self.wrapped = wrapped
    }
    
    public func getTextIcon(orientation: Orientation,
                            layoutSchemeFlavor: LayoutSchemeFlavor,
                            numberOfLines: Int,
                            isDarkModeEnabled: Bool,
                            isEnabled: Bool) -> any TextIconable {
        wrapped.getTextIcon(orientation: orientation,
                            layoutSchemeFlavor: layoutSchemeFlavor,
                            numberOfLines: numberOfLines,
                            isDarkModeEnabled: isDarkModeEnabled,
                            isEnabled: isEnabled
        )
    }
}
