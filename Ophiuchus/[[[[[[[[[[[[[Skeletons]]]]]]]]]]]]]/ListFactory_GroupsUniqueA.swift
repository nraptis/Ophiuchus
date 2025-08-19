//
//  ListFactory_GroupsUniqueA.swift
//  Ophiuchus
//
//  Created by Nick on 8/12/25.
//

import Foundation

public struct ListFactory_GroupsUniqueA {
    
    private static var nodeGroupSet = Set<Int>()
    private(set) static var nodeGroupList = [ExploderGroup<WiseLayoutNode>]()
    private(set) static var nodeGroupListCount = 0
    private(set) static var nodeGroupListSize = 0

    static func resetNodeGroupList() {
        nodeGroupListCount = 0
        nodeGroupSet.removeAll(keepingCapacity: true)
    }
    
    static func intake(nodeGroup: ExploderGroup<WiseLayoutNode>) {
        let id = nodeGroup.id
        if nodeGroupSet.contains(id) {
            return
        }
        nodeGroupSet.insert(id)
        if nodeGroupListCount >= nodeGroupListSize {
            nodeGroupListSize = (nodeGroupListCount + (nodeGroupListCount / 2) + 1)
            nodeGroupList.reserveCapacity(nodeGroupListSize)
            while nodeGroupList.count < nodeGroupListSize {
                nodeGroupList.append(nodeGroup)
            }
        }
        nodeGroupList[nodeGroupListCount] = nodeGroup
        nodeGroupListCount += 1
    }
    
    
}
