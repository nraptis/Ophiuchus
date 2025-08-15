//
//  SmartLayoutUtilities.swift
//  Ophiuchus
//
//  Created by Nick on 8/11/25.
//

import Foundation

struct SmartLayoutUtilities {
    
    
    
    
    
    /*
     static func attemptToFloodNodesByRequestedGrowthFromChildren(nodes: [WiseLayoutNode], nodeCount: Int) -> Bool {
     
     var result = false
     ListFactory_GroupsUnique.resetNodeGroupList()
     for nodeIndex in 0..<ListFactory_Growth.nodeListCount {
     let node = ListFactory_Growth.nodeList[nodeIndex]
     let nodeGroup = node.group!
     
     if nodeGroup.isActiveAtCurrentPriority {
     ListFactory_GroupsUnique.intake(nodeGroup: nodeGroup, node: node)
     } else {
     
     if attemptToFloodOneNodeByAmountWithoutConsideringGroup(node: node, amount: node.requestedGrowthFromChildren) {
     result = true
     }
     }
     
     
     ListFactory_GroupsUnique.intake(nodeGroup: nodeGroup)
     }
     
     
     
     for nodeGroupIndex in 0..<ListFactory_GroupsUnique.nodeGroupListCount {
     let nodeGroup = ListFactory_GroupsUnique.nodeGroupList[nodeGroupIndex]
     let nodes = ListFactory_GroupsUnique.nodeGroupPairedNodeList[nodeGroupIndex]
     let nodeCount = ListFactory_GroupsUnique.nodeGroupPairedNodeListCounts[nodeGroupIndex]
     
     print("We got a node group, \(nodeGroup.linkedList.map { $0.id })")
     for nodeIndex in 0..<nodeCount {
     let node = nodes[nodeIndex]
     print("Node \(node.id) trying to grow by \(node.requestedGrowthFromChildren)")
     }
     print(".....")
     
     
     }
     
     /*
      ListFactory_Growth.resetSectionList()
      for nodeIndex in 0..<ListFactory_Growth.nodeListCount {
      let node = ListFactory_Growth.nodeList[nodeIndex]
      var proposedGrowthAmount = (node.requestedGrowthFromChildren - (node.currentSize - node.childrenSize))
      if proposedGrowthAmount < 0 { proposedGrowthAmount = 0 }
      let section = node.section!
      ListFactory_Growth.intake(section: section,
      growth: proposedGrowthAmount)
      }
      */
     
