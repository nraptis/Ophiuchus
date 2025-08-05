//
//  GrowthPlanTests_Wild_Chunks.swift
//  OphiuchusTests
//
//  Created by Nick on 8/3/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct GrowthPlanTests_Wild_Chunks {
    
    @MainActor @Test func test_growth_plan_wild_chunks_small_test_1_row() {
        for _ in 0..<2048 {
            
            let sectionCount = Int.random(in: 0..<8)
            var sections_final = [SkeletonSection]()
            var sections_trash = [SkeletonSection]()
            
            
            var chunks_final = [SkeletonChunk]()
            var chunks_trash = [SkeletonChunk]()
            
            for _ in 0..<sectionCount {
                
                let section_gap = Int.random(in: 0...6)
                
                let nodeCount = Int.random(in: 0..<6)
                var nodes = [SkeletonNode]()
                for _ in 0..<nodeCount {
                    
                    let node_gap = Int.random(in: 0...6)
                    
                    let chunkCount = Int.random(in: 0..<12)
                    var chunks = [SkeletonChunk]()
                    
                    for _ in 0..<chunkCount {
                        let chunk = GenerateChunks.generate_fixed(size: 10)
                        chunks.append(chunk)
                        chunks_trash.append(chunk)
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
                                    chunks_final.append(chunk)
                                }
                            }
                        }
                    }
                }
                
                sections_trash.append(section)
            }
            
            let row = GenerateRows.generate_Row(sections: sections_final)
           
            
            let chunksGroup = ExploderGroup<SkeletonChunk>(linkedList: chunks_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunksGroup.linkedList,
                                                                                              chunkListCount: chunksGroup.linkedList.count,
                                                                                              elementAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            let rows = [row]
            if !GrowthPlanValidator.checkChunks(pRows: rows,
                                                pChunks: chunks_final,
                                                pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_chunks_small_test_1_row_shuffled() {
        for _ in 0..<2048 {
            
            let sectionCount = Int.random(in: 0..<8)
            var sections_final = [SkeletonSection]()
            var sections_trash = [SkeletonSection]()
            
            
            var chunks_final = [SkeletonChunk]()
            var chunks_trash = [SkeletonChunk]()
            
            for _ in 0..<sectionCount {
                
                let section_gap = Int.random(in: 0...6)
                
                let nodeCount = Int.random(in: 0..<6)
                var nodes = [SkeletonNode]()
                for _ in 0..<nodeCount {
                    
                    let node_gap = Int.random(in: 0...6)
                    
                    let chunkCount = Int.random(in: 0..<12)
                    var chunks = [SkeletonChunk]()
                    
                    for _ in 0..<chunkCount {
                        let chunk = GenerateChunks.generate_fixed(size: 10)
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
                                    chunks_final.append(chunk)
                                } else {
                                    chunks_trash.append(chunk)
                                }
                            }
                        }
                    }
                }
                
                sections_trash.append(section)
            }
            
            let row = GenerateRows.generate_Row(sections: sections_final)
           
            
            let chunksGroup = ExploderGroup<SkeletonChunk>(linkedList: chunks_final, layoutPriority: .required)
            var pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunksGroup.linkedList,
                                                                                              chunkListCount: chunksGroup.linkedList.count,
                                                                                              elementAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            pRowGrowthPlansList.shuffle()
            
            let rows = [row]
            if !GrowthPlanValidator.checkChunks(pRows: rows,
                                                pChunks: chunks_final,
                                                pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_chunks_small_test_n_rows() {
        for _ in 0..<2048 {
            
            
            let rowCount = Int.random(in: 0..<8)
            var rows = [SkeletonRow]()
            //var rows_orphaned = [SkeletonRow]()
            var chunks_final = [SkeletonChunk]()
            var chunks_trash = [SkeletonChunk]()
            
            for _ in 0..<rowCount {
                
                
                
                let sectionCount = Int.random(in: 0..<8)
                var sections_final = [SkeletonSection]()
                var sections_trash = [SkeletonSection]()
                
                
                for _ in 0..<sectionCount {
                    
                    let section_gap = Int.random(in: 0...6)
                    
                    let nodeCount = Int.random(in: 0..<6)
                    var nodes = [SkeletonNode]()
                    for _ in 0..<nodeCount {
                        
                        let node_gap = Int.random(in: 0...6)
                        
                        let chunkCount = Int.random(in: 0..<12)
                        var chunks = [SkeletonChunk]()
                        
                        for _ in 0..<chunkCount {
                            let chunk = GenerateChunks.generate_fixed(size: 10)
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
                                        chunks_final.append(chunk)
                                    } else {
                                        chunks_trash.append(chunk)
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
            
            let chunksGroup = ExploderGroup<SkeletonChunk>(linkedList: chunks_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunksGroup.linkedList,
                                                                                              chunkListCount: chunksGroup.linkedList.count,
                                                                                              elementAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            if !GrowthPlanValidator.checkChunks(pRows: rows,
                                                pChunks: chunks_final,
                                                pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_chunks_small_test_n_rows_shuffled() {
        for _ in 0..<2048 {
            
            
            let rowCount = Int.random(in: 0..<8)
            var rows = [SkeletonRow]()
            var rows_orphaned = [SkeletonRow]()
            var chunks_final = [SkeletonChunk]()
            var chunks_trash = [SkeletonChunk]()
            
            for _ in 0..<rowCount {
                
                
                
                let sectionCount = Int.random(in: 0..<8)
                var sections_final = [SkeletonSection]()
                var sections_trash = [SkeletonSection]()
                
                
                for _ in 0..<sectionCount {
                    
                    let section_gap = Int.random(in: 0...6)
                    
                    let nodeCount = Int.random(in: 0..<6)
                    var nodes = [SkeletonNode]()
                    for _ in 0..<nodeCount {
                        
                        let node_gap = Int.random(in: 0...6)
                        
                        let chunkCount = Int.random(in: 0..<12)
                        var chunks = [SkeletonChunk]()
                        
                        for _ in 0..<chunkCount {
                            let chunk = GenerateChunks.generate_fixed(size: 10)
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
                                        chunks_final.append(chunk)
                                    } else {
                                        chunks_trash.append(chunk)
                                    }
                                }
                            }
                        }
                    }
                    
                    sections_trash.append(section)
                }
                sections_final.shuffle()
                
                let row = GenerateRows.generate_Row(sections: sections_final)
                if Bool.random() {
                    rows.append(row)
                } else {
                    rows_orphaned.append(row)
                }
                
            }
            
            chunks_final.shuffle()
            
            let chunksGroup = ExploderGroup<SkeletonChunk>(linkedList: chunks_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunksGroup.linkedList,
                                                                                              chunkListCount: chunksGroup.linkedList.count,
                                                                                              elementAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            if !GrowthPlanValidator.checkChunks(pRows: rows,
                                                pChunks: chunks_final,
                                                pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
}
