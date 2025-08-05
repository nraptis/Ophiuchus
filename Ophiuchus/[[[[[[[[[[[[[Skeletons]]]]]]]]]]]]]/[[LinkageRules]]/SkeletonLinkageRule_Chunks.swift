//
//  SkeletonLinkageRule_Chunk.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

public struct SkeletonLinkageRule_Chunks {
    let chunks: [SkeletonChunk]
    let layoutPriority: LayoutPriority
    init(chunks: [SkeletonChunk], layoutPriority: LayoutPriority) {
        self.chunks = chunks
        self.layoutPriority = layoutPriority
    }
    
    func getLinks() -> [ExploderLink] {
        var result = [ExploderLink]()
        if chunks.count > 1 {
            let first = chunks[0]
            var index = 1
            while index < chunks.count {
                let second = chunks[index]
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
        if chunks.count > 1 {
            for index1 in 0..<chunks.count {
                let first = chunks[index1]
                for index2 in 0..<chunks.count {
                    if index1 != index2 {
                        let second = chunks[index2]
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