     return result
     }
     */
    
    /*
     static func attemptToFloodPieceContainersBubbleUp(pieces: [SkeletonPiece], pieceCount: Int) -> Bool {
     ListFactory_Growth.resetNodeList()
     for pieceIndex in 0..<pieceCount {
     let piece = pieces[pieceIndex]
     let node = piece.node!
     ListFactory_Growth.intake(node: node)
     }
     let result = attemptToFloodNodesByRequestedGrowthFromChildren(nodes: ListFactory_Growth.nodeList,
     nodeCount: ListFactory_Growth.nodeListCount)
     return result
     }
     
     static func attemptToFloodFlexerContainersBubbleUp(flexers: [Flexer], flexerCount: Int) -> Bool {
     ListFactory_Growth.resetNodeList()
     for flexerIndex in 0..<flexerCount {
     let flexer = flexers[flexerIndex]
     let node = flexer.node!
     ListFactory_Growth.intake(node: node)
     }
     let result = attemptToFloodNodesByRequestedGrowthFromChildren(nodes: ListFactory_Growth.nodeList,
     nodeCount: ListFactory_Growth.nodeListCount)
     return result
     }
     */
    
    static func attemptToGrowSectionsByRequestedGrowthFromChildren(sections: [SkeletonSection],
                                                                   sectionCount: Int) -> Bool {
        
        
        return true
    }
    
    static func isAnySectionLocked(sections: [SkeletonSection], sectionCount: Int) -> Bool {
        for sectionIndex in 0..<sectionCount {
            let section = sections[sectionIndex]
            if section.isLockedAtEveryPriority { return true }
            if section.isLockedAtCurrentPriority { return true }
        }
        return false
    }
    
    static func isAnySectionOrNodeLockedAtEveryPriority(nodes: [WiseLayoutNode], nodeCount: Int) -> Bool {
        for nodeIndex in 0..<nodeCount {
            let node = nodes[nodeIndex]
            if node.isLockedAtEveryPriority { return true }
            let section = node.section!
            if section.isLockedAtEveryPriority { return true }
        }
        return false
    }
    
    static func isAnySectionOrNodeLockedAtCurrentPriority(nodes: [WiseLayoutNode], nodeCount: Int) -> Bool {
        for nodeIndex in 0..<nodeCount {
            let node = nodes[nodeIndex]
            if node.isLockedAtCurrentPriority { return true }
            let section = node.section!
            if section.isLockedAtCurrentPriority { return true }
        }
        return false
    }
    
    static func isAnyNodeLockedAtEveryPriority(pieces: [SkeletonPiece], pieceCount: Int) -> Bool {
        for pieceIndex in 0..<pieceCount {
            let piece = pieces[pieceIndex]
            let node = piece.node!
            if node.isLockedAtEveryPriority { return true }
        }
        return false
    }
    
    static func isAnyNodeLockedAtCurrentPriority(pieces: [SkeletonPiece], pieceCount: Int) -> Bool {
        for pieceIndex in 0..<pieceCount {
            let piece = pieces[pieceIndex]
            let node = piece.node!
            if node.isLockedAtCurrentPriority { return true }
        }
        return false
    }
    
    /*
     static func isAnySectionOrNodeLocked(nodes: [WiseLayoutNode], nodeCount: Int) -> Bool {
     for nodeIndex in 0..<nodeCount {
     let node = nodes[nodeIndex]
     if node.isLockedAtEveryPriority { return true }
     if node.isLockedAtCurrentPriority { return true }
     let section = node.section!
     if section.isLockedAtEveryPriority { return true }
     if section.isLockedAtCurrentPriority { return true }
     }
     return false
     }
     
     static func isAnySectionLocked(nodes: [WiseLayoutNode], nodeCount: Int) -> Bool {
     for nodeIndex in 0..<nodeCount {
     let node = nodes[nodeIndex]
     let section = node.section!
     if section.isLockedAtEveryPriority { return true }
     if section.isLockedAtCurrentPriority { return true }
     }
     return false
     }
     */
    
    static func canAllNodesGrowByOne(nodes: [WiseLayoutNode], nodeCount: Int) -> Bool {
        
        if nodeCount <= 0 {
            fatalError("Why would we query \"canAllNodesGrowByOne\" with no nodes?")
            //return false
        }
        
        /*
         ListFactory_Growth.resetSectionList()
         for nodeIndex in 0..<nodeCount {
         let node = nodes[nodeIndex]
         let section = node.section!
         ListFactory_Growth.intake(section: section,
         node: node,
         growth: 1)
         }
         
         ListFactory_Growth.resetRowList()
         for sectionIndex in 0..<ListFactory_Growth.sectionListCount {
         
         let section = ListFactory_Growth.sectionList[sectionIndex]
         section.proposedGrowthAmount = section.requestedGrowthFromChildren
         let row = section.row!
         ListFactory_Growth.intake(row: row,
         section: section)
         }
         
         var result = false
         for rowIndex in 0..<ListFactory_Growth.rowListCount {
         let row = ListFactory_Growth.rowList[rowIndex]
         let sectionListCount = ListFactory_Growth.rowGroupedSectionsListCounts[rowIndex]
         if row.canGrowAllSectionsByProposedGrowthAmount(sections: ListFactory_Growth.rowGroupedSectionsList[rowIndex],
         sectionCount: sectionListCount) == false {
         return false
         }
         }
         */
        return true
    }
    
    
    
    
    static func canAllPiecesGrowByOne_BROKEN_DO_NOT_USE(pieces: [SkeletonPiece], pieceCount: Int) -> Bool {
        
        if pieceCount <= 0 {
            fatalError("Why would we query \"canAllPiecesGrowByOne\" with no pieces?")
            //return false
        }
        
        // First check: Can they all grow by 1 *WITHOUT* growing nodes?
        
        
        
        
        
        
        
        if attemptToGrowSectionsByRequestedGrowthFromChildren(sections: ListFactory_Growth.sectionList,
                                                              sectionCount: ListFactory_Growth.sectionListCount) {
            
            //
            
            
        } else {
            return false
        }
        
        /*
         ListFactory_Growth.resetRowList()
         for nodeIndex in 0..<ListFactory_Growth.nodeListCount {
         
         let node = ListFactory_Growth.nodeList[nodeIndex]
         node.proposedGrowthAmount = node.requestedGrowthFromChildren
         let row = section.row!
         ListFactory_Growth.intake(row: row,
         section: section)
         }
         */
        
        var result = false
        for rowIndex in 0..<ListFactory_Growth.rowListCount {
            let row = ListFactory_Growth.rowList[rowIndex]
            let sectionListCount = ListFactory_Growth.rowGroupedSectionsListCounts[rowIndex]
            if row.canGrowAllSectionsByProposedGrowthAmount(sections: ListFactory_Growth.rowGroupedSectionsList[rowIndex],
                                                            sectionCount: sectionListCount) == false {
                return false
            }
        }
        return true
    }
    
    
    
    
    
    
    static func canAllPiecesGrowByOne_WithoutGrowingNodes(pieces: [SkeletonPiece], pieceCount: Int) -> Bool {
        for pieceIndex in 0..<pieceCount { pieces[pieceIndex].node!.temp = 0 }
        for pieceIndex in 0..<pieceCount {
            let piece = pieces[pieceIndex]
            let node = piece.node!
            node.temp += 1
            if (node.currentSize - node.childrenSize) < node.temp {
                print("node.currentSize = \(node.currentSize), node.childrenSize = \(node.childrenSize), node.temp = \(node.temp)")
                return false
            }
        }
        return true
    }
    
    static func canAllFlexersGrowByOne_WithoutGrowingNodes(flexers: [Flexer], flexerCount: Int) -> Bool {
        for flexerIndex in 0..<flexerCount { flexers[flexerIndex].node!.temp = 0 }
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            let node = flexer.node!
            node.temp += 1
            if (node.currentSize - node.childrenSize) < node.temp {
                return false
            }
        }
        return true
    }
    
    static func growAllPiecesByOne_Unsafe(pieces: [SkeletonPiece], pieceCount: Int) {
        for pieceIndex in 0..<pieceCount {
            let piece = pieces[pieceIndex]
            growPieceByOne_Unsafe(piece: piece)
        }
    }
    
    static func growPieceByOne_Unsafe(piece: SkeletonPiece) {
        piece.currentSize += 1
        let node = piece.node!
        if (node.childrenSize < node.currentSize) {
            node.childrenSize += 1
            return
        }
        growNodeByOne_Unsafe(node: node)
        node.childrenSize += 1
    }
    
    
    static func growAllFlexersByOne_Unsafe(flexers: [Flexer], flexerCount: Int) {
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            growFlexerByOne_Unsafe(flexer: flexer)
        }
    }
    
    static func growFlexerByOne_Unsafe(flexer: Flexer) {
        
        flexer.currentSize += 1
        let node = flexer.node!
        if (node.childrenSize < node.currentSize) {
            node.childrenSize += 1
            return
        }
        
        growNodeByOne_Unsafe(node: node)
        node.childrenSize += 1
    }
    
    static func growAllNodesByOne_Unsafe(nodes: [WiseLayoutNode], nodeCount: Int) {
        for nodeIndex in 0..<nodeCount {
            let node = nodes[nodeIndex]
            growNodeByOne_Unsafe(node: node)
        }
    }
    
    static func growNodeByOne_Unsafe(node: WiseLayoutNode) {
        let section = node.section!
        let row = node.row!
        node.currentSize += 1
        section.currentSize += 1
        row.growthBudget -= 1
        if row.centeredSection !== nil {
            if section.indexInRow < row.centeredSectionIndex {
                row.leftSizeWithCenteredSection += 1
            } else if section.indexInRow > row.centeredSectionIndex {
                row.rightSizeWithCenteredSection += 1
            } else {
                row.centerSizeWithCenteredSection += 1
            }
        }
    }
    
    static func growNodeByAmount_Unsafe(node: WiseLayoutNode, amount: Int) {
        let section = node.section!
        let row = node.row!
        node.currentSize += amount
        section.currentSize += amount
        row.growthBudget -= amount
        if row.centeredSection !== nil {
            if section.indexInRow < row.centeredSectionIndex {
                row.leftSizeWithCenteredSection += amount
            } else if section.indexInRow > row.centeredSectionIndex {
                row.rightSizeWithCenteredSection += amount
            } else {
                row.centerSizeWithCenteredSection += amount
            }
        }
    }
    
}
