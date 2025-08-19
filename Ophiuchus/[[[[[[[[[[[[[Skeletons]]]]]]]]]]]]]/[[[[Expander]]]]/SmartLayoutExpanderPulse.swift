//
//  SmartLayoutExpanderPulse.swift
//  Ophiuchus
//
//  Created by Nick on 8/11/25.
//

import Foundation

struct SmartLayoutExpanderPulse {
    
    static func pulse() -> Bool {
        var result = false
        for nodeGroupIndex in 0..<ListFactory_GroupsA.nodeGroupListCount {
            let nodeGroup = ListFactory_GroupsA.nodeGroupList[nodeGroupIndex]
            for node in nodeGroup.linkedList {
                node.didChildRequestGrowthOnCurrentPass = false
                node.didGrowOnCurrentPass = false
            }
        }
        
        if step_a_apply_node_group_rules() {
            result = true
        }
        if step_b_apply_piece_group_rules() {
            result = true
        }
        if step_c_apply_flexers() {
            result = true
        }
        if step_d_node_ubiquitous_growth() {
            result = true
        }
        
        return result
    }
    
    // This function is done, do not change.
    static func step_a_apply_node_group_rules() -> Bool {
        var result = false
        ListFactory_GroupsA.tempNodeGroupListReset()
        for nodeGroupIndex in 0..<ListFactory_GroupsA.nodeGroupListCount {
            let nodeGroup = ListFactory_GroupsA.nodeGroupList[nodeGroupIndex]
            if (nodeGroup.isLockedAtCurrentPriority == true) { continue }
            if (nodeGroup.isLockedAtEveryPriority == true) { continue }
            if (nodeGroup.isMono == true) { continue }
            if (nodeGroup.isActiveAtCurrentPriority == false) { continue }
            if nodeGroup.computeSmallestIfNotAllEqual() {
                if SmartLayoutUtilities.isAnySectionOrNodeLockedAtEveryPriority(nodes: nodeGroup.smallestList, nodeCount: nodeGroup.smallestList.count) {
                    nodeGroup.isLockedAtEveryPriority = true
                    continue
                }
                
                if SmartLayoutUtilities.isAnySectionOrNodeLockedAtCurrentPriority(nodes: nodeGroup.smallestList, nodeCount: nodeGroup.smallestList.count) {
                    nodeGroup.isLockedAtCurrentPriority = true
                    continue
                }
                
                if SmartLayoutUtilities.canAllNodesGrowByOne(nodes: nodeGroup.smallestList, nodeCount: nodeGroup.smallestList.count) {
                    SmartLayoutUtilities.growAllNodesByOne_Unsafe(nodes: nodeGroup.smallestList, nodeCount: nodeGroup.smallestList.count)
                    result = true
                    ListFactory_GroupsA.tempNodeGroupListAdd(nodeGroup: nodeGroup)
                } else {
                    nodeGroup.isLockedAtEveryPriority = true
                    continue
                }
            } else {
                ListFactory_GroupsA.tempNodeGroupListAdd(nodeGroup: nodeGroup)
            }
        }
        ListFactory_GroupsA.nodeGroupListSwap()
        return result
    }
    
