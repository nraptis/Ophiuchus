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
     ListFactory_GroupsUniqueA.resetNodeGroupList()
     for nodeIndex in 0..<ListFactory_Growth.nodeListCount {
     let node = ListFactory_Growth.nodeList[nodeIndex]
     let nodeGroup = node.group!
     
     if nodeGroup.isActiveAtCurrentPriorityOrMono {
     ListFactory_GroupsUniqueA.intake(nodeGroup: nodeGroup, node: node)
     } else {
     
     if attemptToFloodOneNodeByAmountWithoutConsideringGroup(node: node, amount: node.requestedGrowthFromChildren) {
     result = true
     }
     }
     
     
     ListFactory_GroupsUniqueA.intake(nodeGroup: nodeGroup)
     }
     
     
     
     for nodeGroupIndex in 0..<ListFactory_GroupsUniqueA.nodeGroupListCount {
     let nodeGroup = ListFactory_GroupsUniqueA.nodeGroupList[nodeGroupIndex]
     let nodes = ListFactory_GroupsUniqueA.nodeGroupPairedNodeList[nodeGroupIndex]
     let nodeCount = ListFactory_GroupsUniqueA.nodeGroupPairedNodeListCounts[nodeGroupIndex]
     
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
    
    static func isAnyNodeLockedAtEveryPriority(flexers: [Flexer], flexerCount: Int) -> Bool {
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            let node = flexer.node!
            if node.isLockedAtEveryPriority { return true }
        }
        return false
    }
        
    static func isAnyNodeLockedAtCurrentPriority(flexers: [Flexer], flexerCount: Int) -> Bool {
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            let node = flexer.node!
            if node.isLockedAtCurrentPriority { return true }
        }
        return false
    }
    
    static func isEveryFlexerTryingToGrowAtCurrentPriority_AndNoNodesAreLocked(flexers: [Flexer], flexerCount: Int) -> Bool {
        var result = true
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            if flexer.currentSize >= flexer.targetSizeCurrentPriority {
                result = false
                break
            }
            let node = flexer.node!
            if node.isLockedAtCurrentPriority || node.isLockedAtEveryPriority {
                result = false
                break
            }
        }
        return result
    }
    
    static func isEveryFlexerWhereNoNodesAreUnlocked(flexers: [Flexer], flexerCount: Int) -> Bool {
        var result = true
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            let node = flexer.node!
            if node.isLockedAtCurrentPriority || node.isLockedAtEveryPriority {
                result = false
                break
            }
        }
        return result
    }
    
    static func isAnyFlexerTryingToGrowAtCurrentPriority_AndNoNodesAreLocked(flexers: [Flexer], flexerCount: Int) -> Bool {
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            if flexer.currentSize < flexer.targetSizeCurrentPriority {
                let node = flexer.node!
                if (node.isLockedAtCurrentPriority == false) && (node.isLockedAtEveryPriority == false) {
                    return true
                }
            }
        }
        return false
    }
    
    static func isAnyFlexerPossiblyAbleToGrowAtCurrentPriority(flexers: [Flexer], flexerCount: Int) -> Bool {
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            if flexer.currentSize < flexer.targetSizeCurrentPriority {
                let node = flexer.node!
                if ((node.isLockedAtCurrentPriority == true) || (node.isLockedAtEveryPriority == true)) {
                    if node.childrenSize < node.currentSize {
                        // We could grow into the node.
                        return true
                    }
                } else {
                    // The node is not locked, so it's possible we can grow,
                    // even if it means the node has to grow as well...
                    return true
                }
            }
        }
        return false
    }
    
    static func isFlexerPossiblyAbleToGrowAtCurrentPriority(flexer: Flexer) -> Bool {
        if flexer.currentSize < flexer.targetSizeCurrentPriority {
            let node = flexer.node!
            if ((node.isLockedAtCurrentPriority == true) || (node.isLockedAtEveryPriority == true)) {
                if node.childrenSize < node.currentSize {
                    // We could grow into the node.
                    return true
                } else {
                    return false
                }
            } else {
                // The node is not locked, so it's possible we can grow,
                // even if it means the node has to grow as well...
                return true
            }
        } else {
            return false
        }
    }
    
    //
    // @Precondition: All the flexers have the exact same currentSize
    // @Precondition: All the flexers are in the same group.
    // @Precondition: All the flexers are the smallest flexers in their group.
    // @Precondition: The one flexer group is either active or mono at this priority.
    //
    static func isEveryFlexerPossiblyAbleToGrowAtCurrentPriority_AllSameSize_SmallestListOnly(flexers: [Flexer], flexerCount: Int) -> Bool {
        
        if flexerCount <= 0 {
            fatalError("TODO: Remove Error. Should not have <= 0 flexerCount")
        }
        
        if true {
            let expectedSize = flexers[0].currentSize
            let expectedGroup = flexers[0].group!
            
            //if (expectedGroup.isActiveAtCurrentPriorityOrMono == false) {
            //    fatalError("TODO: Remove Error. Should be active or mono at given priority.")
            //}
            
            for flexerIndex in 0..<flexerCount {
                let flexer = flexers[flexerIndex]
                if flexer.currentSize != expectedSize {
                    fatalError("TODO: Remove Error. Flexer sizes should all be the same...")
                }
            }
            
            for flexerIndex in 0..<flexerCount {
                let flexer = flexers[flexerIndex]
                let flexerGroup = flexer.group!
                
                if flexerGroup !== expectedGroup {
                    print("TODO: Remove Error. Flexers all should be same group...")
                }
                
                for checkFlexer in flexerGroup.linkedList {
                    if checkFlexer.currentSize < flexer.currentSize {
                        fatalError("TODO: Remove Error. Flexers should *ALL* be the smallest in group here...")
                    }
                }
            }
        }
        
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            let node = flexer.node!
            if ((node.isLockedAtCurrentPriority == true) || (node.isLockedAtEveryPriority == true)) {
                if node.childrenSize >= node.currentSize {
                    return false
                }
            }
        }
        return true
    }
    
    static func isEveryFlexerBelowTargetSizeCurrentPriority(flexers: [Flexer], flexerCount: Int) -> Bool {
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            if flexer.currentSize >= flexer.targetSizeCurrentPriority {
                return false
            }
        }
        return true
    }
    
    static func isEveryFlexerTheSameSize(flexers: [Flexer], flexerCount: Int) -> Bool {
        if flexerCount > 0 {
            let expectedSize = flexers[0].currentSize
            for flexerIndex in 0..<flexerCount {
                let flexer = flexers[flexerIndex]
                if flexer.currentSize != expectedSize {
                    return false
                }
            }
        }
        return true
    }
    
    /*
    //
    // @Precondition: All the flexers have the exact same currentSize
    // @Precondition: All the flexers are in the same group.
    // @Precondition: The one flexer group is either active or mono at this priority.
    //
    static func isEveryFlexerPossiblyAbleToGrowAtCurrentPriority_AllSameSize(flexers: [Flexer], flexerCount: Int) -> Bool {
        
        if flexerCount <= 0 {
            fatalError("TODO: Remove Error. Should not have <= 0 flexerCount")
        }
        
        if true {
            let expectedSize = flexers[0].currentSize
            let expectedGroup = flexers[0].group!
            
            if expectedGroup.isMono {
                
            }
            
            
            if (expectedGroup.isActiveAtCurrentPriorityOrMono == false) {
                fatalError("TODO: Remove Error. Should be active or mono at given priority.")
            }
            
            for flexerIndex in 0..<flexerCount {
                let flexer = flexers[flexerIndex]
                if flexer.currentSize != expectedSize {
                    fatalError("TODO: Remove Error. Flexer sizes should all be the same...")
                }
            }
            
            for flexerIndex in 0..<flexerCount {
                let flexer = flexers[flexerIndex]
                let flexerGroup = flexer.group!
                
                if flexerGroup !== expectedGroup {
                    print("TODO: Remove Error. Flexers all should be same group...")
                }
                
                for checkFlexer in flexerGroup.linkedList {
                    if checkFlexer.currentSize < flexer.currentSize {
                        fatalError("TODO: Remove Error. Flexers should *ALL* be the smallest in group here...")
                    }
                }
            }
        }
        
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            if flexer.currentSize < flexer.targetSizeCurrentPriority {
                let node = flexer.node!
                if ((node.isLockedAtCurrentPriority == true) || (node.isLockedAtEveryPriority == true)) {
                    if node.childrenSize >= node.currentSize {
                        return false
                    }
                }
            }
        }
        return true
    }
    */
    
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
        
        
        for nodeIndex in 0..<nodeCount {
        let node = nodes[nodeIndex]
            let section = node.section!
            section.proposedGrowthAmount = 0
        }
        
        for nodeIndex in 0..<nodeCount {
        let node = nodes[nodeIndex]
            let section = node.section!
            section.proposedGrowthAmount += 1
        }
        
        ListFactory_Growth.resetRowList()
        for nodeIndex in 0..<nodeCount {
        let node = nodes[nodeIndex]
            let section = node.section!
            let row = section.row!
            ListFactory_Growth.intake(row: row, section: section)
        }
        
        var result = true
        for rowIndex in 0..<ListFactory_Growth.rowListCount {
            let row = ListFactory_Growth.rowList[rowIndex]
            let sections = ListFactory_Growth.rowGroupedSectionsList[rowIndex]
            let sectionCount = ListFactory_Growth.rowGroupedSectionsListCounts[rowIndex]
            
            if !row.canGrowAllSectionsByProposedGrowthAmount(sections: sections, sectionCount: sectionCount) {
                result = false
                break
            }
        }

        return result
    }
    
    // Used
    static func canAllPiecesGrowByOne_WithoutGrowingNodes(pieces: [SkeletonPiece], pieceCount: Int) -> Bool {
        for pieceIndex in 0..<pieceCount { pieces[pieceIndex].node!.temp = 0 }
        for pieceIndex in 0..<pieceCount {
            let piece = pieces[pieceIndex]
            let node = piece.node!
            node.temp += 1
            if (node.currentSize - node.childrenSize) < node.temp {
                
                
                return false
            }
        }
        return true
    }
    
    // Used
    static func canAllFlexersGrowByOne_WithoutGrowingNodes_InactiveGroupOrMono(flexers: [Flexer], flexerCount: Int) -> Bool {
        for flexerIndex in 0..<flexerCount { flexers[flexerIndex].node!.temp = 0 }
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            if flexer.currentSize < flexer.targetSizeCurrentPriority {
                let node = flexer.node!
                node.temp += 1
                if (node.currentSize - node.childrenSize) < node.temp {
                    return false
                }
            }
        }
        return true
    }
    
    static func canOneFlexersGrowByOne_WithoutGrowingNodes(flexer: Flexer) -> Bool {
        if flexer.currentSize >= flexer.targetSizeCurrentPriority {
            return false
        }
        let node = flexer.node!
        if (node.currentSize - node.childrenSize) < 1 {
            return false
        }
        return true
    }
    
    static func canAllFlexersGrowByOne_WithoutGrowingNodes_ActiveSmallestList(flexers: [Flexer], flexerCount: Int) -> Bool {
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
    
    //
    // @Precondition: All the flexers have the exact same currentSize
    // @Precondition: Every flexer is able to grow!
    //
    static func canAllFlexersGrowByOne_WithoutGrowingNodes_ActiveAllEqual(flexers: [Flexer], flexerCount: Int) -> Bool {
        
        if true {
            let expectedSize = flexers[0].currentSize
            let expectedGroup = flexers[0].group!
            
            //if (expectedGroup.isActiveAtCurrentPriorityOrMono == false) {
            //    fatalError("TODO: Remove Error. Should be active or mono at given priority.")
            //}
            
            for flexerIndex in 0..<flexerCount {
                let flexer = flexers[flexerIndex]
                if flexer.currentSize != expectedSize {
                    fatalError("TODO: Remove Error. Flexer sizes should all be the same...")
                }
                
                if flexer.currentSize >= flexer.targetSizeCurrentPriority {
                    fatalError("TODO: Remove. @Precondition: Every flexer is able to grow!")
                }
            }
            
            for flexerIndex in 0..<flexerCount {
                let flexer = flexers[flexerIndex]
                let flexerGroup = flexer.group!
                
                if flexerGroup !== expectedGroup {
                    print("TODO: Remove Error. Flexers all should be same group...")
                }
                
                for checkFlexer in flexerGroup.linkedList {
                    if checkFlexer.currentSize < flexer.currentSize {
                        fatalError("TODO: Remove Error. Flexers should *ALL* be the smallest in group here...")
                    }
                }
            }
        }
        
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
            node.didGrowOnCurrentPass = true
            node.childrenSize += 1
            return
        }
        growNodeByOne_Unsafe(node: node)
        node.childrenSize += 1
    }
    
    
    static func growAllFlexersByOne_Unsafe_InactiveGroupOrMono(flexers: [Flexer], flexerCount: Int) {
        for flexerIndex in 0..<flexerCount {
            let flexer = flexers[flexerIndex]
            if flexer.currentSize < flexer.targetSizeCurrentPriority {
                growFlexerByOne_Unsafe(flexer: flexer)
            }
        }
    }
    
    static func growAllFlexersByOne_Unsafe_ActiveSmallestList(flexers: [Flexer], flexerCount: Int) {
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
            node.didGrowOnCurrentPass = true
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
        node.didGrowOnCurrentPass = true
        section.currentSize += 1
        row.growthBudget -= 1
        
        if row.growthBudget < 0 {
            print("FATAL! Row growth budget went negative! \(row.growthBudget)")
        }
        
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
        if amount > 0 {
            node.didGrowOnCurrentPass = true
            node.currentSize += amount
            section.currentSize += amount
            row.growthBudget -= amount
            
            if row.growthBudget < 0 {
                print("FATAL! Row growth budget went negative, it is \(row.growthBudget), on \(row.debug_slot), \(row.debug_page)")
            }
            
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
}
