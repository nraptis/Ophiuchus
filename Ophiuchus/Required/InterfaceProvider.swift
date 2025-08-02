//
//  InterfaceProvider.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

@frozen public enum InterfaceProvider: Equatable {
    
    case invalid
    
    case spacer(Int, Int)

    func getToolInterfaceElementType() -> ToolInterfaceElementType {
        return ToolInterfaceElementType.invalid
    }
    
    func getToolInterfaceElement() -> ToolInterfaceElement {
        return ToolInterfaceElement.invalid
    }
    
}