    static func step_b_apply_piece_group_rules() -> Bool {
        
        var result = false
        
        ListFactory_GroupsA.tempPieceGroupListReset()
        
        for pieceGroupIndex in 0..<ListFactory_GroupsA.pieceGroupListCount {
            let pieceGroup = ListFactory_GroupsA.pieceGroupList[pieceGroupIndex]
            
            if (pieceGroup.isLockedAtCurrentPriority == true) { continue }
            if (pieceGroup.isLockedAtEveryPriority == true) { continue }
            if (pieceGroup.isMono == true) { continue }
            if (pieceGroup.isActiveAtCurrentPriority == false) { continue }
            
            if pieceGroup.computeSmallestIfNotAllEqual() {
                
                // These pieces all want to grow by 1.
                if SmartLayoutUtilities.isAnyNodeLockedAtEveryPriority(pieces: pieceGroup.smallestList,
                                                                       pieceCount: pieceGroup.smallestList.count) {
                    pieceGroup.isLockedAtEveryPriority = true
                    continue
                }
                
                
                if SmartLayoutUtilities.isAnyNodeLockedAtCurrentPriority(pieces: pieceGroup.smallestList,
                                                                         pieceCount: pieceGroup.smallestList.count) {
                    pieceGroup.isLockedAtCurrentPriority = true
                    continue
                }
                
                if pieceGroup.computeSmallestIfNotAllEqual() {
                    ListFactory_GroupsA.tempPieceGroupListAdd(pieceGroup: pieceGroup)
                } else {
                    pieceGroup.isLockedAtCurrentPriority = true
                    continue
                }
            }
        }
        
        ListFactory_GroupsA.pieceGroupListSwap()
        
        for pieceGroupIndex in 0..<ListFactory_GroupsA.pieceGroupListCount {
            let pieceGroup = ListFactory_GroupsA.pieceGroupList[pieceGroupIndex]
            for piece in pieceGroup.linkedList {
                let node = piece.node!
                node.requestedGrowthFromChildrenMax = 0
                node.requestedGrowthFromChildrenMin = Int.max
            }
        }

        for pieceGroupIndex in 0..<ListFactory_GroupsA.pieceGroupListCount {
            let pieceGroup = ListFactory_GroupsA.pieceGroupList[pieceGroupIndex]
            
            if pieceGroup.smallestList.count <= 0 {
                fatalError("These should all have a smallest group")
            }
            
            ListFactory_UniqueA.resetNodeList()
            for piece in pieceGroup.smallestList {
                let node = piece.node!
                ListFactory_UniqueA.intake(node: node)
            }
            
            for nodeIndex in 0..<ListFactory_UniqueA.nodeListCount {
                let node = ListFactory_UniqueA.nodeList[nodeIndex]
                node.requestedGrowthFromChildren = 0
            }
            
            for piece in pieceGroup.smallestList {
                let node = piece.node!
                node.requestedGrowthFromChildren += 1
            }
            
            
            
            for nodeIndex in 0..<ListFactory_UniqueA.nodeListCount {
                let node = ListFactory_UniqueA.nodeList[nodeIndex]
                if node.requestedGrowthFromChildren > 0 {
                    //node.didChildRequestGrowthOnCurrentPass = true
                    node.requestedGrowthFromChildrenMax += node.requestedGrowthFromChildren
                    if node.requestedGrowthFromChildren < node.requestedGrowthFromChildrenMin {
                        node.requestedGrowthFromChildrenMin = node.requestedGrowthFromChildren
                    }
                }
            }
        }
        
        ListFactory_UniqueA.resetNodeList()
        for pieceGroupIndex in 0..<ListFactory_GroupsA.pieceGroupListCount {
            let pieceGroup = ListFactory_GroupsA.pieceGroupList[pieceGroupIndex]
            for piece in pieceGroup.smallestList {
                let node = piece.node!
                ListFactory_UniqueA.intake(node: node)
            }
        }
        
        if SmartLayoutFlooder.attemptToFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(uniqueNodeList: ListFactory_UniqueA.nodeList,
                                                                                          uniqueNodeListCount: ListFactory_UniqueA.nodeListCount) {
            result = true
        }
        
        for pieceGroupIndex in 0..<ListFactory_GroupsA.pieceGroupListCount {
            let pieceGroup = ListFactory_GroupsA.pieceGroupList[pieceGroupIndex]
            
            if pieceGroup.smallestList.count == 0 { fatalError("TODO: Expecting smallest groups here...") }
            
            if SmartLayoutUtilities.canAllPiecesGrowByOne_WithoutGrowingNodes(pieces: pieceGroup.smallestList,
                                                                              pieceCount: pieceGroup.smallestList.count) {
                SmartLayoutUtilities.growAllPiecesByOne_Unsafe(pieces: pieceGroup.smallestList,
                                                               pieceCount: pieceGroup.smallestList.count)
                result = true
            }
        }
        return result
    }
    
