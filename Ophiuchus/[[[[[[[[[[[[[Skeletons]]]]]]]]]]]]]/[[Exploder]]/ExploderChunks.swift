//
//  ExploderChunks.swift
//  Ophiuchus
//
//  Created by Nick on 7/5/25.
//

import Foundation

struct ExploderChunks {
    
    static func explode(nodes: [any SkeletonChunkConforming],
                        links: [ExploderLink]) -> [ExploderGroupChunks] {
        
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
        var grouped: [Int: [any SkeletonChunkConforming]] = [:]
        for node in nodes {
            let root = find(node.id)
            if grouped[root] == nil {
                grouped[root] = [node]
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
        
        // No .map: build array manually
        var result = [ExploderGroupChunks]()
        for groupNodes in grouped.values {
            var max_layoutPriority = LayoutPriority.finally
            for node in groupNodes {
                if let _layoutPriority = layoutPriority_map[node.id] {
                    if _layoutPriority.gte(layoutPriority: max_layoutPriority) {
                        max_layoutPriority = _layoutPriority
                    }
                }
            }
            result.append(ExploderGroupChunks(linkedList: groupNodes, layoutPriority: max_layoutPriority))
        }
        
        return result
    }
    
}
