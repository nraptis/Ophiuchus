//
//  GenerateSection.swift
//  OphiuchusTests
//
//  Created by Nick on 7/6/25.
//

import Foundation
@testable import Ophiuchus

struct GenerateSections {
    
    static func filterRandomly(list: [SkeletonSection]) -> [SkeletonSection] {
        var result = [SkeletonSection]()
        for item in list {
            if Bool.random() {
                result.append(item)
            }
        }
        return result
    }
    
    static func generate_n(_ n: Int) -> [SkeletonSection] {
        var result = [SkeletonSection]()
        var index = 0
        while index < n {
            let section = generate(nodes: [])
            result.append(section)
            index += 1
        }
        return result
    }
    
    static func generate(node: WiseLayoutNode) -> SkeletonSection {
        let result = SkeletonSection.generate(nodes: [node])
        return result
    }
    
    static func generate(nodes: [WiseLayoutNode]) -> SkeletonSection {
        let result = SkeletonSection.generate(nodes: nodes)
        return result
    }
    
    
    //GenerateSections.generate_section(skeleton_node: node_a)
    
    
    static func generate_fixed(size: Int) -> SkeletonSection {
        let layoutNode = GenerateNodes.generate(size: size)
        let result = generate(nodes: [layoutNode])
        return result
    }
    
    static func generate_alreadyPlaced(x: Int, width: Int) -> SkeletonSection {
        
        let node = GenerateNodes.generate(size: width)
        let result = SkeletonSection.generate(node: node)
        result.x = x
        result.width = width
        return result
        
        
    }
    
    static func generate(currentSize: Int, nodes: [WiseLayoutNode]) -> SkeletonSection {
        let result = generate(nodes: nodes)
        result.currentSize = currentSize
        return result
    }
    
    static func generate_currentSizeAccumulate(nodes: [WiseLayoutNode]) -> SkeletonSection {
        let result = generate(nodes: nodes)
        var currentSize = 0
        for node in nodes {
            currentSize += node.currentSize
        }
        result.currentSize = currentSize
        return result
    }
    
}
