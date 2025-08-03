//
//  GenerateRow.swift
//  OphiuchusTests
//
//  Created by Nick on 7/6/25.
//

import Foundation
@testable import Ophiuchus

struct GenerateRows {
    
    static let id_queue = DispatchQueue(label: "id_queue_rows")
    private static var row_id = 0
    
    
    static func generate_Row(flexer: Flexer) -> SkeletonRow {
        let chunk = GenerateChunks.generate_flexer(flexer: flexer)
        let result = generate_Row(chunk: chunk)
        return result
    }
    
    static func generate_Row(piece: SkeletonPiece) -> SkeletonRow {
        let chunk = GenerateChunks.generate_fixed(piece: piece)
        let result = generate_Row(chunk: chunk)
        return result
    }
    
    static func generate_Row(chunk: any SkeletonChunkConforming) -> SkeletonRow {
        let node = GenerateNodes.generate_node(chunk: chunk)
        let result = generate_Row(node: node)
        return result
    }
    
    static func generate_Row(node: WiseLayoutNode) -> SkeletonRow {
        let section = GenerateSections.generate_section(node: node)
        let result = generate_Row(section: section)
        return result
    }
    
    static func generate_Row(section: SkeletonSection) -> SkeletonRow {
        GenerateRows.generate_Row(sections: [section], attemptedCenteredSection: nil)
    }
    
    static func generate_Row(sections: [SkeletonSection]) -> SkeletonRow {
        GenerateRows.generate_Row(sections: sections, attemptedCenteredSection: nil)
    }
    
    static func generate_Row(sections: [SkeletonSection], attemptedCenteredSection: SkeletonSection?) -> SkeletonRow {
        
        let id = id_queue.sync {
            let id = GenerateRows.row_id
            GenerateRows.row_id += 1
            if GenerateRows.row_id > 1_000_000_000 { GenerateRows.row_id = 0 }
            return id
        }
        let result = SkeletonRow(id: id,
                                 sections: sections,
                                 attemptedCenteredSection: attemptedCenteredSection)
        
        for section in sections {
            section.row = result
            for node in section.skeletonNodes {
                node.section = section
                node.row = result
                for chunk in node.chunks {
                    chunk.node = node
                    chunk.section = section
                    chunk.row = result
                    for flexer in chunk.flexers {
                        flexer.chunk = chunk
                        flexer.node = node
                        flexer.section = section
                        flexer.row = result
                    }
                    for piece in chunk.pieces {
                        piece.chunk = chunk
                        piece.node = node
                        piece.section = section
                        piece.row = result
                    }
                }
            }
        }
        
        result.prepare()
        
        return result
    }
    
}