    static func step_c_apply_flexers() -> Bool {
        var result = false
        
        ListFactory_GroupsA.tempFlexerGroupListReset()
        
        //
        // We make a decision in this loop.
        // A.) Add to ListFactory_GroupsA.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
        // B.) Do not add to ListFactory_GroupsA.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
        //
        for flexerGroupIndex in 0..<ListFactory_GroupsA.flexerGroupListCount {
            let flexerGroup = ListFactory_GroupsA.flexerGroupList[flexerGroupIndex]
            
            if flexerGroup.linkedList.count <= 0 {
                fatalError("We cannot have flexer groups of 0. TODO: Remove this check.")
            }
            
            
            
            if (flexerGroup.isMono == true) || (flexerGroup.isActiveAtCurrentPriority == false) {
                
                flexerGroup.smallestList.removeAll(keepingCapacity: true)
                
                if SmartLayoutUtilities.isAnyFlexerPossiblyAbleToGrowAtCurrentPriority(flexers: flexerGroup.linkedList,
                                                                                       flexerCount: flexerGroup.linkedList.count) {
                    ListFactory_GroupsA.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
                } else {
                    flexerGroup.isLockedAtCurrentPriority = true
                }
            } else {
                
                if flexerGroup.computeSmallestIfNotAllEqual() {
                    if SmartLayoutUtilities
                        .isEveryFlexerPossiblyAbleToGrowAtCurrentPriority_AllSameSize_SmallestListOnly(flexers: flexerGroup.smallestList,
                                                                                                       flexerCount: flexerGroup.smallestList.count) {
                        ListFactory_GroupsA.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
                    } else {
                        flexerGroup.isLockedAtCurrentPriority = true
                    }
                } else {
                    
                    flexerGroup.smallestList.removeAll(keepingCapacity: true)
                    
                    // Are they all equal?
                    if SmartLayoutUtilities.isEveryFlexerTheSameSize(flexers: flexerGroup.linkedList,
                                                                     flexerCount: flexerGroup.linkedList.count) {
                        if SmartLayoutUtilities.isEveryFlexerBelowTargetSizeCurrentPriority(flexers: flexerGroup.linkedList,
                                                                                            flexerCount: flexerGroup.linkedList.count) {
                            // Might they all be able to grow?
                            if SmartLayoutUtilities.isAnyFlexerPossiblyAbleToGrowAtCurrentPriority(flexers: flexerGroup.linkedList,
                                                                                                   flexerCount: flexerGroup.linkedList.count) {
                                ListFactory_GroupsA.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
                            } else {
                                flexerGroup.isLockedAtCurrentPriority = true
                            }
                        }
                    }
                }
            }
        }
        
        ListFactory_GroupsA.flexerGroupListSwap()
        
        for flexerGroupIndex in 0..<ListFactory_GroupsA.flexerGroupListCount {
            let flexerGroup = ListFactory_GroupsA.flexerGroupList[flexerGroupIndex]
            for flexer in flexerGroup.linkedList {
                let node = flexer.node!
                node.requestedGrowthFromChildrenMax = 0
                node.requestedGrowthFromChildrenMin = Int.max
            }
        }
        
        
        for flexerGroupIndex in 0..<ListFactory_GroupsA.flexerGroupListCount {
            let flexerGroup = ListFactory_GroupsA.flexerGroupList[flexerGroupIndex]
            
            // This isn't the full logic.
            // It would be like...
            // Clipping to smallest...
            
            
            if flexerGroup.linkedList.count > 0 {
                
                if (flexerGroup.isActiveAtCurrentPriority) {
                    var lowestTargetSizeCurrentPriority = flexerGroup.linkedList[0].targetSizeCurrentPriority
                    for flexer in flexerGroup.linkedList {
                        if flexer.targetSizeCurrentPriority < lowestTargetSizeCurrentPriority {
                            lowestTargetSizeCurrentPriority = flexer.targetSizeCurrentPriority
                        }
                    }
                    var isEveryFlexerBelowLowestTarget: Bool = true
                    for flexer in flexerGroup.linkedList {
                        if flexer.currentSize > lowestTargetSizeCurrentPriority {
                            isEveryFlexerBelowLowestTarget = false
                            break
                        }
                    }
                    
                    if isEveryFlexerBelowLowestTarget {
                        for flexer in flexerGroup.linkedList {
                            let node = flexer.node!
                            node.didChildRequestGrowthOnCurrentPass = true
                        }
                    } else if flexerGroup.smallestList.count > 0 {
                        for flexer in flexerGroup.smallestList {
                            let node = flexer.node!
                            node.didChildRequestGrowthOnCurrentPass = true
                        }
                    }
                    
                } else {
                    for flexer in flexerGroup.linkedList {
                        if flexer.currentSize < flexer.targetSizeCurrentPriority {
                            let node = flexer.node!
                            node.didChildRequestGrowthOnCurrentPass = true
                        }
                    }
                }
            }
            
            if flexerGroup.smallestList.count <= 0 {
                
                ListFactory_UniqueA.resetNodeList()
                for flexer in flexerGroup.linkedList {
                    let node = flexer.node!
                    ListFactory_UniqueA.intake(node: node)
                }
                
                for nodeIndex in 0..<ListFactory_UniqueA.nodeListCount {
                    let node = ListFactory_UniqueA.nodeList[nodeIndex]
                    node.requestedGrowthFromChildren = 0
                }
                
                if flexerGroup.isActiveAtCurrentPriority == false {
                    
                    // Flexer group is not active...
                    for flexer in flexerGroup.linkedList {
                        let node = flexer.node!
                        if flexer.currentSize < flexer.targetSizeCurrentPriority {
                            node.requestedGrowthFromChildren += 1
                        }
                    }
                } else {
                    
                    // Flexer group is active...
                    if SmartLayoutUtilities.isEveryFlexerTryingToGrowAtCurrentPriority_AndNoNodesAreLocked(flexers: flexerGroup.linkedList,
                                                                                                           flexerCount: flexerGroup.linkedList.count) {
                        for flexer in flexerGroup.linkedList {
                            let node = flexer.node!
                            node.requestedGrowthFromChildren += 1
                        }
                    } else {
                        flexerGroup.isLockedAtCurrentPriority = true
                    }
                }
            } else { // smallest list > 0
                
                
                ListFactory_UniqueA.resetNodeList()
                for flexer in flexerGroup.smallestList {
                    let node = flexer.node!
                    ListFactory_UniqueA.intake(node: node)
                }
                
                for nodeIndex in 0..<ListFactory_UniqueA.nodeListCount {
                    let node = ListFactory_UniqueA.nodeList[nodeIndex]
                    node.requestedGrowthFromChildren = 0
                }
                
                if SmartLayoutUtilities.isEveryFlexerWhereNoNodesAreUnlocked(flexers: flexerGroup.smallestList,
                                                                           flexerCount: flexerGroup.smallestList.count) {
                    
                    
                    
                    // It seems like what we really want to do here is...
                    // Grow with smallest OR others who are also trying to grow...
                    // Only If, they are all trying to grow?
                    //let smallestSize = flexerGroup.smallestList[0].currentSize
                    
                    
                    for flexer in flexerGroup.smallestList {
                        let node = flexer.node!
                        node.requestedGrowthFromChildren += 1
                    }
                    
                    ListFactory_GroupsA.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
                } else {
                    flexerGroup.isLockedAtCurrentPriority = true
                }
                
            }
            
            
            for nodeIndex in 0..<ListFactory_UniqueA.nodeListCount {
                let node = ListFactory_UniqueA.nodeList[nodeIndex]
                if node.requestedGrowthFromChildren > 0 {
                    //node.didChildRequestGrowthOnCurrentPass = true
                    node.requestedGrowthFromChildrenMax += node.requestedGrowthFromChildren
                    if node.requestedGrowthFromChildren < node.requestedGrowthFromChildrenMin {
                        node.requestedGrowthFromChildrenMin = node.requestedGrowthFromChildren
                    }
                }
            }
        }
        
        ListFactory_UniqueA.resetNodeList()
        for flexerGroupIndex in 0..<ListFactory_GroupsA.flexerGroupListCount {
            let flexerGroup = ListFactory_GroupsA.flexerGroupList[flexerGroupIndex]
            for flexer in flexerGroup.linkedList {
                let node = flexer.node!
                ListFactory_UniqueA.intake(node: node)
            }
        }
        
        if ListFactory_UniqueA.nodeListCount > 0 {
            if SmartLayoutFlooder.attemptToFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(uniqueNodeList: ListFactory_UniqueA.nodeList,
                                                                                                    uniqueNodeListCount: ListFactory_UniqueA.nodeListCount) {
                result = true
            }
        }
        
        for flexerGroupIndex in 0..<ListFactory_GroupsA.flexerGroupListCount {
            let flexerGroup = ListFactory_GroupsA.flexerGroupList[flexerGroupIndex]
            
            if flexerGroup.smallestList.count > 0 {
                
                if SmartLayoutUtilities.canAllFlexersGrowByOne_WithoutGrowingNodes_ActiveSmallestList(flexers: flexerGroup.smallestList,
                                                                                                      flexerCount: flexerGroup.smallestList.count) {
                    SmartLayoutUtilities.growAllFlexersByOne_Unsafe_ActiveSmallestList(flexers: flexerGroup.smallestList,
                                                                                       flexerCount: flexerGroup.smallestList.count)
                    result = true
                }
                
            } else {
                if (flexerGroup.isMono == true) || (flexerGroup.isActiveAtCurrentPriority == false) {
                    
                    for flexer in flexerGroup.linkedList {
                        if SmartLayoutUtilities.canOneFlexersGrowByOne_WithoutGrowingNodes(flexer: flexer) {
                            SmartLayoutUtilities.growFlexerByOne_Unsafe(flexer: flexer)
                            result = true
                        }
                        
                    }
                    
                    /*
                    if SmartLayoutUtilities.canAllFlexersGrowByOne_WithoutGrowingNodes_InactiveGroupOrMono(flexers: flexerGroup.linkedList,
                                                                                                           flexerCount: flexerGroup.linkedList.count) {
                        SmartLayoutUtilities.growAllFlexersByOne_Unsafe_InactiveGroupOrMono(flexers: flexerGroup.linkedList,
                                                                                            flexerCount: flexerGroup.linkedList.count)
                        
                    }
                    */
                    
                } else {
                    
                    if SmartLayoutUtilities.canAllFlexersGrowByOne_WithoutGrowingNodes_ActiveAllEqual(flexers: flexerGroup.linkedList,
                                                                                                      flexerCount: flexerGroup.linkedList.count) {
                        SmartLayoutUtilities.growAllFlexersByOne_Unsafe_InactiveGroupOrMono(flexers: flexerGroup.linkedList,
                                                                                            flexerCount: flexerGroup.linkedList.count)
                        result = true
                    }
                }
            }
        }
        return result
    }
    
