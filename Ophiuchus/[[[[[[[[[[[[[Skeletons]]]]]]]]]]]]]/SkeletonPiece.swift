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
    
    static func fetch(pieceIdentifier: PieceIdentifier, pieces: [SkeletonPiece]) -> SkeletonPiece? {
        for piece in pieces {
            if piece.pieceIdentifier == pieceIdentifier {
                return piece
            }
        }
        return nil
    }
    
    static func generate(id: Int, size: Int) -> SkeletonPiece {
        let result = SkeletonPiece(id: id,
                                   pieceIdentifier: .unknown,
                                   size: size)
        return result
    }
    
    
    static func generate(size: Int) -> SkeletonPiece {
        let id = SkeletonIdentifierFactory.get_id()
        let result = generate(id: id,
                                    size: size)
        return result
    }
    
    static func generate(id: Int) -> SkeletonPiece {
        let size = Int.random(in: 10...80)
        let result = generate(id: id, size: size)
        return result
    }
    
    public var currentSize = 0
    
    var didGrowOnCurrentPass = false
    
    let originalSize: Int
    public let id: Int
    public let pieceIdentifier: PieceIdentifier
    
    //TODO: Back to unowned..
    var node: WiseLayoutNode!
    //TODO: Back to unowned..
    var section: SkeletonSection!
    //TODO: Back to unowned..
    
    var row: SkeletonRow!
    
    public unowned var group: ExploderGroup<SkeletonPiece>!
    
    init(id: Int,
         pieceIdentifier: PieceIdentifier,
         size: Int) {
        self.id = id
        self.pieceIdentifier = pieceIdentifier
        self.currentSize = size
        self.originalSize = size
    }
    
    static func contains(list: [SkeletonPiece], piece: SkeletonPiece) -> Bool {
        for _piece in list {
            if _piece === piece {
                return true
            }
        }
        return false
    }
    
    
}
