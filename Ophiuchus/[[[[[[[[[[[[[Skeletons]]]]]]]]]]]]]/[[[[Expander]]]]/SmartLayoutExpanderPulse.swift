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
        if step_a_apply_node_group_rules() { result = true }
        if step_b_apply_piece_group_rules() { result = true }
        if step_c_apply_flexers() { result = true }
        return result
    }
    
    // This function is done, do not change.
    static func step_a_apply_node_group_rules() -> Bool {
        
        var result = false
        ListFactory_Groups.tempNodeGroupListReset()
        
        for nodeGroupIndex in 0..<ListFactory_Groups.nodeGroupListCount {
            let nodeGroup = ListFactory_Groups.nodeGroupList[nodeGroupIndex]
            if nodeGroup.isLockedAtCurrentPriority { continue }
            if nodeGroup.isLockedAtEveryPriority { continue }
            if (nodeGroup.isActiveAtCurrentPriorityOrMono == false) {
                // We are not an active rule.
                continue
            }
            
            if nodeGroup.computeSmallestIfNotAllEqual() {
                // These nodes all want to grow by 1.
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
                    ListFactory_Groups.tempNodeGroupListAdd(nodeGroup: nodeGroup)
                } else {
                    nodeGroup.isLockedAtEveryPriority = true
                    continue
                }
            }
        }
        ListFactory_Groups.nodeGroupListSwap()
        return result
    }
    
    static func step_b_apply_piece_group_rules() -> Bool {
        
        var result = false
        
        ListFactory_Groups.tempPieceGroupListReset()
        
        for pieceGroupIndex in 0..<ListFactory_Groups.pieceGroupListCount {
            let pieceGroup = ListFactory_Groups.pieceGroupList[pieceGroupIndex]
            if pieceGroup.isLockedAtCurrentPriority || pieceGroup.isLockedAtEveryPriority {
                continue
            }
            
            if (pieceGroup.isActiveAtCurrentPriorityOrMono == false) {
                // We are not an active rule.
                continue
            }
            
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
                    ListFactory_Groups.tempPieceGroupListAdd(pieceGroup: pieceGroup)
                } else {
                    pieceGroup.isLockedAtCurrentPriority = true
                    continue
                }
                
            }
        }
        
        ListFactory_Groups.pieceGroupListSwap()
        
        for pieceGroupIndex in 0..<ListFactory_Groups.pieceGroupListCount {
            let pieceGroup = ListFactory_Groups.pieceGroupList[pieceGroupIndex]
            for piece in pieceGroup.linkedList {
                let node = piece.node!
                node.temp = 0 // Temp is "max requested growth"
                node.requestedGrowthFromChildren = 0
            }
        }
        
        
        for pieceGroupIndex in 0..<ListFactory_Groups.pieceGroupListCount {
            let pieceGroup = ListFactory_Groups.pieceGroupList[pieceGroupIndex]
            
            if pieceGroup.smallestList.count <= 0 {
                fatalError("These should all have a smallest group")
            }
            
            for piece in pieceGroup.smallestList {
                let node = piece.node!
                node.requestedGrowthFromChildren += 1
            }
            
            for piece in pieceGroup.smallestList {
                let node = piece.node!
                if node.requestedGrowthFromChildren > node.temp {
                    node.temp = node.requestedGrowthFromChildren
                }
            }
        }
        
        for pieceGroupIndex in 0..<ListFactory_Groups.pieceGroupListCount {
            let pieceGroup = ListFactory_Groups.pieceGroupList[pieceGroupIndex]
            for piece in pieceGroup.smallestList {
                let node = piece.node!
                node.requestedGrowthFromChildren = node.temp
            }
        }
        
        ListFactory_Unique.resetNodeList()
        for pieceGroupIndex in 0..<ListFactory_Groups.pieceGroupListCount {
            let pieceGroup = ListFactory_Groups.pieceGroupList[pieceGroupIndex]
            for piece in pieceGroup.smallestList {
                let node = piece.node!
                ListFactory_Unique.intake(node: node)
            }
        }
        
        ListFactory_Groups.nodeGroupListReset()
        for nodeIndex in 0..<ListFactory_Unique.nodeListCount {
            let node = ListFactory_Unique.nodeList[nodeIndex]
            let nodeGroup = node.group!
            ListFactory_GroupsUnique.intake(nodeGroup: nodeGroup)
        }
        
        if SmartLayoutFlooder.attemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(uniqueNodeList: ListFactory_Unique.nodeList,
                                                                                          uniqueNodeListCount: ListFactory_Unique.nodeListCount) {
            result = true
        }
        
        for pieceGroupIndex in 0..<ListFactory_Groups.pieceGroupListCount {
            let pieceGroup = ListFactory_Groups.pieceGroupList[pieceGroupIndex]
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
    
    /*
     static func step_c_apply_flexer_group_rules_inactive_or_mono() -> Bool {
     var result = false
     
     ListFactory_Groups.tempFlexerGroupListReset()
     
     //
     // We make a decision in this loop.
     // A.) Add to ListFactory_Groups.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
     // B.) Do not add to ListFactory_Groups.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
     //
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     
     if flexerGroup.linkedList.count <= 0 {
     fatalError("We cannot have flexer groups of 0. TODO: Remove this check.")
     }
     
     if flexerGroup.isActiveAtCurrentPriorityOrMono == true {
     if SmartLayoutUtilities.isAnyFlexerPossiblyAbleToGrowAtCurrentPriority(flexers: flexerGroup.linkedList,
     flexerCount: flexerGroup.linkedList.count) {
     ListFactory_Groups.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
     } else {
     flexerGroup.isLockedAtCurrentPriority = true
     }
     }
     }
     
     ListFactory_Groups.flexerGroupListSwap()
     
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     for flexer in flexerGroup.linkedList {
     let node = flexer.node!
     node.temp = 0 // Temp is "max requested growth"
     node.requestedGrowthFromChildren = 0
     }
     }
     
     
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     
     if flexerGroup.isActiveAtCurrentPriorityOrMono == false {
     fatalError("These should all have a isActiveAtCurrentPriorityOrMono = true")
     }
     
     for flexer in flexerGroup.linkedList {
     if flexer.currentSize < flexer.targetSizeCurrentPriority {
     let node = flexer.node!
     node.requestedGrowthFromChildren += 1
     }
     }
     
     for flexer in flexerGroup.linkedList {
     let node = flexer.node!
     if node.requestedGrowthFromChildren > node.temp {
     node.temp = node.requestedGrowthFromChildren
     }
     }
     }
     
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     for flexer in flexerGroup.linkedList {
     let node = flexer.node!
     node.requestedGrowthFromChildren = node.temp
     }
     }
     
     ListFactory_Unique.resetNodeList()
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     for flexer in flexerGroup.linkedList {
     let node = flexer.node!
     ListFactory_Unique.intake(node: node)
     }
     }
     
     ListFactory_Groups.nodeGroupListReset()
     for nodeIndex in 0..<ListFactory_Unique.nodeListCount {
     let node = ListFactory_Unique.nodeList[nodeIndex]
     let nodeGroup = node.group!
     ListFactory_GroupsUnique.intake(nodeGroup: nodeGroup)
     }
     
     if SmartLayoutFlooder.attemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(uniqueNodeList: ListFactory_Unique.nodeList,
     uniqueNodeListCount: ListFactory_Unique.nodeListCount) {
     result = true
     }
     
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     if SmartLayoutUtilities.canAllFlexersGrowByOne_WithoutGrowingNodes_InactiveGroupOrMono(flexers: flexerGroup.linkedList,
     flexerCount: flexerGroup.linkedList.count) {
     SmartLayoutUtilities.growAllFlexersByOne_Unsafe_InactiveGroupOrMono(flexers: flexerGroup.linkedList,
     flexerCount: flexerGroup.linkedList.count)
     result = true
     }
     }
     return result
     }
     
     static func step_d_apply_flexer_group_rules_active_multi() -> Bool {
     
     var result = false
     
     ListFactory_Groups.tempFlexerGroupListReset()
     
     //
     // We make a decision in this loop.
     // A.) Add to ListFactory_Groups.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
     // B.) Do not add to ListFactory_Groups.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
     //
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     
     if flexerGroup.linkedList.count <= 0 {
     fatalError("We cannot have flexer groups of 0. TODO: Remove this check.")
     }
     
     if flexerGroup.isActiveAtCurrentPriorityOrMono == true {
     if flexerGroup.computeSmallestIfNotAllEqual() {
     if SmartLayoutUtilities
     .isEveryFlexerPossiblyAbleToGrowAtCurrentPriority_AllSameSize_SmallestListOnly(flexers: flexerGroup.smallestList,
     flexerCount: flexerGroup.smallestList.count) {
     ListFactory_Groups.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
     } else {
     flexerGroup.isLockedAtCurrentPriority = true
     }
     }
     }
     }
     
     ListFactory_Groups.flexerGroupListSwap()
     
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     for flexer in flexerGroup.linkedList {
     let node = flexer.node!
     node.temp = 0 // Temp is "max requested growth"
     node.requestedGrowthFromChildren = 0
     }
     }
     
     
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     
     if flexerGroup.isActiveAtCurrentPriorityOrMono == false {
     fatalError("These should all have a isActiveAtCurrentPriorityOrMono = true")
     }
     
     if flexerGroup.smallestList.count <= 0 {
     fatalError("These should all have a smallestList populated.")
     }
     
     
     for flexer in flexerGroup.smallestList {
     
     let node = flexer.node!
     node.requestedGrowthFromChildren += 1
     
     }
     
     for flexer in flexerGroup.smallestList {
     let node = flexer.node!
     
     node.temp = node.requestedGrowthFromChildren
     
     }
     }
     
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     for flexer in flexerGroup.smallestList {
     let node = flexer.node!
     node.requestedGrowthFromChildren = node.temp
     }
     }
     
     ListFactory_Unique.resetNodeList()
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     for flexer in flexerGroup.smallestList {
     let node = flexer.node!
     ListFactory_Unique.intake(node: node)
     }
     }
     
     ListFactory_Groups.nodeGroupListReset()
     for nodeIndex in 0..<ListFactory_Unique.nodeListCount {
     let node = ListFactory_Unique.nodeList[nodeIndex]
     let nodeGroup = node.group!
     ListFactory_GroupsUnique.intake(nodeGroup: nodeGroup)
     }
     
     if SmartLayoutFlooder.attemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(uniqueNodeList: ListFactory_Unique.nodeList,
     uniqueNodeListCount: ListFactory_Unique.nodeListCount) {
     result = true
     }
     
     for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
     let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
     if SmartLayoutUtilities.canAllFlexersGrowByOne_WithoutGrowingNodes_ActiveSmallestList(flexers: flexerGroup.smallestList,
     flexerCount: flexerGroup.smallestList.count) {
     SmartLayoutUtilities.growAllFlexersByOne_Unsafe_ActiveSmallestList(flexers: flexerGroup.smallestList,
     flexerCount: flexerGroup.smallestList.count)
     result = true
     }
     }
     return result
     }
     */
    
    static func step_c_apply_flexers() -> Bool {
        var result = false
        
        ListFactory_Groups.tempFlexerGroupListReset()
        
        //
        // We make a decision in this loop.
        // A.) Add to ListFactory_Groups.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
        // B.) Do not add to ListFactory_Groups.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
        //
        for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
            let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
            
            if flexerGroup.linkedList.count <= 0 {
                fatalError("We cannot have flexer groups of 0. TODO: Remove this check.")
            }
            
            if flexerGroup.isInactiveAtCurrentPriorityOrMono {
                if SmartLayoutUtilities.isAnyFlexerPossiblyAbleToGrowAtCurrentPriority(flexers: flexerGroup.linkedList,
                                                                                       flexerCount: flexerGroup.linkedList.count) {
                    ListFactory_Groups.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
                } else {
                    flexerGroup.isLockedAtCurrentPriority = true
                }
            } else {
                
                if flexerGroup.computeSmallestIfNotAllEqual() {
                    if SmartLayoutUtilities
                        .isEveryFlexerPossiblyAbleToGrowAtCurrentPriority_AllSameSize_SmallestListOnly(flexers: flexerGroup.smallestList,
                                                                                                       flexerCount: flexerGroup.smallestList.count) {
                        ListFactory_Groups.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
                    } else {
                        flexerGroup.isLockedAtCurrentPriority = true
                    }
                } else {
                    
                    // Are they all equal?
                    if SmartLayoutUtilities.isEveryFlexerTheSameSize(flexers: flexerGroup.linkedList,
                                                                     flexerCount: flexerGroup.linkedList.count) {
                        if SmartLayoutUtilities.isEveryFlexerBelowTargetSizeCurrentPriority(flexers: flexerGroup.linkedList,
                                                                                            flexerCount: flexerGroup.linkedList.count) {
                            // Might they all be able to grow?
                            if SmartLayoutUtilities.isAnyFlexerPossiblyAbleToGrowAtCurrentPriority(flexers: flexerGroup.linkedList,
                                                                                                   flexerCount: flexerGroup.linkedList.count) {
                                ListFactory_Groups.tempFlexerGroupListAdd(flexerGroup: flexerGroup)
                            } else {
                                flexerGroup.isLockedAtCurrentPriority = true
                            }
                        }
                    }
                }
            }
        }
        
        ListFactory_Groups.flexerGroupListSwap()
        
        for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
            let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
            for flexer in flexerGroup.linkedList {
                let node = flexer.node!
                node.temp = 0 // Temp is "max requested growth"
                node.requestedGrowthFromChildren = 0
            }
        }
        
        
        for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
            let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
            if (flexerGroup.isInactiveAtCurrentPriorityOrMono) || (flexerGroup.smallestList.count == 0) {
                
                for flexer in flexerGroup.linkedList {
                    if flexer.currentSize < flexer.targetSizeCurrentPriority {
                        let node = flexer.node!
                        node.requestedGrowthFromChildren += 1
                    }
                }
                
                for flexer in flexerGroup.linkedList {
                    let node = flexer.node!
                    if node.requestedGrowthFromChildren > node.temp {
                        node.temp = node.requestedGrowthFromChildren
                    }
                }
                
            } else {
                for flexer in flexerGroup.smallestList {
                    let node = flexer.node!
                    node.requestedGrowthFromChildren += 1
                }
                
                for flexer in flexerGroup.smallestList {
                    let node = flexer.node!
                    node.temp = node.requestedGrowthFromChildren
                }
            }
            
            
        }
        
        for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
            let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
            
            if (flexerGroup.isInactiveAtCurrentPriorityOrMono) || (flexerGroup.smallestList.count == 0) {
                for flexer in flexerGroup.linkedList {
                    let node = flexer.node!
                    node.requestedGrowthFromChildren = node.temp
                }
            } else {
                for flexer in flexerGroup.smallestList {
                    let node = flexer.node!
                    node.requestedGrowthFromChildren = node.temp
                }
            }
        }
        
        ListFactory_Unique.resetNodeList()
        for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
            let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
            for flexer in flexerGroup.linkedList {
                let node = flexer.node!
                ListFactory_Unique.intake(node: node)
            }
        }
        
        ListFactory_GroupsUnique.resetNodeGroupList()
        for nodeIndex in 0..<ListFactory_Unique.nodeListCount {
            let node = ListFactory_Unique.nodeList[nodeIndex]
            let nodeGroup = node.group!
            ListFactory_GroupsUnique.intake(nodeGroup: nodeGroup)
        }
        
        if SmartLayoutFlooder.attemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(uniqueNodeList: ListFactory_Unique.nodeList,
                                                                                          uniqueNodeListCount: ListFactory_Unique.nodeListCount) {
            result = true
        }
        
        for flexerGroupIndex in 0..<ListFactory_Groups.flexerGroupListCount {
            let flexerGroup = ListFactory_Groups.flexerGroupList[flexerGroupIndex]
            
            if flexerGroup.isInactiveAtCurrentPriorityOrMono {
                
                if SmartLayoutUtilities.canAllFlexersGrowByOne_WithoutGrowingNodes_InactiveGroupOrMono(flexers: flexerGroup.linkedList,
                                                                                                       flexerCount: flexerGroup.linkedList.count) {
                    SmartLayoutUtilities.growAllFlexersByOne_Unsafe_InactiveGroupOrMono(flexers: flexerGroup.linkedList,
                                                                                        flexerCount: flexerGroup.linkedList.count)
                    result = true
                }
                
            } else {
                
                if flexerGroup.smallestList.count <= 0 {
                    //fatalError("TODO: This smallest list cannot be zero...")
                    // This is the case where all the flexers were equal and able to grow...
                    
                    
                    if SmartLayoutUtilities.canAllFlexersGrowByOne_WithoutGrowingNodes_ActiveAllEqual(flexers: flexerGroup.linkedList,
                                                                                                      flexerCount: flexerGroup.linkedList.count) {
                        SmartLayoutUtilities.growAllFlexersByOne_Unsafe_InactiveGroupOrMono(flexers: flexerGroup.linkedList,
                                                                                            flexerCount: flexerGroup.linkedList.count)
                        result = true
                    }
                    
                } else {
                    
                    if SmartLayoutUtilities.canAllFlexersGrowByOne_WithoutGrowingNodes_ActiveSmallestList(flexers: flexerGroup.smallestList,
                                                                                                          flexerCount: flexerGroup.smallestList.count) {
                        SmartLayoutUtilities.growAllFlexersByOne_Unsafe_ActiveSmallestList(flexers: flexerGroup.smallestList,
                                                                                           flexerCount: flexerGroup.smallestList.count)
                        result = true
                    }
                    
                }
            }
        }
        return result
        
    }
    
}