    static func step_d_node_ubiquitous_growth() -> Bool {
        
        var result = false
        for nodeGroupIndex in 0..<ListFactory_GroupsA.nodeGroupListCount {
            let nodeGroup = ListFactory_GroupsA.nodeGroupList[nodeGroupIndex]
            
            if !nodeGroup.isActiveAtCurrentPriority { fatalError("TODO: This should be active!") }
            
            //var isUbiquitousGrowthCandidate = true
            var isEqualSized = true
            var didAnyNodeGrowOnCurrentPass = false
            var didEveryChildRequestGrowthOnCurrentPass = true
            
            if nodeGroup.linkedList.count > 0 {
                
                let expectedSize = nodeGroup.linkedList[0].currentSize
                
                for node in nodeGroup.linkedList {
                    if node.currentSize != expectedSize {
                        isEqualSized = false
                        break
                    }
                    if node.didChildRequestGrowthOnCurrentPass == false {
                        didEveryChildRequestGrowthOnCurrentPass = false
                    }
                    if node.didGrowOnCurrentPass == true {
                        didAnyNodeGrowOnCurrentPass = true
                        break
                    }
                }
                
            }
            
            //print("isUbiquitousGrowthCandidate = \(isUbiquitousGrowthCandidate), siz was \(nodeGroup.linkedList[0].currentSize)")
            
            if isEqualSized == true &&
                didEveryChildRequestGrowthOnCurrentPass == true &&
                didAnyNodeGrowOnCurrentPass == false {
                
                if SmartLayoutFlooder.attemptToFloodNodeGroupByOne_AllEqualSize(nodeGroup: nodeGroup) {
                    
                    result = true
                }
            }
        }
        return result
    }
}
