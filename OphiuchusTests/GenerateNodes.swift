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
    
    static func generate_n_nodes(n: Int) -> [WiseLayoutNode] {
        var result = [WiseLayoutNode]()
        var index = 0
        while index < n {
            let node = generate_fixed_layout(size: 10)
            result.append(node)
            index += 1
        }
        return result
    }
    
    static func generate_n_skeleton_nodes(n: Int) -> [SkeletonNode] {
        var result = [SkeletonNode]()
        var index = 0
        while index < n {
            let node = generate_fixed(size: 10)
            result.append(node)
            index += 1
        }
        return result
    }
    
    static func filterRandomly(skeleton_nodes: [SkeletonNode]) -> [SkeletonNode] {
        var result = [SkeletonNode]()
        for item in skeleton_nodes {
            if Bool.random() {
                result.append(item)
            }
        }
        return result
    }
    
    static func filterRandomly(layout_nodes: [WiseLayoutNode]) -> [WiseLayoutNode] {
        var result = [WiseLayoutNode]()
        for item in layout_nodes {
            if Bool.random() {
                result.append(item)
            }
        }
        return result
    }
    
    static func generate_node(id: Int, chunk: SkeletonChunk) -> WiseLayoutNode {
        GenerateNodes.generate_node(id: id, chunks: [chunk])
    }
    
    static func generate_skeleton_node(chunk: SkeletonChunk) -> SkeletonNode {
        let result = generate_skeleton_node(chunks: [chunk])
        return result
    }
    
    static func generate_fixed(size: Int) -> SkeletonNode {
        let chunk = GenerateChunks.generate_fixed(size: size)
        let id = id_queue.sync {
            let id = GenerateNodes.node_id
            GenerateNodes.node_id += 1
            if GenerateNodes.node_id > 1_000_000_000 { GenerateNodes.node_id = 0 }
            return id
        }
        let result = generate_skeleton_node(id: id,
                                      chunks: [chunk])
        return result
    }
    
    static func generate_fixed_layout(size: Int) -> WiseLayoutNode {
        let chunk = GenerateChunks.generate_fixed(size: size)
        let id = id_queue.sync {
            let id = GenerateNodes.node_id
            GenerateNodes.node_id += 1
            if GenerateNodes.node_id > 1_000_000_000 { GenerateNodes.node_id = 0 }
            return id
        }
        let skeleton_node = SkeletonNode(id: id,
                                  chunks: [chunk],
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
    
    static func generate_node(skeletonNode: SkeletonNode) -> WiseLayoutNode {
        let result = WiseLayoutNode(recipe_id: skeletonNode.id,
                                    toolInterfaceElement: .invalid,
                                    toolInterfaceElementType: .invalid,
                                    interfaceProvider: InterfaceProvider.invalid,
                                    configuration: 8,
                                    is_stacked: false,
                                    layoutScheme: EmptyLayoutScheme.self,
                                    layoutSchemeFlavor: .long,
                                    skeletonNodes: [skeletonNode])
        return result
    }
    
    static func generate_skeleton_node(chunks: [SkeletonChunk]) -> SkeletonNode {
        let id = id_queue.sync {
            let id = GenerateNodes.node_id
            GenerateNodes.node_id += 1
            if GenerateNodes.node_id > 1_000_000_000 { GenerateNodes.node_id = 0 }
            return id
        }
        let result = generate_skeleton_node(id: id,
                                      chunks: chunks)
        return result
    }
    
    static func generate_skeleton_node(id: Int, chunks: [SkeletonChunk]) -> SkeletonNode {
        let alignment = GenerateAlignment.generate_alignment()
        let result = SkeletonNode(id: id,
                                  chunks: chunks,
                                  alignment: alignment)
        return result
    }
    
    static func generate_node(chunk: SkeletonChunk) -> WiseLayoutNode {
        GenerateNodes.generate_node(chunks: [chunk])
    }
    
    static func generate_skeleton_node(gap: Int) -> SkeletonNode {
        let base = Int.random(in: 0...20)
        let result = GenerateNodes.generate_skeleton_node(base: base, gap: gap)
        return result
    }
    
    static func generate_skeleton_node(base: Int, gap: Int) -> SkeletonNode {
        let result = GenerateNodes.generate_fixed(size: base + gap)
        result.childrenSize = base
        result.currentSize = base + gap
        return result
    }
    
    
    static func generate_node(gap: Int) -> WiseLayoutNode {
        let skeletonNode = GenerateNodes.generate_skeleton_node(gap: gap)
        let result = GenerateNodes.generate_node(skeletonNode: skeletonNode)
        return result
    }
    
    static func generate_node(base: Int, gap: Int) -> WiseLayoutNode {
        let skeletonNode = GenerateNodes.generate_skeleton_node(base: base, gap: gap)
        let result = GenerateNodes.generate_node(skeletonNode: skeletonNode)
        return result
    }
    
    static func generate_node(chunks: [SkeletonChunk]) -> WiseLayoutNode {
        
        let id = id_queue.sync {
            let id = GenerateNodes.node_id
            GenerateNodes.node_id += 1
            if GenerateNodes.node_id > 1_000_000_000 { GenerateNodes.node_id = 0 }
            return id
        }
        
        return GenerateNodes.generate_node(id: id,
                                           chunks: chunks)
    }
    
    static func generate_skeleton_node(chunks: [SkeletonChunk], gap: Int) -> SkeletonNode {
        
        
        let base = Int.random(in: 0...20)
        return GenerateNodes.generate_skeleton_node(chunks: chunks,
                                           base: base,
                                           gap: gap)
    }
    
    static func generate_node(chunks: [SkeletonChunk], gap: Int) -> WiseLayoutNode {
        let skeletonNode = generate_skeleton_node(chunks: chunks,
                                                  gap: gap)
        let result = GenerateNodes.generate_node(skeletonNode: skeletonNode)
        return result
    }
    
    static func generate_skeleton_node(chunks: [SkeletonChunk], base: Int, gap: Int) -> SkeletonNode {
        
        let id = id_queue.sync {
            let id = GenerateNodes.node_id
            GenerateNodes.node_id += 1
            if GenerateNodes.node_id > 1_000_000_000 { GenerateNodes.node_id = 0 }
            return id
        }
        
        let result = GenerateNodes.generate_skeleton_node(id: id,
                                           chunks: chunks)
        result.currentSize = base + gap
        result.childrenSize = base
        return result
    }
    
    static func generate_node(chunks: [SkeletonChunk], base: Int, gap: Int) -> WiseLayoutNode {
        let skeletonNode = generate_skeleton_node(chunks: chunks,
                                                  base: base,
                                                  gap: gap)
        let result = GenerateNodes.generate_node(skeletonNode: skeletonNode)
        return result
    }
    
    static func generate_node(id: Int, chunks: [SkeletonChunk]) -> WiseLayoutNode {

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
