//
//  GeneratePieces.swift
//  OphiuchusTests
//
//  Created by Nick on 7/6/25.
//

import Foundation
@testable import Ophiuchus

struct GeneratePieces {
    
    static func generate(id: Int, size: Int) -> SkeletonPiece {
        let result = SkeletonPiece.generate(id: id, size: size)
        return result
    }
    
    
    static func generate(size: Int) -> SkeletonPiece {
        let result = SkeletonPiece.generate(size: size)
        return result
    }
    
    static func generate(id: Int) -> SkeletonPiece {
        let size = Int.random(in: 10...80)
        let result = generate(id: id, size: size)
        return result
    }
    
    static func generate() -> SkeletonPiece {
        let size = Int.random(in: 10...80)
        let result = generate(size: size)
        return result
    }
    
    static func generate_n(_ n: Int) -> [SkeletonPiece] {
        var result = [SkeletonPiece]()
        var index = 0
        while index < n {
            let piece = generate()
            result.append(piece)
            index += 1
        }
        return result
    }
    
    static func generate_n(_ n: Int, size: Int) -> [SkeletonPiece] {
        var result = [SkeletonPiece]()
        var index = 0
        while index < n {
            let piece = generate(size: size)
            result.append(piece)
            index += 1
        }
        return result
    }
    
}
