//
//  GenerateChunks.swift
//  OphiuchusTests
//
//  Created by Nick on 7/4/25.
//

import Foundation
@testable import Ophiuchus

struct GenerateChunks {
    
    static let id_queue = DispatchQueue(label: "id_queue_chunks")
    
    private static var chunk_id = 0
    
    static func generate_random() -> (any SkeletonChunkConforming) {
        
        let random = Int.random(in: 0...4)
        if random == 0 {
            return generate_fixed()
        } else if random == 1 {
            return generate_flexer()
        } else if random == 2 {
            return generate_pading()
        } else if random == 3 {
            return generate_hero_stacked()
        } else {
            return generate_hero_long()
        }
    }
    
    static func generate_random_10_flexer() -> (any SkeletonChunkConforming) {
        let random = Int.random(in: 0...4)
        if random == 0 {
            return generate_fixed()
        } else if random == 1 {
            return generate_flexer_10_flexer()
        } else if random == 2 {
            return generate_pading_10_flexer()
        } else if random == 3 {
            return generate_hero_stacked_10_flexer()
        } else {
            return generate_hero_long_10_flexer()
        }
    }
    
    
    static func generate_fixed() -> SkeletonChunkFixed {
        
        let random = Int.random(in: 0...10)
        let size: Int
        if random < 8 {
            // Typical Sizes
            size = Int.random(in: 12...64)
        } else {
            // Weird Sizes
            size = Int.random(in: 0...180)
        }
        return generate_fixed(size: size)
    }
    
    static func generate_fixed(id: Int) -> SkeletonChunkFixed {
        
        let random = Int.random(in: 0...10)
        let size: Int
        if random < 8 {
            // Typical Sizes
            size = Int.random(in: 12...64)
        } else {
            // Weird Sizes
            size = Int.random(in: 0...180)
        }
        return generate_fixed(id: id, size: size)
    }
    
    static func generate_hero_long() -> SkeletonChunkHeroLong {
        let random1 = Int.random(in: 0...10)
        let random2 = Int.random(in: 0...10)
        
        let size_icon: Int
        let size_text: Int
        if random1 < 8 {
            // Typical Sizes
            size_icon = Int.random(in: 12...64)
        } else {
            // Weird Sizes
            size_icon = Int.random(in: 0...180)
        }
        if random2 < 8 {
            // Typical Sizes
            size_text = Int.random(in: 12...64)
        } else {
            // Weird Sizes
            size_text = Int.random(in: 0...180)
        }
        return generate_hero_long(size_icon: size_icon, size_text: size_text)
    }
    
    static func generate_hero_long(size_icon: Int, size_text: Int) -> SkeletonChunkHeroLong {
        let left = _generate_flexer()
        let icon = GeneratePieces.generate_piece(size: size_icon)
        let center = _generate_flexer()
        let label = GeneratePieces.generate_piece(size: size_text)
        let right = _generate_flexer()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        
        let result = SkeletonChunkHeroLong(id: id,
                                           chunkIdentifier: .unknown,
                                           left: left,
                                           icon: icon,
                                           spacing: center,
                                           label: label,
                                           right: right,
                                           alignment: alignment)
        
        return result
    }
    
    static func generate_hero_long_10_flexer(size_icon: Int, size_text: Int) -> SkeletonChunkHeroLong {
        let left = GenerateFlexers.generate_10_random_climb()
        let icon = GeneratePieces.generate_piece(size: size_icon)
        let center = GenerateFlexers.generate_10_random_climb()
        let label = GeneratePieces.generate_piece(size: size_text)
        let right = GenerateFlexers.generate_10_random_climb()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        
        let result = SkeletonChunkHeroLong(id: id,
                                           chunkIdentifier: .unknown,
                                           left: left,
                                           icon: icon,
                                           spacing: center,
                                           label: label,
                                           right: right,
                                           alignment: alignment)
        return result
    }
    
    static func generate_hero_long_10_flexer() -> SkeletonChunkHeroLong {
        let left = GenerateFlexers.generate_10_random_climb()
        let icon = GeneratePieces.generate_piece(size: Int.random(in: 12...96))
        let center = GenerateFlexers.generate_10_random_climb()
        let label = GeneratePieces.generate_piece(size: Int.random(in: 12...96))
        let right = GenerateFlexers.generate_10_random_climb()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        
        let result = SkeletonChunkHeroLong(id: id,
                                           chunkIdentifier: .unknown,
                                           left: left,
                                           icon: icon,
                                           spacing: center,
                                           label: label,
                                           right: right,
                                           alignment: alignment)
        return result
    }
    
