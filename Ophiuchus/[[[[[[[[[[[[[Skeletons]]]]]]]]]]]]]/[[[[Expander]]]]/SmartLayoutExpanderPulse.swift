//
//  SmartLayoutExpanderPulse.swift
//  Ophiuchus
//
//  Created by Nick on 8/11/25.
//

import Foundation

struct SmartLayoutExpanderPulse {
    
    
    // This function is done, do not change.
    static func step_a_apply_node_group_rules() -> Bool {
        
        var result = false
        ListFactory_Groups.tempNodeGroupListReset()
        
        for nodeGroupIndex in 0..<ListFactory_Groups.nodeGroupListCount {
            let nodeGroup = ListFactory_Groups.nodeGroupList[nodeGroupIndex]
            if nodeGroup.isLockedAtCurrentPriority { continue }
            if nodeGroup.isLockedAtEveryPriority { continue }
            if (nodeGroup.isActiveAtCurrentPriority == false) {
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
                    ListFactory_Groups.tempNodeGroupListAdd(tempNodeGroup: nodeGroup)
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
            if pieceGroup.isLockedAtCurrentPriority { continue }
            if pieceGroup.isLockedAtEveryPriority { continue }
            if (pieceGroup.isActiveAtCurrentPriority == false) {
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
        
        print("temps:")
        for pieceGroupIndex in 0..<ListFactory_Groups.tempPieceGroupListCount {
            let pieceGroup = ListFactory_Groups.tempPieceGroupList[pieceGroupIndex]
            print("TPG[\(pieceGroupIndex)] = \(pieceGroup.id)")
        }
        
        ListFactory_Groups.pieceGroupListSwap()
        print("regs, after swap:")
        for pieceGroupIndex in 0..<ListFactory_Groups.pieceGroupListCount {
            let pieceGroup = ListFactory_Groups.pieceGroupList[pieceGroupIndex]
            print("RPG[\(pieceGroupIndex)] = \(pieceGroup.id)")
        }
        
        
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
            
            /*
            for piece in pieceGroup.linkedList {
                let node = piece.node!
                ListFactory_Unique.intake(node: node)
            }
            */
        }
        
        //ListFactory_
        
        
        // From here, 
        
        /*
        for pieceGroupIndex in 0..<ListFactory_Groups.pieceGroupListCount {
            let pieceGroup = ListFactory_Groups.pieceGroupList[pieceGroupIndex]
            for piece in pieceGroup.smallestList {
                let node = piece.node!
                print("Node \(node.id) form \(pieceGroup.id), growMax = \(node.requestedGrowthFromChildren)")
            }
        }
        
        
        for pieceGroupIndex in 0..<ListFactory_Groups.pieceGroupListCount {
            let pieceGroup = ListFactory_Groups.pieceGroupList[pieceGroupIndex]
            for piece in pieceGroup.smallestList {
                let node = piece.node!
                print("Node \(node.id) form \(pieceGroup.id), growMax = \(node.requestedGrowthFromChildren)")
            }
            
        }
        */
        
        
        ListFactory_Groups.nodeGroupListReset()
        for nodeIndex in 0..<ListFactory_Unique.nodeListCount {
            let node = ListFactory_Unique.nodeList[nodeIndex]
            let nodeGroup = node.group!
            ListFactory_GroupsUnique.intake(nodeGroup: nodeGroup,
                                            node: node)
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
    
    
}
