//
//  GrowthPlanTests_Wild_Flexers.swift
//  OphiuchusTests
//
//  Created by Nick on 8/3/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct GrowthPlanTests_Wild_Flexers {
    
    @MainActor @Test func test_growth_plan_wild_flexers_failed_small_case_a() {
        
        let flexers = GenerateFlexers.generate_n_flexers(n: 5)
        let chunk = GenerateChunks.generate_flexers(flexers: flexers)
        let row = GenerateRows.generate_Row(chunk: chunk)
        
        let flexersGroup = ExploderGroup<Flexer>(linkedList: flexers, layoutPriority: .required)
        let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexersGroup)
        
        let rows = [row]
        if !GrowthPlanValidator.checkFlexers(pRows: rows,
                                             pFlexers: flexers,
                                             pRowGrowthPlansList: pRowGrowthPlansList) {
            #expect(Bool(false))
            return
        }
        
    }
    
    @MainActor @Test func test_growth_plan_wild_flexers_failed_small_case_b() {
        
        let chunk_c = GenerateChunks.generate_flexer()
        let chunk_d = GenerateChunks.generate_flexer()
        let flexers = [chunk_c.flexers[0],
                       chunk_d.flexers[0]]
        
        let node_b = GenerateNodes.generate_skeleton_node(chunks: [chunk_c, chunk_d])
        node_b.currentSize = 4
        node_b.childrenSize = 3
        
        let section_c = GenerateSections.generate_section(skeleton_nodes: [node_b])
        
        
        let row = GenerateRows.generate_Row(sections: [section_c])
        
        let flexersGroup = ExploderGroup<Flexer>(linkedList: flexers, layoutPriority: .required)
        let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexersGroup)
        
        let rows = [row]
        if !GrowthPlanValidator.checkFlexers(pRows: rows,
                                             pFlexers: flexers,
                                             pRowGrowthPlansList: pRowGrowthPlansList) {
            #expect(Bool(false))
            return
        }
        
    }
    
    @MainActor @Test func test_growth_plan_wild_flexers_small_test_1_row() {
        for _ in 0..<2048 {
            
            let sectionCount = Int.random(in: 0..<6)
            var sections_final = [SkeletonSection]()
            var sections_trash = [SkeletonSection]()
            
            var flexers_final = [Flexer]()
            var flexers_trash = [Flexer]()
            
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
                        
                        let flexerCount = Int.random(in: 0..<16)
                        let flexers = GenerateFlexers.generate_n_flexers(n: flexerCount)
                        
                        flexers_trash.append(contentsOf: flexers)
                        
                        
                        let chunk = GenerateChunks.generate_gapped(flexers: flexers, gap: chunk_gap)
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
                                    
                                    for flexer in chunk.flexers {
                                        if Bool.random() {
                                            flexers_final.append(flexer)
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
            
            
            let flexersGroup = ExploderGroup<Flexer>(linkedList: flexers_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexersGroup)
            
            let rows = [row]
            if !GrowthPlanValidator.checkFlexers(pRows: rows,
                                                 pFlexers: flexers_final,
                                                 pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_flexers_small_test_1_row_shuffled() {
        for _ in 0..<2048 {
            
            let sectionCount = Int.random(in: 0..<6)
            var sections_final = [SkeletonSection]()
            var sections_trash = [SkeletonSection]()
            
            var flexers_final = [Flexer]()
            var flexers_trash = [Flexer]()
            
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
                        
                        let flexerCount = Int.random(in: 0..<16)
                        var flexers = GenerateFlexers.generate_n_flexers(n: flexerCount)
                        
                        flexers_trash.append(contentsOf: flexers)
                        
                        flexers.shuffle()
                        let chunk = GenerateChunks.generate_gapped(flexers: flexers, gap: chunk_gap)
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
                                    
                                    for flexer in chunk.flexers {
                                        if Bool.random() {
                                            flexers_final.append(flexer)
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
            
            
            let flexersGroup = ExploderGroup<Flexer>(linkedList: flexers_final, layoutPriority: .required)
            var pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexersGroup)
            pRowGrowthPlansList.shuffle()
            
            let rows = [row]
            if !GrowthPlanValidator.checkFlexers(pRows: rows,
                                                 pFlexers: flexers_final,
                                                 pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_flexers_small_test_n_rows() {
        for _ in 0..<2048 {
            
            let rowCount = Int.random(in: 0..<8)
            var rows = [SkeletonRow]()
            var flexers_final = [Flexer]()
            var flexers_trash = [Flexer]()
            
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
                            
                            let flexerCount = Int.random(in: 0..<16)
                            let flexers = GenerateFlexers.generate_n_flexers(n: flexerCount)
                            
                            flexers_trash.append(contentsOf: flexers)
                            
                            
                            let chunk = GenerateChunks.generate_gapped(flexers: flexers, gap: chunk_gap)
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
                                        
                                        for flexer in chunk.flexers {
                                            if Bool.random() {
                                                flexers_final.append(flexer)
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
            
            let flexersGroup = ExploderGroup<Flexer>(linkedList: flexers_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexersGroup)
            
            if !GrowthPlanValidator.checkFlexers(pRows: rows,
                                                 pFlexers: flexers_final,
                                                 pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_flexers_small_test_n_rows_shuffled() {
        for _ in 0..<2048 {
            
            let rowCount = Int.random(in: 0..<8)
            var rows = [SkeletonRow]()
            var rows_orphaned = [SkeletonRow]()
            
            var flexers_final = [Flexer]()
            var flexers_trash = [Flexer]()
            
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
                            
                            let flexerCount = Int.random(in: 0..<16)
                            var flexers = GenerateFlexers.generate_n_flexers(n: flexerCount)
                            
                            flexers.shuffle()
                            
                            flexers_trash.append(contentsOf: flexers)
                            
                            
                            let chunk = GenerateChunks.generate_gapped(flexers: flexers, gap: chunk_gap)
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
                                        for flexer in chunk.flexers {
                                            if Bool.random() {
                                                flexers_final.append(flexer)
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
            
            let flexersGroup = ExploderGroup<Flexer>(linkedList: flexers_final, layoutPriority: .required)
            var pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexersGroup)
            pRowGrowthPlansList.shuffle()
            
            if !GrowthPlanValidator.checkFlexers(pRows: rows,
                                                 pFlexers: flexers_final,
                                                 pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
}
