//
//  SkeletonSection.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

public class SkeletonSection: InterfaceContainerSupplier {
    
    static func contains(list: [SkeletonSection], section: SkeletonSection) -> Bool {
        for _section in list {
            if _section === section {
                return true
            }
        }
        return false
    }
    
    func contains(node: SkeletonNode) -> Bool {
        for _node in skeletonNodes {
            if _node === node {
                return true
            }
        }
        return false
    }
    
    func contains(chunk: SkeletonChunk) -> Bool {
        for _node in skeletonNodes {
            for _chunk in _node.chunks {
                if _chunk === chunk {
                    return true
                }
            }
        }
        return false
    }
    
    func contains(piece: SkeletonPiece) -> Bool {
        for _node in skeletonNodes {
            for _chunk in _node.chunks {
                for _piece in _chunk.pieces {
                    if _piece === piece {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func contains(flexer: Flexer) -> Bool {
        for _node in skeletonNodes {
            for _chunk in _node.chunks {
                for _flexer in _chunk.flexers {
                    if _flexer === flexer {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func countChunks() -> Int {
        var result = 0
        
            for node in skeletonNodes {
                result += node.chunks.count
            }
        
        return result
    }
    
    func countPieces() -> Int {
        var result = 0
        
            for node in skeletonNodes {
                for chunk in node.chunks {
                    result += chunk.pieces.count
                }
            }
        
        return result
    }
    
    func countFlexers() -> Int {
        var result = 0
        
            for node in skeletonNodes {
                for chunk in node.chunks {
                    result += chunk.flexers.count
                }
            }
        
        return result
    }
    
    public var currentSize = 0
    public var childrenSize = 0
    public var didGrowOnCurrentPass = false
    
    public let id: Int
    
    var skeletonNodes = [SkeletonNode]()
    let layoutNodes: [WiseLayoutNode]
    let alignment: LayoutAlignment
    
    unowned var row: SkeletonRow!
    unowned var group: ExploderGroup<SkeletonSection>!
    
    public var x = 0
    public var width = 0
    
    var isLeftOfCenter = false
    var indexInRow = -1
    
    var growthPlanIndex = -1
    
    init(id: Int,
         layoutNodes: [WiseLayoutNode],
         alignment: LayoutAlignment) {
        self.id = id
        self.layoutNodes = layoutNodes
        self.alignment = alignment
    }
    
    func growChildrenByOne_Unsafe_Bubble() {
        if childrenSize < currentSize {
            childrenSize += 1
        } else {
            growByOne_Unsafe_Bubble()
            childrenSize = currentSize
        }
        didGrowOnCurrentPass = true
    }
    
    func growByOne_Unsafe_Bubble() {
        currentSize += 1
        row.growChildrenByOne_Unsafe(section: self)
        didGrowOnCurrentPass = true
    }
    
    func computeSize(layoutPriority: LayoutPriority) -> Int {
        var result = 0
        for skeletonNode in skeletonNodes {
            result += skeletonNode.computeSize(layoutPriority: layoutPriority)
        }
        return result
    }
    
    public func adopt(layoutStrategy: InterfaceLayoutStrategy) {
        skeletonNodes.removeAll(keepingCapacity: true)
        for layoutNode in layoutNodes {
            skeletonNodes.append(contentsOf: layoutNode.skeletonNodes)
        }
    }
    
    public func adopt_test() {
        skeletonNodes.removeAll(keepingCapacity: true)
        for layoutNode in layoutNodes {
            skeletonNodes.append(contentsOf: layoutNode.skeletonNodes)
        }
    }
    
    
    public func log_me(name: String, row_index: Int, section_index: Int) {
        print("\t\tSection \(section_index) from row \(row_index) with \(skeletonNodes.count) nodes, from \(name)...")
        
    }
    
    func position_content_after_size_computation() {
        var width_of_all_nodes = 0
        for node in skeletonNodes {
            width_of_all_nodes += node.currentSize
        }
        
        var layout_x = 0
        switch alignment {
        case .none, .left:
            for node in skeletonNodes {
                node.x = layout_x
                layout_x += node.currentSize
            }
        case .center:
            layout_x = currentSize / 2 - width_of_all_nodes / 2
            if layout_x < 0 { layout_x = 0 }
            for node in skeletonNodes {
                node.x = layout_x
                layout_x += node.currentSize
            }
        case .right:
            layout_x = currentSize - width_of_all_nodes
            if layout_x < 0 { layout_x = 0 }
            for node in skeletonNodes {
                node.x = layout_x
                layout_x += node.currentSize
            }
        }
        
        for node in skeletonNodes {
            node.position_content_after_size_computation()
        }
        
    }
    
    func canGrowByOne() -> Bool {
        if row.canGrowByOne(section: self) {
            return true
        }
        return false
    }
    
}