    static func generate_hero_stacked() -> SkeletonChunkHeroStacked {
        let random = Int.random(in: 0...10)
        let size: Int
        if random < 8 {
            // Typical Sizes
            size = Int.random(in: 12...64)
        } else {
            // Weird Sizes
            size = Int.random(in: 0...180)
        }
        return generate_hero_stacked(size: size)
    }
    
    static func generate_hero_stacked(size: Int) -> SkeletonChunkHeroStacked {
        let left = _generate_flexer()
        let center = GeneratePieces.generate_piece(size: size)
        let right = _generate_flexer()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        let result = SkeletonChunkHeroStacked(id: id,
                                              chunkIdentifier: .unknown,
                                              left: left,
                                              center: center,
                                              right: right,
                                              alignment: alignment)
        return result
    }
    
    static func generate_hero_stacked_10_flexer(size: Int) -> SkeletonChunkHeroStacked {
        let left = GenerateFlexers.generate_10_random_climb()
        let center = GeneratePieces.generate_piece(size: size)
        let right = GenerateFlexers.generate_10_random_climb()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        let result = SkeletonChunkHeroStacked(id: id,
                                              chunkIdentifier: .unknown,
                                              left: left,
                                              center: center,
                                              right: right,
                                              alignment: alignment)
        return result
    }
    
    static func generate_hero_stacked_10_flexer() -> SkeletonChunkHeroStacked {
        let left = GenerateFlexers.generate_10_random_climb()
        let center = GeneratePieces.generate_piece(size: Int.random(in: 12...96))
        let right = GenerateFlexers.generate_10_random_climb()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        let result = SkeletonChunkHeroStacked(id: id,
                                              chunkIdentifier: .unknown,
                                              left: left,
                                              center: center,
                                              right: right,
                                              alignment: alignment)
        return result
    }
    
    static func generate_pading() -> SkeletonChunkPadding {
        let left = _generate_flexer()
        let right = _generate_flexer()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        let result = SkeletonChunkPadding(id: id,
                                          chunkIdentifier: .unknown,
                                          left: left,
                                          right: right,
                                          alignment: alignment)
        return result
    }
    
    static func generate_pading_10_flexer() -> SkeletonChunkPadding {
        let left = GenerateFlexers.generate_10_random_climb()
        let right = GenerateFlexers.generate_10_random_climb()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        let result = SkeletonChunkPadding(id: id,
                                          chunkIdentifier: .unknown,
                                          left: left,
                                          right: right,
                                          alignment: alignment)
        return result
    }
    
    
    static func generate_flexer() -> SkeletonChunkFlexer {
        let flexer = _generate_flexer()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        let result = SkeletonChunkFlexer(id: id,
                                         chunkIdentifier: .unknown,
                                         flexer: flexer,
                                         alignment: alignment)
        return result
    }
    
    static func generate_flexer_10_flexer() -> SkeletonChunkFlexer {
        let flexer = GenerateFlexers.generate_10_random_climb()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        let result = SkeletonChunkFlexer(id: id,
                                         chunkIdentifier: .unknown,
                                         flexer: flexer,
                                         alignment: alignment)
        
        return result
    }
    
    static func generate_fixed(size: Int) -> SkeletonChunkFixed {
        let piece = GeneratePieces.generate_piece(size: size)
        let result = generate_fixed(piece: piece)
        return result
    }
    
    static func generate_fixed(id: Int, size: Int) -> SkeletonChunkFixed {
        let piece = GeneratePieces.generate_piece(size: size)
        let result = generate_fixed(id: id, piece: piece)
        return result
    }
    
    static func generate_fixed(piece: SkeletonPiece) -> SkeletonChunkFixed {
        let alignment = GenerateAlignment.generate_alignment()
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        let result = SkeletonChunkFixed(id: id,
                                        chunkIdentifier: .unknown,
                                        piece: piece,
                                        alignment: alignment)
        return result
    }
    
    static func generate_fixed(id: Int, piece: SkeletonPiece) -> SkeletonChunkFixed {
        let alignment = GenerateAlignment.generate_alignment()
        let result = SkeletonChunkFixed(id: id,
                                        chunkIdentifier: .unknown,
                                        piece: piece,
                                        alignment: alignment)
        return result
    }
    
    private static func _generate_flexer() -> Flexer {
        let flexer: Flexer
        let random = Int.random(in: 0...10)
        if random < 4 {
            flexer = GenerateFlexers.generate_n_m_climb(n: 4, m: 4)
        } else if random < 6 {
            flexer = GenerateFlexers.generate_10_random_climb()
        } else if random < 8 {
            flexer = GenerateFlexers.generate_n_random_climb(n: 8)
        } else {
            flexer = GenerateFlexers.generate_n_m_climb(n: 8, m: 6)
        }
        return flexer
    }
    
    
    
}
