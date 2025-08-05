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
    
    case accentIcon
    
    case heroLongIcon
    case heroLongLabel
}

public class SkeletonPiece: ExploderConforming {
    
    static func contains(list: [SkeletonPiece], piece: SkeletonPiece) -> Bool {
        for _piece in list {
            if _piece === piece {
                return true
            }
        }
        return false
    }
    
    public var currentSize = 0
    let originalSize: Int
    public let id: Int
    public let pieceIdentifier: PieceIdentifier
    
    unowned var chunk: SkeletonChunk!
    unowned var node: SkeletonNode!
    unowned var section: SkeletonSection!
    unowned var row: SkeletonRow!
    unowned var group: ExploderGroup<SkeletonPiece>!
    
    init(id: Int,
         pieceIdentifier: PieceIdentifier,
         size: Int) {
        self.id = id
        self.pieceIdentifier = pieceIdentifier
        self.currentSize = size
        self.originalSize = size
    }
    
    func canGrowByOne() -> Bool {
        if chunk.childrenSize < chunk.currentSize {
            return true
        }
        if node.childrenSize < node.currentSize {
            return true
        }
        if section.childrenSize < section.currentSize {
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
        currentSize += 1
        //node.growChildrenByOne_Unsafe_Bubble()
        chunk.growChildrenByOne_Unsafe_Bubble()
        
    }
    
}
