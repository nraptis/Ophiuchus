//
//  ListFactory_GroupsUnique.swift
//  Ophiuchus
//
//  Created by Nick on 8/12/25.
//

import Foundation

public struct ListFactory_GroupsUnique {
    
    private static var nodeGroupTable = [Int: Int]()
    private(set) static var nodeGroupList = [ExploderGroup<WiseLayoutNode>]()
    private(set) static var nodeGroupPairedNodeList = [[WiseLayoutNode]]()
    private(set) static var nodeGroupPairedNodeListCounts = [Int]()
    private(set) static var nodeGroupPairedNodeListSizes = [Int]()
    private(set) static var nodeGroupPairedTable = [Set<Int>]()
    
    private(set) static var nodeGroupListCount = 0
    private(set) static var nodeGroupListSize = 0

    static func resetNodeGroupList() {
        nodeGroupListCount = 0
        nodeGroupTable.removeAll(keepingCapacity: true)
    }
    
    private static func intakeNodeGroupPairedNode(index: Int, node: WiseLayoutNode) {
        
        if nodeGroupPairedTable[index].contains(node.id) {
            return
        }
        
        nodeGroupPairedTable[index].insert(node.id)
        
        if nodeGroupPairedNodeListCounts[index] >= nodeGroupPairedNodeListSizes[index] {
            let newSize = (nodeGroupPairedNodeListCounts[index] + nodeGroupPairedNodeListCounts[index] / 2 + 1)
            while nodeGroupPairedNodeList[index].count < newSize {
                nodeGroupPairedNodeList[index].append(node)
            }
            nodeGroupPairedNodeListSizes[index] = newSize
        }
        
        nodeGroupPairedNodeList[index][nodeGroupPairedNodeListCounts[index]] = node
        nodeGroupPairedNodeListCounts[index] += 1
    }
    
    static func intake(nodeGroup: ExploderGroup<WiseLayoutNode>,
                       node: WiseLayoutNode) {
        
        let id = nodeGroup.id
        
        if let nodeGroupIndex = nodeGroupTable[nodeGroup.id] {
            intakeNodeGroupPairedNode(index: nodeGroupIndex, node: node)
            return
        }
        
        let nodeGroupIndex = nodeGroupListCount
        nodeGroupTable[id] = nodeGroupListCount
        
        if nodeGroupListCount >= nodeGroupListSize {
            nodeGroupListSize = (nodeGroupListCount + (nodeGroupListCount / 2) + 1)
            while nodeGroupList.count < nodeGroupListSize {
                nodeGroupList.append(nodeGroup)
                nodeGroupPairedNodeList.append([WiseLayoutNode]())
                nodeGroupPairedNodeListCounts.append(0)
                nodeGroupPairedNodeListSizes.append(0)
                nodeGroupPairedTable.append(Set<Int>())
            }
        }
        
        nodeGroupList[nodeGroupListCount] = nodeGroup
        nodeGroupPairedNodeListCounts[nodeGroupListCount] = 0
        nodeGroupPairedTable[nodeGroupListCount].removeAll(keepingCapacity: true)
        
        nodeGroupListCount += 1
        
        intakeNodeGroupPairedNode(index: nodeGroupIndex, node: node)
    }
    
    static func intake(nodeGroup: ExploderGroup<WiseLayoutNode>) {
        
        let id = nodeGroup.id
        if let nodeGroupIndex = nodeGroupTable[nodeGroup.id] {
            return
        }
        
        let nodeGroupIndex = nodeGroupListCount
        nodeGroupTable[id] = nodeGroupListCount
        
        if nodeGroupListCount >= nodeGroupListSize {
            nodeGroupListSize = (nodeGroupListCount + (nodeGroupListCount / 2) + 1)
            while nodeGroupList.count < nodeGroupListSize {
                nodeGroupList.append(nodeGroup)
                nodeGroupPairedNodeList.append([WiseLayoutNode]())
                nodeGroupPairedNodeListCounts.append(0)
                nodeGroupPairedNodeListSizes.append(0)
                nodeGroupPairedTable.append(Set<Int>())
            }
        }
        
        nodeGroupList[nodeGroupListCount] = nodeGroup
        nodeGroupPairedNodeListCounts[nodeGroupListCount] = 0
        nodeGroupPairedTable[nodeGroupListCount].removeAll(keepingCapacity: true)
        nodeGroupListCount += 1
    }
    
    
}
