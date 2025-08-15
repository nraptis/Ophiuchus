//
//  SmartLayoutFlooder.swift
//  Ophiuchus
//
//  Created by Nick on 8/14/25.
//

import Foundation

struct SmartLayoutFlooder {
    
    //
    // @Precondition: All nodeGroups are active at the current priority.
    // @Precondition: All nodeGroups are unique.
    // @Precondition: pairedNodes[n] contains no duplicates.
    //
    // Each node will is trying to grow by "requestedGrowthFromChildren"
    // The groups will be visited from left to right, and grown as such...
    //
    static func attemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(uniqueNodeList: [WiseLayoutNode],
                                                                            uniqueNodeListCount: Int) -> Bool {
        
        ListFactory_GroupsUnique.resetNodeGroupList()
        for nodeIndex in 0..<uniqueNodeListCount {
            let node = uniqueNodeList[nodeIndex]
            let nodeGroup = node.group!
            
            ListFactory_GroupsUnique.intake(nodeGroup: nodeGroup)
        }
        
        if SmartLayoutFlooder
            .attemptToFloodNodeGroupsByRequestedGrowthFromChildren(nodeGroups: ListFactory_GroupsUnique.nodeGroupList,
                                                                   nodeGroupCount: ListFactory_GroupsUnique.nodeGroupListCount) {
            return true
        } else {
            return false
        }
    }
    
    
    //
    // @Precondition: All nodeGroups are active at the current priority.
    // @Precondition: All nodeGroups are unique.
    // @Precondition: pairedNodes[n] contains no duplicates.
    //
    // Each node will is trying to grow by "requestedGrowthFromChildren"
    // The groups will be visited from left to right, and grown as such...
    //
    static func attemptToFloodNodeGroupsByRequestedGrowthFromChildren(nodeGroups: [ExploderGroup<WiseLayoutNode>],
                                                                      nodeGroupCount: Int) -> Bool {
        
        for nodeGroup in nodeGroups {
            if nodeGroup.isActiveAtCurrentPriorityOrMono == false {
                fatalError("These groups are all expected to be active...")
            }
        }
        
        var result = false

        for nodeGroupIndex in 0..<nodeGroupCount {
            let nodeGroup = nodeGroups[nodeGroupIndex]
            if nodeGroup.linkedList.count > 0 {
                for node in nodeGroup.linkedList {
                    
                    let gap = (node.currentSize - node.childrenSize)
                    var bubble = node.requestedGrowthFromChildren - gap
                    if bubble < 0 { bubble = 0 }
                    bubble += node.currentSize
                    node.bubble = bubble
                }
                var smallestBubble = nodeGroup.linkedList[0].bubble
                var smallestSize = nodeGroup.linkedList[0].currentSize
                
                for node in nodeGroup.linkedList {
                    let bubble = node.bubble
                    if bubble < smallestBubble {
                        smallestBubble = bubble
                    }
                    if node.currentSize < smallestSize {
                        smallestSize = node.currentSize
                    }
                }
                
                var best: Int?
                var lo = smallestSize
                var hi = smallestBubble
                while lo <= hi {
                    let mid = (lo + hi) >> 1
                    
                    // Ok, so now we try to grow each one to the specified value...
                    for node in nodeGroup.linkedList {
                        let section = node.section!
                        section.proposedGrowthAmount = 0
                    }
                    
                    for node in nodeGroup.linkedList {
                        let section = node.section!
                        var grow = mid - node.currentSize
                        if grow < 0 { grow = 0 }
                        section.proposedGrowthAmount += grow
                    }
                    
                    ListFactory_Growth.resetRowList()
                    for node in nodeGroup.linkedList {
                        let section = node.section!
                        let row = section.row!
                        ListFactory_Growth.intake(row: row, section: section)
                    }
                    
                    var isValid = true
                    for rowIndex in 0..<ListFactory_Growth.rowListCount {
                        let row = ListFactory_Growth.rowList[rowIndex]
                        let sections = ListFactory_Growth.rowGroupedSectionsList[rowIndex]
                        let sectionCount = ListFactory_Growth.rowGroupedSectionsListCounts[rowIndex]
                        
                        if !row.canGrowAllSectionsByProposedGrowthAmount(sections: sections, sectionCount: sectionCount) {
                            isValid = false
                            break
                        }
                    }
                    
                    if isValid {
                        best = mid
                        lo = mid + 1
                    } else {
                        hi = mid - 1
                    }
                }
                
                if let best = best {
                    for node in nodeGroup.linkedList {
                        if node.currentSize < best {
                            let grow = (best - node.currentSize)
                            SmartLayoutUtilities.growNodeByAmount_Unsafe(node: node, amount: grow)
                            result = true
                        }
                    }
                }
            }
        }
        
        return result
    }
    
    static func attemptToFloodOneNodeByAmountWithoutConsideringGroup(node: WiseLayoutNode, amount: Int) -> Bool {
        var result = false
        if amount > 0 {
            let gap = (node.currentSize - node.childrenSize)
            if amount <= gap {
                node.childrenSize += amount
                result = true
            } else {
                var amount = amount
                if gap > 0 {
                    node.childrenSize += gap
                    amount -= gap
                    result = true
                }
                
                let section = node.section!
                let row = node.row!
                if row.canGrowSection(section: section, amount: amount) {
                    SmartLayoutUtilities.growNodeByAmount_Unsafe(node: node, amount: amount)
                    result = true
                }
            }
        }
        return result
    }
    
    
}
