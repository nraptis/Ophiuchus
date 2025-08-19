//
//  ListFactory_UniqueB.swift
//  Ophiuchus
//
//  Created by Nick on 8/15/25.
//

import Foundation

struct ListFactory_BasicNodes {
    
    private(set) static var nodeList = [WiseLayoutNode]()
    private(set) static var nodeListCount = 0
    private(set) static var nodeListSize = 0

    static func resetNodeList() {
        nodeListCount = 0
    }
    
    static func intake(node: WiseLayoutNode) {
        
        let id = node.id
        
        if nodeListCount >= nodeListSize {
            nodeListSize = (nodeListCount + (nodeListCount / 2) + 1)
            while nodeList.count < nodeListSize {
                nodeList.append(node)
            }
        }
        nodeList[nodeListCount] = node
        nodeListCount += 1
    }
    
    
}
