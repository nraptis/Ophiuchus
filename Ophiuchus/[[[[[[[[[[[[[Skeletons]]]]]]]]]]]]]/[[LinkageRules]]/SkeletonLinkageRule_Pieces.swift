//
//  SkeletonLinkageRule_Piece.swift
//  Ophiuchus
//
//  Created by Nick on 7/4/25.
//

import Foundation

public struct SkeletonLinkageRule_Pieces {
    let pieces: [SkeletonPiece]
    let layoutPriority: LayoutPriority
    init(pieces: [SkeletonPiece], layoutPriority: LayoutPriority) {
        self.pieces = pieces
        self.layoutPriority = layoutPriority
    }
    
    func getLinks() -> [ExploderLink] {
        var result = [ExploderLink]()
        if pieces.count > 1 {
            let first = pieces[0]
            var index = 1
            while index < pieces.count {
                let second = pieces[index]
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
        if pieces.count > 1 {
            for index1 in 0..<pieces.count {
                let first = pieces[index1]
                for index2 in 0..<pieces.count {
                    if index1 != index2 {
                        let second = pieces[index2]
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
