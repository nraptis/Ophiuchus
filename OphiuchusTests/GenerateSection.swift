//
//  GenerateSection.swift
//  OphiuchusTests
//
//  Created by Nick on 7/6/25.
//

import Foundation
@testable import Ophiuchus

struct GenerateSections {
    
    static let id_queue = DispatchQueue(label: "id_queue_sections")
    
    private static var section_id = 0
    
    
    static func generate_n_sections(n: Int) -> [SkeletonSection] {
        var result = [SkeletonSection]()
        var index = 0
        while index < n {
            let section = generate_fixed(size: 10)
            result.append(section)
            index += 1
        }
        return result
    }
    
    static func generate_section(gap: Int) -> SkeletonSection {
        let base = Int.random(in: 0...20)
        let result = GenerateSections.generate_section(base: base, gap: gap)
        return result
    }
    
    static func generate_section(base: Int, gap: Int) -> SkeletonSection {
        let result = GenerateSections.generate_fixed(size: base + gap)
        result.childrenSize = base
        result.currentSize = base + gap
        return result
    }
    
    
    
    static func generate_section(node: WiseLayoutNode) -> SkeletonSection {
        GenerateSections.generate_section(nodes: [node])
    }
    
    //GenerateSections.generate_section(skeleton_node: node_a)
    
    static func generate_fixed(size: Int) -> SkeletonSection {
        let layoutNode = GenerateNodes.generate_fixed_layout(size: size)
        let result = generate_section(nodes: [layoutNode])
        return result
    }
    
    static func generate_section(skeleton_node: SkeletonNode) -> SkeletonSection {
        let result = generate_section(skeleton_nodes: [skeleton_node])
        return result
    }
    
    static func generate_section(skeleton_nodes: [SkeletonNode]) -> SkeletonSection {
        var layoutNodes: [WiseLayoutNode] = []
        for skeleton_node in skeleton_nodes {
            let layoutNode = WiseLayoutNode(recipe_id: skeleton_node.id,
                                            toolInterfaceElement: .invalid,
                                            toolInterfaceElementType: .invalid,
                                            interfaceProvider: .invalid,
                                            configuration: 0,
                                            is_stacked: true,
                                            layoutScheme: EmptyLayoutScheme.self,
                                            layoutSchemeFlavor: .stackedLarge,
                                            skeletonNodes: [skeleton_node])
            layoutNodes.append(layoutNode)
        }
        let result = GenerateSections.generate_section(nodes: layoutNodes)
        return result
    }
    
    static func generate_section(skeleton_nodes: [SkeletonNode], gap: Int) -> SkeletonSection {
        let base = Int.random(in: 0...20)
        let result = GenerateSections.generate_section(skeleton_nodes: skeleton_nodes,
                                                       base: base,
                                                       gap: gap)
        return result
    }
    
    static func generate_section(skeleton_nodes: [SkeletonNode], base: Int, gap: Int) -> SkeletonSection {
        
        let result = GenerateSections.generate_section(skeleton_nodes: skeleton_nodes)
        result.currentSize = base + gap
        result.childrenSize = base
        return result
    }
    
    static func generate_section(nodes: [WiseLayoutNode]) -> SkeletonSection {
        let id = id_queue.sync {
            let id = GenerateSections.section_id
            GenerateSections.section_id += 1
            if GenerateSections.section_id > 1_000_000_000 { GenerateSections.section_id = 0 }
            return id
        }
        let result = SkeletonSection(id: id, layoutNodes: nodes, alignment: .left)
        result.adopt_test()
        return result
    }
    
    static func generate_section_already_placed(x: Int, width: Int) -> SkeletonSection {
        let chunk = GenerateChunks.generate_fixed(size: width)
        let node = GenerateNodes.generate_node(chunk: chunk)
        let result = generate_section(node: node)
        result.adopt_test()
        result.x = x
        result.width = width
        return result
        
        
    }
    
}
