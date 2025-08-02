//
//  GenerateNodex.swift
//  OphiuchusTests
//
//  Created by Nick on 7/6/25.
//

import Foundation
@testable import Ophiuchus

struct GenerateNodes {
    
    static let id_queue = DispatchQueue(label: "id_queue_nodes")
    
    private static var node_id = 0
    
    static func generate_node(id: Int, chunk: (any SkeletonChunkConforming)) -> WiseLayoutNode {
        GenerateNodes.generate_node(id: id, chunks: [chunk])
    }
    
    static func generate_node(chunk: (any SkeletonChunkConforming)) -> WiseLayoutNode {
        GenerateNodes.generate_node(chunks: [chunk])
    }
    
    static func generate_node(chunks: [any SkeletonChunkConforming]) -> WiseLayoutNode {
        
        let id = id_queue.sync {
            let id = GenerateNodes.node_id
            GenerateNodes.node_id += 1
            if GenerateNodes.node_id > 1_000_000_000 { GenerateNodes.node_id = 0 }
            return id
        }
        
        return GenerateNodes.generate_node(id: id,
                                           chunks: chunks)
    }
    
    static func generate_node(id: Int, chunks: [any SkeletonChunkConforming]) -> WiseLayoutNode {

        //let skeleton_node = generate_skeleton_node(chunks: chunks)
        
        let skeleton_node = SkeletonNode(id: id,
                                  chunks: chunks,
                                  alignment: .left)
        
        let result = WiseLayoutNode(recipe_id: id,
                                    toolInterfaceElement: .invalid,
                                    toolInterfaceElementType: .invalid,
                                    interfaceProvider: InterfaceProvider.invalid,
                                    configuration: 8,
                                    is_stacked: false,
                                    layoutScheme: EmptyLayoutScheme.self,
                                    layoutSchemeFlavor: .long,
                                    skeletonNodes: [skeleton_node])
        return result
    }
    
}
