//
//  ListFactory_Unique.swift
//  Ophiuchus
//
//  Created by Nick on 8/14/25.
//

import Foundation

struct ListFactory_Unique {
    
    private static var nodeSet = Set<Int>()
    private(set) static var nodeList = [WiseLayoutNode]()
    private(set) static var nodeListCount = 0
    private(set) static var nodeListSize = 0

    static func resetNodeList() {
        nodeListCount = 0
        nodeSet.removeAll(keepingCapacity: true)
    }
    
    static func intake(node: WiseLayoutNode) {
        
        let id = node.id
        
        if nodeSet.contains(id) {
            return
        }
        
        if nodeListCount >= nodeListSize {
            nodeListSize = (nodeListCount + (nodeListCount / 2) + 1)
            while nodeList.count < nodeListSize {
                nodeList.append(node)
            }
        }
        nodeSet.insert(id)
        nodeList[nodeListCount] = node
        nodeListCount += 1
    }
    
    
}
