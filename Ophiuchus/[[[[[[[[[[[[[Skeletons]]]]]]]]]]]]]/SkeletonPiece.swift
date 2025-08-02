//
//  SkeletonPiece.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

@frozen public enum PieceIdentifier: UInt8 {
    case unknown
    
    case heroStacked
    
    case heroLongIcon
    case heroLongLabel
}


public class SkeletonPiece: ExploderConforming {
    
    public var current_size = 0
    let original_size: Int
    public let id: Int
    public let pieceIdentifier: PieceIdentifier
    
    unowned var chunk: (any SkeletonChunkConforming)!
    unowned var node: SkeletonNode!
    unowned var section: SkeletonSection!
    unowned var row: SkeletonRow!
    unowned var group_unsafe: ExploderGroup<SkeletonPiece>!
    
    init(id: Int,
         pieceIdentifier: PieceIdentifier,
         size: Int) {
        self.id = id
        self.pieceIdentifier = pieceIdentifier
        self.current_size = size
        self.original_size = size
    }
    
    func canGrowByOne() -> Bool {
        if chunk.children_size < chunk.current_size {
            return true
        }
        if node.children_size < node.current_size {
            return true
        }
        if section.children_size < section.current_size {
            return true
        }
        if row.canGrowByOne(section: section) {
            return true
        }
        return false
    }
    
    /*
     func canGrowByOne() -> Bool {
        if row.remaining_size > 0 {
            return true
        } else {
            return false
        }
    }
    */
    
    func growByOne_Unsafe_Bubble() {
        current_size += 1
        //node.growChildrenByOne_Unsafe_Bubble()
        chunk.growChildrenByOne_Unsafe_Bubble()
        
    }
    
}
