//
//  LinkageRule.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

public struct SkeletonLinkageRule_Nodes {
    let nodes: [SkeletonNode]
    let layoutPriority: LayoutPriority
    init(nodes: [SkeletonNode], layoutPriority: LayoutPriority) {
        self.nodes = nodes
        self.layoutPriority = layoutPriority
    }
    
    func getLinks() -> [ExploderLink] {
        var result = [ExploderLink]()
        if nodes.count > 1 {
            let first = nodes[0]
            var index = 1
            while index < nodes.count {
                let second = nodes[index]
                let link = ExploderLink(first: first.id,
                                        second: second.id,
                                        layoutPriority: layoutPriority)
                result.append(link)
                index += 1
            }
        }
        return result
    }
    
    func getLinks_Redundant() -> [ExploderLink] {
        var result = [ExploderLink]()
        if nodes.count > 1 {
            for index1 in 0..<nodes.count {
                let first = nodes[index1]
                for index2 in 0..<nodes.count {
                    if index1 != index2 {
                        let second = nodes[index2]
                        let link = ExploderLink(first: first.id,
                                                second: second.id,
                                                layoutPriority: layoutPriority)
                        result.append(link)
                    }
                    
                }
                
            }
        }
        return result
    }
    
}
