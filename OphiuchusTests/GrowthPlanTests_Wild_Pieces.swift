//
//  GrowthPlanTests_Wild_Pieces.swift
//  OphiuchusTests
//
//  Created by Nick on 8/3/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct GrowthPlanTests_Wild_Pieces {
    
    @MainActor @Test func test_growth_plan_wild_pieces_small_test_1_row() {
        for _ in 0..<2048 {
            
            let sectionCount = Int.random(in: 0..<6)
            var sections_final = [SkeletonSection]()
            var sections_trash = [SkeletonSection]()
            
            var pieces_final = [SkeletonPiece]()
            var pieces_trash = [SkeletonPiece]()
            
            for _ in 0..<sectionCount {
                
                let section_gap = Int.random(in: 0..<4)
                
                let nodeCount = Int.random(in: 0..<6)
                var nodes = [SkeletonNode]()
                for _ in 0..<nodeCount {
                    
                    let node_gap = Int.random(in: 0...6)
                    
                    let chunkCount = Int.random(in: 0..<6)
                    var chunks = [SkeletonChunk]()
                    
                    for _ in 0..<chunkCount {
                        
                        let chunk_gap = Int.random(in: 0...4)
                        
                        let pieceCount = Int.random(in: 0..<16)
                        let pieces = GeneratePieces.generate_n_pieces(n: pieceCount)
                        
                        pieces_trash.append(contentsOf: pieces)
                        
                        
                        let chunk = GenerateChunks.generate_gapped(pieces: pieces, gap: chunk_gap)
                        chunks.append(chunk)
                    }
                    
                    
                    let node = GenerateNodes.generate_skeleton_node(chunks: chunks, gap: node_gap)
                    nodes.append(node)
                }
                
                let section = GenerateSections.generate_section(skeleton_nodes: nodes, gap: section_gap)
                
                if Bool.random() {
                    sections_final.append(section)
                    for node in nodes {
                        if Bool.random() {
                            for chunk in node.chunks {
                                if Bool.random() {
                                    
                                    for piece in chunk.pieces {
                                        if Bool.random() {
                                            pieces_final.append(piece)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                sections_trash.append(section)
            }
            
            let row = GenerateRows.generate_Row(sections: sections_final)
            
            
            let piecesGroup = ExploderGroup<SkeletonPiece>(linkedList: pieces_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: piecesGroup)
            
            let rows = [row]
            if !GrowthPlanValidator.checkPieces(pRows: rows,
                                                 pPieces: pieces_final,
                                                 pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_pieces_small_test_1_row_shuffled() {
        for _ in 0..<2048 {
            
            let sectionCount = Int.random(in: 0..<6)
            var sections_final = [SkeletonSection]()
            var sections_trash = [SkeletonSection]()
            
            var pieces_final = [SkeletonPiece]()
            var pieces_trash = [SkeletonPiece]()
            
            for _ in 0..<sectionCount {
                
                let section_gap = Int.random(in: 0..<4)
                
                let nodeCount = Int.random(in: 0..<6)
                var nodes = [SkeletonNode]()
                for _ in 0..<nodeCount {
                    
                    let node_gap = Int.random(in: 0...6)
                    
                    let chunkCount = Int.random(in: 0..<6)
                    var chunks = [SkeletonChunk]()
                    
                    for _ in 0..<chunkCount {
                        
                        let chunk_gap = Int.random(in: 0...4)
                        
                        let pieceCount = Int.random(in: 0..<16)
                        var pieces = GeneratePieces.generate_n_pieces(n: pieceCount)
                        
                        pieces_trash.append(contentsOf: pieces)
                        
                        pieces.shuffle()
                        let chunk = GenerateChunks.generate_gapped(pieces: pieces, gap: chunk_gap)
                        chunks.append(chunk)
                    }
                    
                    chunks.shuffle()
                    let node = GenerateNodes.generate_skeleton_node(chunks: chunks, gap: node_gap)
                    nodes.append(node)
                }
                nodes.shuffle()
                
                let section = GenerateSections.generate_section(skeleton_nodes: nodes, gap: section_gap)
                
                if Bool.random() {
                    sections_final.append(section)
                    for node in nodes {
                        if Bool.random() {
                            for chunk in node.chunks {
                                if Bool.random() {
                                    
                                    for piece in chunk.pieces {
                                        if Bool.random() {
                                            pieces_final.append(piece)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                sections_trash.append(section)
            }
            
            let row = GenerateRows.generate_Row(sections: sections_final)
            
            
            let piecesGroup = ExploderGroup<SkeletonPiece>(linkedList: pieces_final, layoutPriority: .required)
            var pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: piecesGroup)
            pRowGrowthPlansList.shuffle()
            
            let rows = [row]
            if !GrowthPlanValidator.checkPieces(pRows: rows,
                                                 pPieces: pieces_final,
                                                 pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_pieces_small_test_n_rows() {
        for _ in 0..<2048 {
            
            let rowCount = Int.random(in: 0..<8)
            var rows = [SkeletonRow]()
            var pieces_final = [SkeletonPiece]()
            var pieces_trash = [SkeletonPiece]()
            
            for _ in 0..<rowCount {
                
                let sectionCount = Int.random(in: 0..<6)
                var sections_final = [SkeletonSection]()
                var sections_trash = [SkeletonSection]()
                
                for _ in 0..<sectionCount {
                    
                    let section_gap = Int.random(in: 0..<4)
                    
                    let nodeCount = Int.random(in: 0..<6)
                    var nodes = [SkeletonNode]()
                    for _ in 0..<nodeCount {
                        
                        let node_gap = Int.random(in: 0...6)
                        
                        let chunkCount = Int.random(in: 0..<6)
                        var chunks = [SkeletonChunk]()
                        
                        for _ in 0..<chunkCount {
                            
                            let chunk_gap = Int.random(in: 0...4)
                            
                            let pieceCount = Int.random(in: 0..<16)
                            let pieces = GeneratePieces.generate_n_pieces(n: pieceCount)
                            
                            pieces_trash.append(contentsOf: pieces)
                            
                            
                            let chunk = GenerateChunks.generate_gapped(pieces: pieces, gap: chunk_gap)
                            chunks.append(chunk)
                        }
                        
                        
                        let node = GenerateNodes.generate_skeleton_node(chunks: chunks, gap: node_gap)
                        nodes.append(node)
                    }
                    
                    let section = GenerateSections.generate_section(skeleton_nodes: nodes, gap: section_gap)
                    
                    if Bool.random() {
                        sections_final.append(section)
                        for node in nodes {
                            if Bool.random() {
                                for chunk in node.chunks {
                                    if Bool.random() {
                                        
                                        for piece in chunk.pieces {
                                            if Bool.random() {
                                                pieces_final.append(piece)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    sections_trash.append(section)
                }
                
                let row = GenerateRows.generate_Row(sections: sections_final)
                rows.append(row)
            }
            
            let piecesGroup = ExploderGroup<SkeletonPiece>(linkedList: pieces_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: piecesGroup)
            
            if !GrowthPlanValidator.checkPieces(pRows: rows,
                                                 pPieces: pieces_final,
                                                 pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_pieces_small_test_n_rows_shuffled() {
        for _ in 0..<2048 {
            
            let rowCount = Int.random(in: 0..<8)
            var rows = [SkeletonRow]()
            var rows_orphaned = [SkeletonRow]()
            
            var pieces_final = [SkeletonPiece]()
            var pieces_trash = [SkeletonPiece]()
            
            for _ in 0..<rowCount {
                
                let sectionCount = Int.random(in: 0..<6)
                var sections_final = [SkeletonSection]()
                var sections_trash = [SkeletonSection]()
                
                for _ in 0..<sectionCount {
                    
                    let section_gap = Int.random(in: 0..<4)
                    
                    let nodeCount = Int.random(in: 0..<6)
                    var nodes = [SkeletonNode]()
                    for _ in 0..<nodeCount {
                        
                        let node_gap = Int.random(in: 0...6)
                        
                        let chunkCount = Int.random(in: 0..<6)
                        var chunks = [SkeletonChunk]()
                        
                        for _ in 0..<chunkCount {
                            
                            let chunk_gap = Int.random(in: 0...4)
                            
                            let pieceCount = Int.random(in: 0..<16)
                            var pieces = GeneratePieces.generate_n_pieces(n: pieceCount)
                            
                            pieces.shuffle()
                            
                            pieces_trash.append(contentsOf: pieces)
                            
                            
                            let chunk = GenerateChunks.generate_gapped(pieces: pieces, gap: chunk_gap)
                            chunks.append(chunk)
                        }
                        
                        chunks.shuffle()
                        
                        
                        let node = GenerateNodes.generate_skeleton_node(chunks: chunks, gap: node_gap)
                        nodes.append(node)
                    }
                    
                    nodes.shuffle()
                    
                    let section = GenerateSections.generate_section(skeleton_nodes: nodes, gap: section_gap)
                    
                    if Bool.random() {
                        sections_final.append(section)
                        for node in nodes {
                            if Bool.random() {
                                for chunk in node.chunks {
                                    if Bool.random() {
                                        for piece in chunk.pieces {
                                            if Bool.random() {
                                                pieces_final.append(piece)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    sections_trash.append(section)
                }
                
                let row = GenerateRows.generate_Row(sections: sections_final)
                
                if Bool.random() {
                    rows.append(row)
                } else {
                    rows_orphaned.append(row)
                }
            }
            
            let piecesGroup = ExploderGroup<SkeletonPiece>(linkedList: pieces_final, layoutPriority: .required)
            var pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: piecesGroup)
            pRowGrowthPlansList.shuffle()
            
            if !GrowthPlanValidator.checkPieces(pRows: rows,
                                                 pPieces: pieces_final,
                                                 pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
}
