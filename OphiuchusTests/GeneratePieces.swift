//
//  GeneratePieces.swift
//  OphiuchusTests
//
//  Created by Nick on 7/6/25.
//

import Foundation
@testable import Ophiuchus

struct GeneratePieces {
    
    static let id_queue = DispatchQueue(label: "id_queue_pieces")
    
    private static var piece_id = 0
    static func generate_piece(size: Int) -> SkeletonPiece {
        
        let id = id_queue.sync {
            let id = GeneratePieces.piece_id
            GeneratePieces.piece_id += 1
            if GeneratePieces.piece_id > 1_000_000_000 { GeneratePieces.piece_id = 0 }
            return id
        }
        
        let result = SkeletonPiece(id: id, pieceIdentifier: .unknown, size: size)
        return result
    }
    
    static func generate_piece() -> SkeletonPiece {
        
        let id = id_queue.sync {
            let id = GeneratePieces.piece_id
            GeneratePieces.piece_id += 1
            if GeneratePieces.piece_id > 1_000_000_000 { GeneratePieces.piece_id = 0 }
            return id
        }
        
        let size = Int.random(in: 10...80)
        let result = SkeletonPiece(id: id, pieceIdentifier: .unknown, size: size)
        return result
    }
    
    static func generate_piece(id: Int) -> SkeletonPiece {
        let size = Int.random(in: 10...80)
        let result = SkeletonPiece(id: id, pieceIdentifier: .unknown, size: size)
        return result
    }
    
}
