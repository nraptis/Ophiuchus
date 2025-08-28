//
//  Exploder.swift
//  Ophiuchus
//
//  Created by Nick on 7/4/25.
//

import Foundation

struct Exploder<Element: ExploderConforming> {
    
    static func explode(baseId: Int,
                        nodes: [Element],
                        links: [ExploderLink]) -> [ExploderGroup<Element>] {
        
        // Store parent ids
        var parent: [Int: Int] = [:]
        func find(_ x: Int) -> Int {
            if let currentParent = parent[x] {
                if currentParent != x {
                    let root = find(currentParent)
                    parent[x] = root
                    return root
                } else {
                    return currentParent
                }
            } else {
                parent[x] = x
                return x
            }
        }
        
        func union(_ x: Int, _ y: Int) {
            let rootX = find(x)
            let rootY = find(y)
            if rootX != rootY {
                parent[rootY] = rootX
            }
        }
        
        // Union from links
        for link in links {
            union(link.first, link.second)
        }
        
        // Group nodes by root id
        var grouped = [Int: [Element]]()
        var rootsInOrder = [Int]()
        rootsInOrder.reserveCapacity(nodes.count)
        
        for node in nodes {
            let root = find(node.id)
            if grouped[root] == nil {
                grouped[root] = [node]
                rootsInOrder.append(root)
            } else {
                grouped[root]!.append(node)
            }
        }
        
        // Start analysis from here.
        var layoutPriority_map = [Int: LayoutPriority]()
        for link in links {
            if let _layoutPriority = layoutPriority_map[link.first] {
                if link.layoutPriority.gte(layoutPriority: _layoutPriority) {
                    layoutPriority_map[link.first] = link.layoutPriority
                }
            } else {
                layoutPriority_map[link.first] = link.layoutPriority
            }
        }
        for link in links {
            if let _layoutPriority = layoutPriority_map[link.second] {
                if link.layoutPriority.gte(layoutPriority: _layoutPriority) {
                    layoutPriority_map[link.second] = link.layoutPriority
                }
            } else {
                layoutPriority_map[link.second] = link.layoutPriority
            }
        }
        
        var offsetId = 0
        var result = [ExploderGroup<Element>]()
        for root in rootsInOrder {
            if let groupNodes = grouped[root] {
                var maxLayoutPriority = LayoutPriority.finally
                for node in groupNodes {
                    if let _layoutPriority = layoutPriority_map[node.id] {
                        if _layoutPriority.gte(layoutPriority: maxLayoutPriority) {
                            maxLayoutPriority = _layoutPriority
                        }
                    }
                }
                result.append(ExploderGroup(id: baseId + offsetId,
                                            linkedList: groupNodes,
                                            layoutPriority: maxLayoutPriority))
                offsetId += 1
            }
        }
        return result
    }
    
    
    
}
