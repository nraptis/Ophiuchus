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
    
    /*
    static func generate_section(skeleton_nodes: [SkeletonNode], gap: Int) -> SkeletonChunk {
        let base = Int.random(in: 0...20)
        let result = GenerateSections.generate_section(skeleton_nodes: skeleton_nodes,
                                                       base: base,
                                                       gap: gap)
        return result
    }
    
    static func generate_section(skeleton_nodes: [SkeletonNode], base: Int, gap: Int) -> SkeletonSection {
        
        let result = GenerateSections.generate_section(skeleton_nodes: skeleton_nodes)
        result.currentSize = base + gap
        result.childrenSize = base
        return result
    }
    */
    
    static func generate_n_chunks(n: Int) -> [SkeletonChunk] {
        var result = [SkeletonChunk]()
        var index = 0
        while index < n {
            if Bool.random() {
                let chunk = generate_fixed(size: 10)
                result.append(chunk)
            } else {
                let chunk = generate_flexer_10_flexer()
                result.append(chunk)
            }
            index += 1
        }
        return result
    }
    
    static func generate_random() -> SkeletonChunk {
        
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
    
    static func generate_random_10_flexer() -> SkeletonChunk {
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
    
    
    static func generate_fixed() -> SkeletonChunk {
        
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
    
    static func generate_gapped(flexers: [Flexer], gap: Int) -> SkeletonChunk {
        let base = Int.random(in: 0...20)
        return GenerateChunks.generate_gapped(flexers: flexers,
                                           base: base,
                                           gap: gap)
    }
    
    static func generate_gapped(flexers: [Flexer], base: Int, gap: Int) -> SkeletonChunk {
        let result = GenerateChunks.generate_flexers(flexers: flexers)
        result.currentSize = base + gap
        result.childrenSize = base
        return result
    }
    
    
    static func generate_gapped(pieces: [SkeletonPiece], gap: Int) -> SkeletonChunk {
        let base = Int.random(in: 0...20)
        return GenerateChunks.generate_gapped(pieces: pieces,
                                           base: base,
                                           gap: gap)
    }
    
    static func generate_gapped(pieces: [SkeletonPiece], base: Int, gap: Int) -> SkeletonChunk {
        let result = GenerateChunks.generate(pieces: pieces, flexers: [])
        result.currentSize = base + gap
        result.childrenSize = base
        return result
    }
    
    static func generate_gapped(pieces: [SkeletonPiece], flexers: [Flexer], gap: Int) -> SkeletonChunk {
        let base = Int.random(in: 0...20)
        return GenerateChunks.generate_gapped(pieces: pieces,
                                              flexers: flexers,
                                           base: base,
                                           gap: gap)
    }
    
    static func generate_gapped(pieces: [SkeletonPiece], flexers: [Flexer], base: Int, gap: Int) -> SkeletonChunk {
        let result = GenerateChunks.generate(pieces: pieces, flexers: flexers)
        result.currentSize = base + gap
        result.childrenSize = base
        return result
    }
    
    
    static func generate_fixed(id: Int) -> SkeletonChunk {
        
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
    
    static func generate_hero_long() -> SkeletonChunk {
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
    
    static func generate_hero_long(size_icon: Int, size_text: Int) -> SkeletonChunk {
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
        
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: [icon, label],
                                   flexers: [left, center, right],
                                   alignment: alignment)
        return result
    }
    
    static func generate_hero_long_10_flexer(size_icon: Int, size_text: Int) -> SkeletonChunk {
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
        
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: [icon, label],
                                   flexers: [left, center, right],
                                   alignment: alignment)
        return result
    }
    
    static func generate_hero_long_10_flexer() -> SkeletonChunk {
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
        
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: [icon, label],
                                   flexers: [left, center, right],
                                   alignment: alignment)
        return result
    }
    
    static func generate_hero_stacked() -> SkeletonChunk {
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
    
    static func generate_hero_stacked(size: Int) -> SkeletonChunk {
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
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: [center],
                                   flexers: [left, right],
                                   alignment: alignment)
        return result
    }
    
    static func generate_hero_stacked_10_flexer(size: Int) -> SkeletonChunk {
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
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: [center],
                                   flexers: [left, right],
                                   alignment: alignment)
        return result
    }
    
    static func generate_hero_stacked_10_flexer() -> SkeletonChunk {
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
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: [center],
                                   flexers: [left, right],
                                   alignment: alignment)
        
        return result
    }
    
    static func generate_pading() -> SkeletonChunk {
        let left = _generate_flexer()
        let right = _generate_flexer()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: [],
                                   flexers: [left, right],
                                   alignment: alignment)
        return result
    }
    
    static func generate_pading_10_flexer() -> SkeletonChunk {
        let left = GenerateFlexers.generate_10_random_climb()
        let right = GenerateFlexers.generate_10_random_climb()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: [],
                                   flexers: [left, right],
                                   alignment: alignment)
        return result
    }
    
    
    static func generate_flexer() -> SkeletonChunk {
        let flexer = _generate_flexer()
        return generate_flexer(flexer: flexer)
    }
    
    static func generate_flexer(flexer: Flexer) -> SkeletonChunk {
        return generate_flexers(flexers: [flexer])
    }
    
    static func generate_flexers(flexers: [Flexer]) -> SkeletonChunk {
        let alignment = GenerateAlignment.generate_alignment()
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   flexers: flexers,
                                   alignment: alignment)
        return result
    }
    
    static func generate_flexer_two(flexer1: Flexer, flexer2: Flexer) -> SkeletonChunk {
        let alignment = GenerateAlignment.generate_alignment()
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        
        if Bool.random() {
            let result = SkeletonChunk(id: id,
                                       chunkIdentifier: .unknown,
                                       pieces: [],
                                       flexers: [flexer1, flexer2],
                                       alignment: alignment)
            return result
        } else {
            let piece = GeneratePieces.generate_piece(size: 10)
            let result = SkeletonChunk(id: id,
                                       chunkIdentifier: .unknown,
                                       pieces: [piece],
                                       flexers: [flexer1, flexer2],
                                       alignment: alignment)
            return result
        }
    }
    
    static func generate_flexer_three(flexer1: Flexer, flexer2: Flexer, flexer3: Flexer) -> SkeletonChunk {
        let alignment = GenerateAlignment.generate_alignment()
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        
        let random = Int.random(in: 0...2)
        if random == 0 {
            let result = SkeletonChunk(id: id,
                                       chunkIdentifier: .unknown,
                                       pieces: [],
                                       flexers: [flexer1, flexer2, flexer3],
                                       alignment: alignment)
            return result
        } else if random == 1 {
            let piece1 = GeneratePieces.generate_piece(size: 10)
            let result = SkeletonChunk(id: id,
                                       chunkIdentifier: .unknown,
                                       pieces: [piece1],
                                       flexers: [flexer1, flexer2, flexer3],
                                       alignment: alignment)
            return result
        } else {
            let piece1 = GeneratePieces.generate_piece(size: 10)
            let piece2 = GeneratePieces.generate_piece(size: 10)
            let result = SkeletonChunk(id: id,
                                       chunkIdentifier: .unknown,
                                       pieces: [piece1, piece2],
                                       flexers: [flexer1, flexer2, flexer3],
                                       alignment: alignment)
            return result
        }
        
       
        
    }
    
    static func generate_flexer_10_flexer() -> SkeletonChunk {
        let flexer = GenerateFlexers.generate_10_random_climb()
        let alignment = GenerateAlignment.generate_alignment()
        
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: [],
                                   flexers: [flexer],
                                   alignment: alignment)
        
        return result
    }
    
    static func generate_fixed(size: Int) -> SkeletonChunk {
        let piece = GeneratePieces.generate_piece(size: size)
        let result = generate_fixed(piece: piece)
        return result
    }
    
    static func generate_fixed(id: Int, size: Int) -> SkeletonChunk {
        let piece = GeneratePieces.generate_piece(size: size)
        let result = generate_fixed(id: id, piece: piece)
        return result
    }
    
    static func generate_fixed(piece: SkeletonPiece) -> SkeletonChunk {
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        let result = generate_fixed(id: id, piece: piece)
        return result
    }
    
    static func generate_fixed(id: Int, piece: SkeletonPiece) -> SkeletonChunk {
        let alignment = GenerateAlignment.generate_alignment()
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: [piece],
                                   flexers: [],
                                   alignment: alignment)
        return result
    }
    
    static func generate_piece(piece: SkeletonPiece) -> SkeletonChunk {
        let result = GenerateChunks.generate_pieces(pieces: [piece])
        return result
    }
    
    static func generate_pieces(pieces: [SkeletonPiece]) -> SkeletonChunk {
        let alignment = GenerateAlignment.generate_alignment()
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: pieces,
                                   flexers: [],
                                   alignment: alignment)
        return result
    }
    
    static func generate(pieces: [SkeletonPiece], flexers: [Flexer]) -> SkeletonChunk {
        let alignment = GenerateAlignment.generate_alignment()
        let id = id_queue.sync {
            let id = GenerateChunks.chunk_id
            GenerateChunks.chunk_id += 1
            if GenerateChunks.chunk_id > 1_000_000_000 { GenerateChunks.chunk_id = 0 }
            return id
        }
        
        let result = SkeletonChunk(id: id,
                                   chunkIdentifier: .unknown,
                                   pieces: pieces,
                                   flexers: flexers,
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
