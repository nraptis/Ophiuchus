//
//  SkeletonLinkageRule_Piece.swift
//  Ophiuchus
//
//  Created by Nick on 7/4/25.
//

import Foundation

public struct SkeletonLinkageRule_Flexers {
    let flexers: [Flexer]
    let layoutPriority: LayoutPriority
    init(flexers: [Flexer], layoutPriority: LayoutPriority) {
        self.flexers = flexers
        self.layoutPriority = layoutPriority
    }
    
    func getLinks() -> [ExploderLink] {
        var result = [ExploderLink]()
        if flexers.count > 1 {
            let first = flexers[0]
            var index = 1
            while index < flexers.count {
                let second = flexers[index]
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
        if flexers.count > 1 {
            for index1 in 0..<flexers.count {
                let first = flexers[index1]
                for index2 in 0..<flexers.count {
                    if index1 != index2 {
                        let second = flexers[index2]
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
