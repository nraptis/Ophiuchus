//
//  WrappedNode.swift
//  Ophiuchus
//
//  Created by Nick on 8/14/25.
//

import Foundation

class WrappedNode {
    let node: WiseLayoutNode
    var expectedSize = 0
    
    var section: WrappedSection!
    var row: WrappedRow!
    
    
    init(node: WiseLayoutNode) {
        self.node = node
        self.expectedSize = node.currentSize
    }
    
    func inject(node_map: inout [Int: WrappedNode]) {
        node_map[node.id] = self
    }
    
}
