//
//  DumpingUpwardPieceTests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/1/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct DumpingUpwardPieceTests {
    
    @MainActor @Test func test_group_piece_1_chunk_1_piece() {
        
        let piece_a = GeneratePieces.generate_piece()
        let chunk_a = GenerateChunks.generate_piece(piece: piece_a)
        let node = GenerateNodes.generate_node(chunks: [chunk_a])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        
        let pieceGroup = ExploderGroup<SkeletonPiece>(linkedList: [piece_a], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: pieceGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[0][0] === piece_a else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_piece_1_chunk_2_piece() {
        let piece_a = GeneratePieces.generate_piece()
        let piece_b = GeneratePieces.generate_piece()
        let chunk_a = GenerateChunks.generate_pieces(pieces: [piece_a, piece_b])
        let node = GenerateNodes.generate_node(chunks: [chunk_a])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let pieceGroup = ExploderGroup<SkeletonPiece>(linkedList: [piece_a, piece_b], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: pieceGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 1 else {
            #expect(Bool(false))
            return
        }
        
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceListCount[0] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[0][0] === piece_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[0][1] === piece_b else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_piece_1_chunk_3_piece() {
        let piece_a = GeneratePieces.generate_piece()
        let piece_b = GeneratePieces.generate_piece()
        let piece_c = GeneratePieces.generate_piece()
        
        let chunk_a = GenerateChunks.generate_pieces(pieces: [piece_a, piece_b, piece_c])
        let node = GenerateNodes.generate_node(chunks: [chunk_a])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let pieceGroup = ExploderGroup<SkeletonPiece>(linkedList: [piece_a, piece_b, piece_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: pieceGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 1 else {
            #expect(Bool(false))
            return
        }
        
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceListCount[0] == 3 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[0][0] === piece_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[0][1] === piece_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[0][2] === piece_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_piece_2_chunk_2_piece() {
        
        let piece_a = GeneratePieces.generate_piece()
        let chunk_a = GenerateChunks.generate_piece(piece: piece_a)
        
        let piece_b = GeneratePieces.generate_piece()
        let chunk_b = GenerateChunks.generate_piece(piece: piece_b)
        
        let node = GenerateNodes.generate_node(chunks: [chunk_a, chunk_b])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let pieceGroup = ExploderGroup<SkeletonPiece>(linkedList: [piece_a, piece_b], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: pieceGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[1] === chunk_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceListCount[1] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[0][0] === piece_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[1][0] === piece_b else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_piece_2_chunk_3_piece_a() {
        
        let piece_a = GeneratePieces.generate_piece()
        let piece_b = GeneratePieces.generate_piece()
        let chunk_a = GenerateChunks.generate_pieces(pieces: [piece_a, piece_b])
        
        let piece_c = GeneratePieces.generate_piece()
        let chunk_b = GenerateChunks.generate_piece(piece: piece_c)
        
        let node = GenerateNodes.generate_node(chunks: [chunk_a, chunk_b])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let pieceGroup = ExploderGroup<SkeletonPiece>(linkedList: [piece_a, piece_b, piece_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: pieceGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[1] === chunk_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceListCount[0] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceListCount[1] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[0][0] === piece_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[0][1] === piece_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[1][0] === piece_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_piece_2_chunk_3_piece_b() {
        
        let piece_a = GeneratePieces.generate_piece()
        let chunk_a = GenerateChunks.generate_piece(piece: piece_a)
        
        let piece_b = GeneratePieces.generate_piece()
        let piece_c = GeneratePieces.generate_piece()
        let chunk_b = GenerateChunks.generate_pieces(pieces: [piece_b, piece_c])
        
        let node = GenerateNodes.generate_node(chunks: [chunk_a, chunk_b])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let pieceGroup = ExploderGroup<SkeletonPiece>(linkedList: [piece_a, piece_b, piece_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: pieceGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[1] === chunk_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceListCount[1] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[0][0] === piece_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[1][0] === piece_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedPieceList[1][1] === piece_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_several_small_groups_512() {
        
        for _ in 0..<512 {
            
            let chunkCount = Int.random(in: 0...4)
            var chunk_list = [SkeletonChunk]()
            var piece_list = [SkeletonPiece]()
            
            for _ in 0..<chunkCount {
                let pieceCount = Int.random(in: 0...4)
                for _ in 0..<pieceCount {
                    let which = Int.random(in: 0...2)
                    if which == 0 {
                        let piece_a = GeneratePieces.generate_piece()
                        let chunk = GenerateChunks.generate_pieces(pieces: [piece_a])
                        piece_list.append(piece_a)
                        chunk_list.append(chunk)
                    } else if which == 1 {
                        let piece_a = GeneratePieces.generate_piece()
                        let piece_b = GeneratePieces.generate_piece()
                        let chunk = GenerateChunks.generate_pieces(pieces: [piece_a, piece_b])
                        piece_list.append(piece_a)
                        piece_list.append(piece_b)
                        chunk_list.append(chunk)
                    } else {
                        let piece_a = GeneratePieces.generate_piece()
                        let piece_b = GeneratePieces.generate_piece()
                        let piece_c = GeneratePieces.generate_piece()
                        let chunk = GenerateChunks.generate_pieces(pieces: [piece_a, piece_b, piece_c])
                        piece_list.append(piece_a)
                        piece_list.append(piece_b)
                        piece_list.append(piece_c)
                        chunk_list.append(chunk)
                    }
                }
            }
            
            let node = GenerateNodes.generate_node(chunks: chunk_list)
            let section = GenerateSections.generate_section(node: node)
            let row = GenerateRows.generate_Row(section: section)
            let pieceGroup = ExploderGroup<SkeletonPiece>(linkedList: piece_list, layoutPriority: .required)
            _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: pieceGroup)
            
            guard SkeletonLayoutGrowthPlanTool.chunkListCount == chunk_list.count else {
                #expect(Bool(false))
                return
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
                guard SkeletonLayoutGrowthPlanTool.chunkList[index] === chunk_list[index] else {
                    #expect(Bool(false))
                    return
                }
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
                guard SkeletonLayoutGrowthPlanTool.groupedPieceListCount[index] == chunk_list[index].children.count else {
                    #expect(Bool(false))
                    return
                }
                
                for piece_index in 0..<SkeletonLayoutGrowthPlanTool.groupedPieceListCount[index] {
                    let piece_1 = SkeletonLayoutGrowthPlanTool.groupedPieceList[index][piece_index]
                    let piece_2 = chunk_list[index].children[piece_index]
                    guard piece_1 === piece_2 else {
                        #expect(Bool(false))
                        return
                    }
                    
                }
            }
        }
        
    }
    
    @MainActor @Test func test_group_several_medium_groups_4096() {
        
        var invalid_tests = 0
        var valid_tests = 0
        
        for _ in 0..<4096 {
            
            let chunkCount = Int.random(in: 0...8)
            var chunk_list = [SkeletonChunk]()
            var piece_list = [SkeletonPiece]()
            
            for _ in 0..<chunkCount {
                let pieceCount = Int.random(in: 0...8)
                
                valid_tests += 1
                
                for _ in 0..<pieceCount {
                    let which = Int.random(in: 0...2)
                    if which == 0 {
                        let piece_a = GeneratePieces.generate_piece()
                        let chunk = GenerateChunks.generate_piece(piece: piece_a)
                        piece_list.append(piece_a)
                        chunk_list.append(chunk)
                    } else if which == 1 {
                        let piece_a = GeneratePieces.generate_piece()
                        let piece_b = GeneratePieces.generate_piece()
                        let chunk = GenerateChunks.generate_pieces(pieces: [piece_a, piece_b])
                        piece_list.append(piece_a)
                        piece_list.append(piece_b)
                        chunk_list.append(chunk)
                    } else {
                        let piece_a = GeneratePieces.generate_piece()
                        let piece_b = GeneratePieces.generate_piece()
                        let piece_c = GeneratePieces.generate_piece()
                        let chunk = GenerateChunks.generate_pieces(pieces: [piece_a, piece_b, piece_c])
                        piece_list.append(piece_a)
                        piece_list.append(piece_b)
                        piece_list.append(piece_c)
                        chunk_list.append(chunk)
                    }
                }
            }
            
            let node = GenerateNodes.generate_node(chunks: chunk_list)
            let section = GenerateSections.generate_section(node: node)
            let row = GenerateRows.generate_Row(section: section)
            let pieceGroup = ExploderGroup<SkeletonPiece>(linkedList: piece_list, layoutPriority: .required)
            _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForPieces(pieceGroup: pieceGroup)
            
            guard SkeletonLayoutGrowthPlanTool.chunkListCount == chunk_list.count else {
                #expect(Bool(false))
                return
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
                guard SkeletonLayoutGrowthPlanTool.chunkList[index] === chunk_list[index] else {
                    #expect(Bool(false))
                    return
                }
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
                guard SkeletonLayoutGrowthPlanTool.groupedPieceListCount[index] == chunk_list[index].children.count else {
                    #expect(Bool(false))
                    return
                }
                
                for piece_index in 0..<SkeletonLayoutGrowthPlanTool.groupedPieceListCount[index] {
                    let piece_1 = SkeletonLayoutGrowthPlanTool.groupedPieceList[index][piece_index]
                    let piece_2 = chunk_list[index].children[piece_index]
                    guard piece_1 === piece_2 else {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
        
        print("Test pieces medium done! (\(invalid_tests) invalid tests and \(valid_tests) valid tests)")
        
    }
    
    
}
