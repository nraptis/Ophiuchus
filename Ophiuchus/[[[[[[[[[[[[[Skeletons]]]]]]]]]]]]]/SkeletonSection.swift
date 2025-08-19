//
//  SkeletonSection.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

public class SkeletonSection {
    
    static func generate(id: Int, nodes: [WiseLayoutNode]) -> SkeletonSection {
        let result = SkeletonSection(id: id,
                                     nodes: nodes)
        result.currentSize = 0
        for node in nodes {
            result.currentSize += node.currentSize
        }
        return result
    }
    
    static func generate(nodes: [WiseLayoutNode]) -> SkeletonSection {
        let id = SkeletonIdentifierFactory.get_id()
        let result = generate(id: id,
                              nodes: nodes)
        return result
    }
    
    static func generate(node: WiseLayoutNode) -> SkeletonSection {
        let result = generate(nodes: [node])
        return result
    }
    
    //var didGrowOnCurrentPass = false
    var requestedGrowthFromChildren = 0
    
    var proposedGrowthAmount = 0
    
    public var currentSize = 0
    //public var childrenSize = 0
    
    var __snapshotCurrentSize = 0
    var __expectedCurrentSize = 0
    
    
    public let id: Int
    
    public var nodes = [WiseLayoutNode]()
    //public let alignment: LayoutAlignment
    
    
    //TODO: Back to unowned...
    public var row: SkeletonRow!
    
    public var x = 0
    public var width = 0
    
    var isLeftOfCenter = false
    var indexInRow = -1
    
    var isLockedAtEveryPriority = false
    var isLockedAtCurrentPriority = false
    
    init(id: Int,
         nodes: [WiseLayoutNode]) {
        self.id = id
        self.nodes = nodes
        for _node in nodes {
            _node.section = self
            for piece in _node.pieces {
                piece.section = self
            }
            for flexer in _node.flexers {
                flexer.section = self
            }
        }
    }
    
    static func contains(list: [SkeletonSection], section: SkeletonSection) -> Bool {
        for _section in list {
            if _section === section {
                return true
            }
        }
        return false
    }
    
    func contains(node: WiseLayoutNode) -> Bool {
        for _node in nodes {
            if _node === node {
                return true
            }
        }
        return false
    }
    
    func contains(piece: SkeletonPiece) -> Bool {
        for _node in nodes {
            for _piece in _node.pieces {
                if _piece === piece {
                    return true
                }
            }
            
        }
        return false
    }
    
    func contains(flexer: Flexer) -> Bool {
        for _node in nodes {
            for _flexer in _node.flexers {
                if _flexer === flexer {
                    return true
                }
            }
            
        }
        return false
    }
    
    func countPieces() -> Int {
        var result = 0
        for _node in nodes {
            result += _node.pieces.count
        }
        return result
    }
    
    func countFlexers() -> Int {
        var result = 0
        for _node in nodes {
            result += _node.flexers.count
        }
        return result
    }
    
    func positionContentAfterSizeComputation() {
        var width_of_all_nodes = 0
        for _node in nodes {
            width_of_all_nodes += _node.currentSize
        }
        
        var layout_x = 0
        for _node in nodes {
            _node.x = layout_x
            layout_x += _node.currentSize
        }
    }

    func currentSizeMatchesChildren() -> Bool {
        var sum = 0
        for node in nodes {
            sum += node.currentSize
        }
        if (sum == currentSize) {
            return true
        } else {
            return false
        }
    }
}
