//
//  WiseLayoutNode.swift
//  InterfaceKit
//
//  Created by Nicholas Raptis on 6/21/25.
//

import Foundation

public class WiseLayoutNode {
    
    public let id: Int
    public let recipe_id: Int
    public let toolInterfaceElement: ToolInterfaceElement
    public let toolInterfaceElementType: ToolInterfaceElementType
    public let interfaceProvider: InterfaceProvider
    public let configuration: Any
    public let is_stacked: Bool
    public let layoutScheme: LayoutScheme.Type
    public let layoutSchemeFlavor: LayoutSchemeFlavor
    public let skeletonNodes: [SkeletonNode]
    var x = 0
    var width = 0
    
    public init(recipe_id: Int,
                toolInterfaceElement: ToolInterfaceElement,
                toolInterfaceElementType: ToolInterfaceElementType,
                interfaceProvider: InterfaceProvider,
                configuration: Any,
                is_stacked: Bool,
                layoutScheme: LayoutScheme.Type,
                layoutSchemeFlavor: LayoutSchemeFlavor,
                skeletonNodes: [SkeletonNode]) {
        
        self.id = SkeletonIdentifierFactory.get_id()
        self.recipe_id = recipe_id
        self.toolInterfaceElement = toolInterfaceElement
        self.toolInterfaceElementType = toolInterfaceElementType
        self.interfaceProvider = interfaceProvider
        self.configuration = configuration
        self.is_stacked = is_stacked
        self.layoutScheme = layoutScheme
        self.layoutSchemeFlavor = layoutSchemeFlavor
        self.skeletonNodes = skeletonNodes
        
        var _x = 0
        var _width = 0
        if skeletonNodes.count > 0 {
            _x = skeletonNodes[0].x
        }
        for skeletonNode in skeletonNodes {
            _width += skeletonNode.width
        }
        self.x = _x
        self.width = _width
    }
    
}
