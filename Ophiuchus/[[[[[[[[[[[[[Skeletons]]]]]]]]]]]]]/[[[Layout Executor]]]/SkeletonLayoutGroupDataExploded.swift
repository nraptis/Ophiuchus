//
//  SkeletonLayoutGroupWad.swift
//  Ophiuchus
//
//  Created by Nick on 8/5/25.
//

import Foundation

class SkeletonLayoutGroupDataExploded {
    let pieceGroups: [ExploderGroup<SkeletonPiece>]
    let flexerGroups: [ExploderGroup<Flexer>]
    let nodeGroups: [ExploderGroup<WiseLayoutNode>]
    let sections: [SkeletonSection]
    
    init(pieceGroups: [ExploderGroup<SkeletonPiece>],
         flexerGroups: [ExploderGroup<Flexer>],
         nodeGroups: [ExploderGroup<WiseLayoutNode>],
         sections: [SkeletonSection]) {
        self.pieceGroups = pieceGroups
        self.flexerGroups = flexerGroups
        self.nodeGroups = nodeGroups
        self.sections = sections
    }
    
    func calculateFlexerTargetSizeCurrentPriority(layoutPriority: LayoutPriority) {
        for flexerGroup in flexerGroups {
            for flexer in flexerGroup.linkedList {
                flexer.targetSizeCurrentPriority = flexer.getTargetSize(layoutPriority: layoutPriority)
            }
        }
    }
    
    
}
