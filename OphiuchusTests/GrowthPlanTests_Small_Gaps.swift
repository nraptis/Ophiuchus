//
//  GrowthPlanTests_Small_Gaps.swift
//  OphiuchusTests
//
//  Created by Nick on 8/3/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct GrowthPlanTests_Small_Gaps {
    
    @MainActor @Test func test_growth_plan_1_flexer_1_gap_at_chunk() {
        
        let flexer_a = GenerateFlexers.generate_flexer(10)
        let chunk_a = GenerateChunks.generate_flexer(flexer: flexer_a)
        chunk_a.children_size = 9
        chunk_a.currentSize = 10
        
        let node_a = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        let row = GenerateRows.generate_Row(section: section)
        
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
        
        guard rowGrowthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        
        let rowGrowthPlan = rowGrowthPlans[0]
        guard rowGrowthPlan.growthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        let growthPlan = rowGrowthPlan.growthPlans[0]
        guard growthPlan.amount == 0 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_1_flexer_1_gap_at_node() {
        
        let flexer_a = GenerateFlexers.generate_flexer(10)
        let chunk_a = GenerateChunks.generate_flexer(flexer: flexer_a)
        let node_a = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
        node_a.childrenSize = 9
        node_a.currentSize = 10
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        let row = GenerateRows.generate_Row(section: section)
        
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
        
        guard rowGrowthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        
        let rowGrowthPlan = rowGrowthPlans[0]
        guard rowGrowthPlan.growthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        let growthPlan = rowGrowthPlan.growthPlans[0]
        guard growthPlan.amount == 0 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_1_flexer_1_gap_at_section() {
        
        let flexer_a = GenerateFlexers.generate_flexer(10)
        let chunk_a = GenerateChunks.generate_flexer(flexer: flexer_a)
        let node_a = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        section.childrenSize = 9
        section.currentSize = 10
        let row = GenerateRows.generate_Row(section: section)
        
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
        
        guard rowGrowthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        
        let rowGrowthPlan = rowGrowthPlans[0]
        guard rowGrowthPlan.growthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        let growthPlan = rowGrowthPlan.growthPlans[0]
        guard growthPlan.amount == 0 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_1_chunk_1_gap_at_node() {
        
        let chunk_a = GenerateChunks.generate_fixed()
        
        let node_a = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
        node_a.childrenSize = 9
        node_a.currentSize = 10
        
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        let row = GenerateRows.generate_Row(section: section)
        
        let chunkGroup = ExploderGroupChunks(linkedList: [chunk_a], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                                     chunkListCount: chunkGroup.linkedList.count,
                                                                                     elementAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
        
        guard rowGrowthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        
        let rowGrowthPlan = rowGrowthPlans[0]
        guard rowGrowthPlan.growthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        let growthPlan = rowGrowthPlan.growthPlans[0]
        guard growthPlan.amount == 0 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_1_chunk_1_gap_at_section() {
        
        let chunk_a = GenerateChunks.generate_fixed()
        
        let node_a = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
        
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        section.childrenSize = 9
        section.currentSize = 10
        
        let row = GenerateRows.generate_Row(section: section)
        
        let chunkGroup = ExploderGroupChunks(linkedList: [chunk_a], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                                     chunkListCount: chunkGroup.linkedList.count,
                                                                                     elementAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
        
        guard rowGrowthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        
        let rowGrowthPlan = rowGrowthPlans[0]
        guard rowGrowthPlan.growthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        let growthPlan = rowGrowthPlan.growthPlans[0]
        guard growthPlan.amount == 0 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_1_node_1_gap_at_section() {
        
        let node_a = GenerateNodes.generate_fixed(size: 10)
        
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        section.childrenSize = 9
        section.currentSize = 10
        
        let row = GenerateRows.generate_Row(section: section)
        
        let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: [node_a], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                                    nodeListCount: nodeGroup.linkedList.count,
                                                                                    nodeAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
        
        guard rowGrowthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        
        let rowGrowthPlan = rowGrowthPlans[0]
        guard rowGrowthPlan.growthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        let growthPlan = rowGrowthPlan.growthPlans[0]
        guard growthPlan.amount == 0 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_sweep_3_flexer_sweep_10_gap_at_chunk() {
        
        for _ in 0..<128 {
            for flexer_count in 1...3 {
                
                for gap_count in 0...10 {
                    
                    let flexers = GenerateFlexers.generate_n_flexers(n: flexer_count)
                    
                    var chunk: any SkeletonChunkConforming
                    if flexers.count == 1 {
                        chunk = GenerateChunks.generate_flexer(flexer: flexers[0])
                    } else if flexers.count == 2 {
                        chunk = GenerateChunks.generate_flexer_two(flexer1: flexers[0],
                                                                   flexer2: flexers[1])
                    } else {
                        chunk = GenerateChunks.generate_flexer_three(flexer1: flexers[0],
                                                                     flexer2: flexers[1],
                                                                     flexer3: flexers[2])
                    }
                    
                    let amount = Int.random(in: 0...100)
                    chunk.children_size = amount
                    chunk.currentSize = amount + gap_count
                    
                    let node = GenerateNodes.generate_skeleton_node(chunk: chunk)
                    let section = GenerateSections.generate_section(skeleton_node: node)
                    let row = GenerateRows.generate_Row(section: section)
                    
                    let flexerGroup = ExploderGroup<Flexer>(linkedList: flexers, layoutPriority: .required)
                    let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
                    
                    guard rowGrowthPlans.count == 1 else {
                        #expect(Bool(false))
                        return
                    }
                    
                    let rowGrowthPlan = rowGrowthPlans[0]
                    guard rowGrowthPlan.growthPlans.count == 1 else {
                        #expect(Bool(false))
                        return
                    }
                    
                    var expectedAmount = (flexer_count - gap_count)
                    if expectedAmount < 0 {
                        expectedAmount = 0
                    }
                    
                    let growthPlan = rowGrowthPlan.growthPlans[0]
                    guard growthPlan.amount == expectedAmount else {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_sweep_3_flexer_sweep_10_gap_at_node() {
        for _ in 0..<128 {
            for flexer_count in 1...3 {
                
                for gap_count in 0...10 {
                    
                    let flexers = GenerateFlexers.generate_n_flexers(n: flexer_count)
                    
                    var chunk: any SkeletonChunkConforming
                    if flexers.count == 1 {
                        chunk = GenerateChunks.generate_flexer(flexer: flexers[0])
                    } else if flexers.count == 2 {
                        chunk = GenerateChunks.generate_flexer_two(flexer1: flexers[0],
                                                                   flexer2: flexers[1])
                    } else {
                        chunk = GenerateChunks.generate_flexer_three(flexer1: flexers[0],
                                                                     flexer2: flexers[1],
                                                                     flexer3: flexers[2])
                    }
                    
                    let amount = Int.random(in: 0...100)
                    let node = GenerateNodes.generate_skeleton_node(chunk: chunk)
                    node.childrenSize = amount
                    node.currentSize = amount + gap_count
                    let section = GenerateSections.generate_section(skeleton_node: node)
                    let row = GenerateRows.generate_Row(section: section)
                    
                    let flexerGroup = ExploderGroup<Flexer>(linkedList: flexers, layoutPriority: .required)
                    let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
                    
                    guard rowGrowthPlans.count == 1 else {
                        #expect(Bool(false))
                        return
                    }
                    
                    let rowGrowthPlan = rowGrowthPlans[0]
                    guard rowGrowthPlan.growthPlans.count == 1 else {
                        #expect(Bool(false))
                        return
                    }
                    
                    var expectedAmount = (flexer_count - gap_count)
                    if expectedAmount < 0 {
                        expectedAmount = 0
                    }
                    
                    let growthPlan = rowGrowthPlan.growthPlans[0]
                    guard growthPlan.amount == expectedAmount else {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_sweep_3_flexer_sweep_10_gap_at_section() {
        for _ in 0..<128 {
            for flexer_count in 1...3 {
                
                for gap_count in 0...10 {
                    
                    let flexers = GenerateFlexers.generate_n_flexers(n: flexer_count)
                    
                    var chunk: any SkeletonChunkConforming
                    if flexers.count == 1 {
                        chunk = GenerateChunks.generate_flexer(flexer: flexers[0])
                    } else if flexers.count == 2 {
                        chunk = GenerateChunks.generate_flexer_two(flexer1: flexers[0],
                                                                   flexer2: flexers[1])
                    } else {
                        chunk = GenerateChunks.generate_flexer_three(flexer1: flexers[0],
                                                                     flexer2: flexers[1],
                                                                     flexer3: flexers[2])
                    }
                    
                    let amount = Int.random(in: 0...100)
                    let node = GenerateNodes.generate_skeleton_node(chunk: chunk)
                    let section = GenerateSections.generate_section(skeleton_node: node)
                    section.childrenSize = amount
                    section.currentSize = amount + gap_count
                    let row = GenerateRows.generate_Row(section: section)
                    
                    let flexerGroup = ExploderGroup<Flexer>(linkedList: flexers, layoutPriority: .required)
                    let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
                    
                    guard rowGrowthPlans.count == 1 else {
                        #expect(Bool(false))
                        return
                    }
                    
                    let rowGrowthPlan = rowGrowthPlans[0]
                    guard rowGrowthPlan.growthPlans.count == 1 else {
                        #expect(Bool(false))
                        return
                    }
                    
                    var expectedAmount = (flexer_count - gap_count)
                    if expectedAmount < 0 {
                        expectedAmount = 0
                    }
                    
                    let growthPlan = rowGrowthPlan.growthPlans[0]
                    guard growthPlan.amount == expectedAmount else {
                        #expect(Bool(false))
                        return
                    }
                    
                    
                }
                
            }
            
        }
        
    }
    
}
