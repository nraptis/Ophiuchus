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
    //
    // Each node will is trying to grow by "requestedGrowthFromChildren"
    // The groups will be visited from left to right, and grown as such...
    //
    static func attemptToFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(uniqueNodeList: [WiseLayoutNode],
                                                                                  uniqueNodeListCount: Int) -> Bool {
        var result = false
        ListFactory_GroupsUniqueB.resetNodeGroupList()
        ListFactory_BasicNodes.resetNodeList()
        for nodeIndex in 0..<uniqueNodeListCount {
            let node = uniqueNodeList[nodeIndex]
            let nodeGroup = node.group!
            
            if nodeGroup.isMono {
                ListFactory_BasicNodes.intake(node: node)
            } else {
                if nodeGroup.isActiveAtCurrentPriority {
                    ListFactory_GroupsUniqueB.intake(nodeGroup: nodeGroup)
                } else {
                    ListFactory_BasicNodes.intake(node: node)
                }
            }
        }
        
        if SmartLayoutFlooder
            .attemptToFloodNodeGroupsByRequestedGrowthMinMaxFromChildren(nodeGroups: ListFactory_GroupsUniqueB.nodeGroupList,
                                                                         nodeGroupCount: ListFactory_GroupsUniqueB.nodeGroupListCount) {
            result = true
        }
        
        for nodeIndex in 0..<ListFactory_BasicNodes.nodeListCount {
            let node = ListFactory_BasicNodes.nodeList[nodeIndex]
            if SmartLayoutFlooder.attemptToFloodOneNodeByRequestedGrowthMinMaxFromChildren_WithoutConsideringGroup(node: node) {
                result = true
            }
        }
        return result
    }
    
    
    static func attemptToFloodNodeGroupsByRequestedGrowthMinMaxFromChildren(nodeGroups: [ExploderGroup<WiseLayoutNode>],
                                                                            nodeGroupCount: Int) -> Bool {
        
        for nodeGroup in nodeGroups {
            if nodeGroup.isMono == true {
                fatalError("TODO: These groups are all not expected to be mono...")
            }
            if nodeGroup.isActiveAtCurrentPriority == false {
                fatalError("TODO: These groups are all expected to be active...")
            }
        }
        
        var result = false
        
        for nodeGroupIndex in 0..<nodeGroupCount {
            let nodeGroup = nodeGroups[nodeGroupIndex]
            
            var smallestCurrentSize = Int.max
            for node in nodeGroup.linkedList {
                if node.currentSize < smallestCurrentSize {
                    smallestCurrentSize = node.currentSize
                }
            }
            
            var smallestMaxBubble = Int.max
            for node in nodeGroup.linkedList {
                let gap = (node.currentSize - node.childrenSize)
                node.gap = gap
                if gap < 0 { fatalError("TODO: Should not be possible.") }
                
                var bubbleMax = node.requestedGrowthFromChildrenMax - gap
                if bubbleMax < 0 { bubbleMax = 0 }
                bubbleMax += node.currentSize
                if bubbleMax < smallestMaxBubble {
                    smallestMaxBubble = bubbleMax
                }
                
            }
            
            if (smallestCurrentSize < 100_000_000) && (smallestMaxBubble < 100_000_000) {
                
                if smallestCurrentSize > smallestMaxBubble {
                    fatalError("TODO: SHould be impossib;e?")
                }
                
                var best: Int?
                var lo = smallestCurrentSize
                var hi = smallestMaxBubble
                
                while lo <= hi {
                    let mid = (lo + hi) >> 1
                    
                    // Ok, so now we try to grow each one to the specified value...
                    for node in nodeGroup.linkedList {
                        let section = node.section!
                        section.proposedGrowthAmount = 0
                    }
                    
                    for node in nodeGroup.linkedList {
                        let section = node.section!
                        //var grow = mid - node.currentSize - node.gap
                        let grow = mid - node.currentSize
                        if grow > 0 {
                            section.proposedGrowthAmount += grow
                        }
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
                            let grow = best - node.currentSize// - node.gap
                            
                            if grow > 0 {
                                SmartLayoutUtilities.growNodeByAmount_Unsafe(node: node, amount: grow)
                                result = true
                            }
                        }
                    }
                }
            }
        }
        return result
    }
    
    static func attemptToFloodOneNodeByRequestedGrowthMinMaxFromChildren_WithoutConsideringGroup(node: WiseLayoutNode) -> Bool {
        var result = false
        
        
        if node.requestedGrowthFromChildrenMin <= node.requestedGrowthFromChildrenMax {
            let gap = (node.currentSize - node.childrenSize)
            
            //TODO:
            if gap < 0 { fatalError("TODO: Should not be possible here") }
            
            
            let section = node.section!
            let row = node.row!
            var lo = node.requestedGrowthFromChildrenMin
            var hi = node.requestedGrowthFromChildrenMax
            var best: Int?
            while lo <= hi {
                let mid = (lo + hi) >> 1
                var amount = mid - gap
                if amount < 0 {
                    amount = 0
                }
                if row.canGrowSection(section: section, amount: amount) {
                    best = mid
                    lo = mid + 1
                } else {
                    hi = mid - 1
                }
            }
            
            if let best = best {
                let amount = best - gap
                if amount > 0 {
                    SmartLayoutUtilities.growNodeByAmount_Unsafe(node: node, amount: amount)
                    result = true
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
                result = true
            } else {
                var amount = amount
                if gap > 0 {
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
    
    static func attemptToFloodNodeGroupByOne_AllEqualSize(nodeGroup: ExploderGroup<WiseLayoutNode>) -> Bool {
        
        if true {
            if nodeGroup.isActiveAtCurrentPriority == false {
                fatalError("These groups are all expected to be active...")
            }
            if nodeGroup.linkedList.count <= 0 {
                fatalError("These groups are all expected to be > 0")
            }
            let size = nodeGroup.linkedList[0].currentSize
            for node in nodeGroup.linkedList {
                if node.currentSize != size {
                    fatalError("TODO: An error, all nodes not same size in this case! BAD!")
                }
            }
        }
        
        var result = false
        if nodeGroup.linkedList.count > 0 {
            for node in nodeGroup.linkedList {
                let section = node.section!
                section.proposedGrowthAmount = 0
            }
            for node in nodeGroup.linkedList {
                let section = node.section!
                section.proposedGrowthAmount += 1
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
                result = true
                for node in nodeGroup.linkedList {
                    SmartLayoutUtilities.growNodeByOne_Unsafe(node: node)
                }
            }
        }
        
        return result
    }
    
}
