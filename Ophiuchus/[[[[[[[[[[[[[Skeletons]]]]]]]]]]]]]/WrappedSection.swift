//
//  WrappedSection.swift
//  Ophiuchus
//
//  Created by Nick on 8/14/25.
//

import Foundation

class WrappedSection {
    
    let nodes: [WrappedNode]
    let section: SkeletonSection
    var expectedSize = 0
    var row: WrappedRow!
    
    var temp = 0
    
    init(nodes: [WrappedNode], section: SkeletonSection) {
        self.nodes = nodes
        self.section = section
        self.expectedSize = section.currentSize
    }
    
    convenience init(section: SkeletonSection) {
        var _nodes = [WrappedNode]()
        for node in section.nodes {
            let _node = WrappedNode(node: node)
            _nodes.append(_node)
        }
        self.init(nodes: _nodes, section: section)
        
        for _node in _nodes {
            _node.section = self
        }
        
    }
    
    func inject(section_map: inout [Int: WrappedSection],
                node_map: inout [Int: WrappedNode]) {
        section_map[section.id] = self
        for node in nodes {
            node.inject(node_map: &node_map)
        }
    }
    
}
