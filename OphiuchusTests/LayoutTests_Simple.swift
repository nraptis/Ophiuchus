//
//  LayoutTests_Simple.swift
//  OphiuchusTests
//
//  Created by Nick on 7/4/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct LayoutTests_Simple {
    
    func generateNode(id: Int) -> WiseLayoutNode {
        let chunk_count = Int.random(in: 1...3)
        var chunks = [any SkeletonChunkConforming]()
        for _ in 0..<chunk_count {
            let chunk = GenerateChunks.generate_random()
            chunks.append(chunk)
        }
        let result = GenerateNodes.generate_node(id: id, chunks: chunks)
        return result
    }
    
    func generateSection(id: Int, node_id: inout Int) -> SkeletonSection {
        
        let node_count = Int.random(in: 1...3)
        var nodes = [WiseLayoutNode]()
        for _ in 0..<node_count {
            let node = generateNode(id: node_id)
            nodes.append(node)
            node_id += 1
        }
        let result = SkeletonSection(id: id, layoutNodes: nodes, alignment: .left)
        return result
    }
    
    func generateRow() -> SkeletonRow {
        
        var node_id = 0
        
        let section_count = Int.random(in: 1...3)
        var section_id = 0
        var sections = [SkeletonSection]()
        for _ in 0..<section_count {
            let section = generateSection(id: section_id,
                                          node_id: &node_id)
            sections.append(section)
            section_id += 1
        }
        let result = SkeletonRow(sections: sections, attemptedCenteredSection: nil)
        return result
    }
    
    @Test func test_page_layout_propogation_simple_manual() {
        
        for _ in 0..<10 {
            var number_verified = 0
            for _ in 0..<100 {
                
                let rowCount = Int.random(in: 1...10)
                var rows = [SkeletonRow]()
                for _ in 0..<rowCount {
                    let row = generateRow()
                    rows.append(row)
                }
                
                let page = SkeletonPage(rows: rows)
                
                page.prepare(menuWidthWithSafeArea: 1000,
                             safeAreaLeft: 32,
                             safeAreaRight: 32)
                
                for row in page.rows {
                    
                    for section in row.sections {
                        if section.row !== row {
                            print("row mis-match (section)")
                            #expect(Bool(false))
                            return
                        }
                        
                        for node in section.skeletonNodes {
                            if node.row !== row {
                                print("row mis-match (node)")
                                #expect(Bool(false))
                                return
                            }
                            if node.section !== section {
                                print("section mis-match (node)")
                                #expect(Bool(false))
                                return
                            }
                            
                            for chunk in node.chunks {
                                if node.row !== row {
                                    print("row mis-match (chunk)")
                                    #expect(Bool(false))
                                    return
                                }
                                if chunk.section !== section {
                                    print("section mis-match (chunk)")
                                    #expect(Bool(false))
                                    return
                                }
                                if chunk.node !== node {
                                    print("node mis-match (chunk)")
                                    #expect(Bool(false))
                                    return
                                }
                                
                                for piece in chunk.pieces {
                                    
                                    if piece.row !== row {
                                        print("row mis-match (piece)")
                                        #expect(Bool(false))
                                        return
                                    }
                                    if piece.section !== section {
                                        print("section mis-match (piece)")
                                        #expect(Bool(false))
                                        return
                                    }
                                    if piece.node !== node {
                                        print("node mis-match (piece)")
                                        #expect(Bool(false))
                                        return
                                    }
                                    if piece.chunk !== chunk {
                                        print("node mis-match (piece)")
                                        #expect(Bool(false))
                                        return
                                    }
                                    number_verified += 1
                                }
                            }
                        }
                    }
                }
            }
            print("number_verified was \(number_verified)")
        }
    }
    
    @Test func test_prepare_and_snap_minimum_one_piece_size_24() {
        
        let piece = SkeletonPiece(id: 0,
                                  pieceIdentifier: .unknown,
                                  size: 24)
        let chunk = SkeletonChunkFixed(id: 0,
                                       chunkIdentifier: .unknown,
                                       piece: piece,
                                       alignment: .left)
        let node = GenerateNodes.generate_node(id: 0, chunk: chunk)
        
        let section = SkeletonSection(id: 0, layoutNodes: [node], alignment: .left)
        section.adopt_test()
        let row = SkeletonRow(sections: [section], attemptedCenteredSection: nil)
        let page = SkeletonPage(rows: [row])
        
        SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: [page],
                                                                       menuWidthWithSafeArea: 1024,
                                                                       safeAreaLeft: 0,
                                                                       safeAreaRight: 0)
        
        if piece.currentSize != 24 {
            #expect(Bool(false))
            return
        }
        
        if chunk.currentSize != 24 {
            #expect(Bool(false))
            return
        }
        
        if chunk.children_size != 24 {
            #expect(Bool(false))
            return
        }
        
        if node.skeletonNodes[0].currentSize != 24 {
            #expect(Bool(false))
            return
        }
        
        if node.skeletonNodes[0].children_size != 24 {
            #expect(Bool(false))
            return
        }
        
        if section.currentSize != 24 {
            #expect(Bool(false))
            return
        }
        
        if section.children_size != 24 {
            #expect(Bool(false))
            return
        }
        
        if row.children_size != 24 {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_snap_to_most_compressed_possible_larger_manual_test() {
        
        for _ in 0..<10000 {
            let piece_a = SkeletonPiece(id: 0, pieceIdentifier: .unknown,size: 4)
            let piece_b = SkeletonPiece(id: 0, pieceIdentifier: .unknown,size: 40)
            let piece_c = SkeletonPiece(id: 0, pieceIdentifier: .unknown,size: 400)
            let piece_d = SkeletonPiece(id: 0, pieceIdentifier: .unknown,size: 4000)
            let piece_e = SkeletonPiece(id: 0, pieceIdentifier: .unknown,size: 40000)
            let piece_f = SkeletonPiece(id: 0, pieceIdentifier: .unknown,size: 400000)
            let piece_g = SkeletonPiece(id: 0, pieceIdentifier: .unknown,size: 4000000)
            let piece_h = SkeletonPiece(id: 0, pieceIdentifier: .unknown,size: 40000000)
            
            let flexer_a = GenerateFlexers.generate_10_random_climb()
            let flexer_b = GenerateFlexers.generate_10_random_climb()
            let flexer_c = GenerateFlexers.generate_10_random_climb()
            let flexer_d = GenerateFlexers.generate_10_random_climb()
            let flexer_e = GenerateFlexers.generate_10_random_climb()
            let flexer_f = GenerateFlexers.generate_10_random_climb()
            let flexer_g = GenerateFlexers.generate_10_random_climb()
            let flexer_h = GenerateFlexers.generate_10_random_climb()
            let flexer_i = GenerateFlexers.generate_10_random_climb()
            let flexer_j = GenerateFlexers.generate_10_random_climb()
            let flexer_k = GenerateFlexers.generate_10_random_climb()
            
            //4
            let chunk_a = SkeletonChunkFixed(id: 0,
                                             chunkIdentifier: .unknown,
                                             piece: piece_a, alignment: .left)
            
            //0
            let chunk_b = SkeletonChunkFlexer(id: 1,
                                              chunkIdentifier: .unknown,
                                              flexer: flexer_a, alignment: .left)
            
            //0
            let chunk_c = SkeletonChunkPadding(id: 2,
                                               chunkIdentifier: .unknown,
                                               left: flexer_b, right: flexer_c, alignment: .center)
            
            //40
            let chunk_d = SkeletonChunkHeroStacked(id: 3,
                                                   chunkIdentifier: .unknown,
                                                   left: flexer_d, center: piece_b, right: flexer_e, alignment: .right)
            
            //400 + 4000 = 4400
            let chunk_e = SkeletonChunkHeroLong(id: 4,
                                                chunkIdentifier: .unknown,
                                                left: flexer_e, icon: piece_c, spacing: flexer_f, label: piece_d,
                                                right: flexer_g, alignment: .left)
            
            //40000 + 400000 = 440000
            let chunk_f = SkeletonChunkHeroLong(id: 5,
                                                chunkIdentifier: .unknown,
                                                left: flexer_e, icon: piece_e, spacing: flexer_h, label: piece_f,
                                                right: flexer_i, alignment: .left)
            
            //4000000
            let chunk_g = SkeletonChunkHeroStacked(id: 6,
                                                   chunkIdentifier: .unknown,
                                                   left: flexer_j, center: piece_g, right: flexer_k, alignment: .right)
            
            //40000000
            let chunk_h = SkeletonChunkFixed(id: 7,
                                             chunkIdentifier: .unknown,
                                             piece: piece_h, alignment: .left)
            
            
            //4
            let node_a = GenerateNodes.generate_node(id: 0, chunks: [chunk_a, chunk_b])
            
            //40 + 4400 = 4440
            let node_b = GenerateNodes.generate_node(id: 1, chunks: [chunk_c, chunk_d, chunk_e])
            
            
            //440000
            let node_c = GenerateNodes.generate_node(id: 2, chunks: [chunk_f])
            
            
            //4000000 + 40000000 = 44000000
            let node_d = GenerateNodes.generate_node(id: 3, chunks: [chunk_g, chunk_h])
            
            
            //4440 + 4 = 4444
            let section_a = SkeletonSection(id: 0, layoutNodes: [node_a, node_b], alignment: .left)
            section_a.adopt_test()
            
            //440000
            let section_b = SkeletonSection(id: 1, layoutNodes: [node_c], alignment: .left)
            section_b.adopt_test()
            
            //44000000
            let section_c = SkeletonSection(id: 2, layoutNodes: [node_d], alignment: .left)
            section_c.adopt_test()
            
            //4444 + 440000 + 44000000 = 44444444
            let row = SkeletonRow(sections: [section_a, section_b, section_c], attemptedCenteredSection: nil)
            let page = SkeletonPage(rows: [row])
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: [page],
                                                                           menuWidthWithSafeArea: 2048,
                                                                           safeAreaLeft: 64,
                                                                           safeAreaRight: 64)
            
            if chunk_a.currentSize != 4 {
                #expect(Bool(false))
                return
            }
            
            if chunk_a.children_size != 4 {
                #expect(Bool(false))
                return
            }
            
            if chunk_b.currentSize != 0 {
                #expect(Bool(false))
                return
            }
            
            if chunk_b.children_size != 0 {
                #expect(Bool(false))
                return
            }
            
            if chunk_c.currentSize != 0 {
                #expect(Bool(false))
                return
            }
            
            if chunk_c.children_size != 0 {
                #expect(Bool(false))
                return
            }
            
            if chunk_d.currentSize != 40 {
                #expect(Bool(false))
                return
            }
            
            if chunk_d.children_size != 40 {
                #expect(Bool(false))
                return
            }
            
            if chunk_e.currentSize != 4400 {
                #expect(Bool(false))
                return
            }
            
            if chunk_e.children_size != 4400 {
                #expect(Bool(false))
                return
            }
            
            if chunk_f.currentSize != 440000 {
                #expect(Bool(false))
                return
            }
            
            if chunk_f.children_size != 440000 {
                #expect(Bool(false))
                return
            }
            
            if chunk_g.currentSize != 4000000 {
                #expect(Bool(false))
                return
            }
            
            if chunk_g.children_size != 4000000 {
                #expect(Bool(false))
                return
            }
            
            if chunk_h.currentSize != 40000000 {
                #expect(Bool(false))
                return
            }
            
            if chunk_h.children_size != 40000000 {
                #expect(Bool(false))
                return
            }
            
            if node_a.skeletonNodes[0].currentSize != 4 {
                #expect(Bool(false))
                return
            }
            
            if node_a.skeletonNodes[0].children_size != 4 {
                #expect(Bool(false))
                return
            }
            
            if node_b.skeletonNodes[0].currentSize != 4440 {
                #expect(Bool(false))
                return
            }
            
            if node_b.skeletonNodes[0].children_size != 4440 {
                #expect(Bool(false))
                return
            }
            
            if node_c.skeletonNodes[0].currentSize != 440000 {
                #expect(Bool(false))
                return
            }
            
            if node_c.skeletonNodes[0].children_size != 440000 {
                #expect(Bool(false))
                return
            }
            
            if node_d.skeletonNodes[0].currentSize != 44000000 {
                #expect(Bool(false))
                return
            }
            
            if node_d.skeletonNodes[0].children_size != 44000000 {
                #expect(Bool(false))
                return
            }
            
            if section_a.currentSize != 4444 {
                #expect(Bool(false))
                return
            }
            
            if section_a.children_size != 4444 {
                #expect(Bool(false))
                return
            }
            
            if section_b.currentSize != 440000 {
                #expect(Bool(false))
                return
            }
            
            if section_b.children_size != 440000 {
                #expect(Bool(false))
                return
            }
            
            if section_c.currentSize != 44000000 {
                #expect(Bool(false))
                return
            }
            
            if section_c.children_size != 44000000 {
                #expect(Bool(false))
                return
            }
            
            if row.children_size != 44444444 {
                #expect(Bool(false))
                return
            }
        }
    }
    
}
