//
//  LinkageRule_Sections.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

public struct SkeletonLinkageRule_Sections {
    let sections: [SkeletonSection]
    let layoutPriority: LayoutPriority
    init(sections: [SkeletonSection],
         layoutPriority: LayoutPriority) {
        self.sections = sections
        self.layoutPriority = layoutPriority
    }
    
    func getLinks() -> [ExploderLink] {
        var result = [ExploderLink]()
        if sections.count > 1 {
            let first = sections[0]
            var index = 1
            while index < sections.count {
                let second = sections[index]
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
        if sections.count > 1 {
            for index1 in 0..<sections.count {
                let first = sections[index1]
                for index2 in 0..<sections.count {
                    if index1 != index2 {
                        let second = sections[index2]
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
