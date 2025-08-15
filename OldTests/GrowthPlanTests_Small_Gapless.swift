//
//  GrowthPlanTests_Small.swift
//  OphiuchusTests
//
//  Created by Nick on 8/3/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct GrowthPlanTests_Small_Gapless {
    
    @MainActor @Test func test_growth_plan_1_flexer() {
        
        let flexer_a = GenerateFlexers.generate_flexer(10)
        let chunk_a = GenerateChunks.generate_flexer(flexer: flexer_a)
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
        guard growthPlan.amount == 1 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_2_flexer_a() {
        
        let flexer_a = GenerateFlexers.generate_flexer(10)
        let flexer_b = GenerateFlexers.generate_flexer(10)
        let chunk_a = GenerateChunks.generate_flexer_two(flexer1: flexer_a, flexer2: flexer_b)
        let node_a = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        let row = GenerateRows.generate_Row(section: section)
        
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a, flexer_b], layoutPriority: .required)
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
        guard growthPlan.amount == 2 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_2_flexer_b() {
        
        let flexer_a = GenerateFlexers.generate_flexer(10)
        let flexer_b = GenerateFlexers.generate_flexer(10)
        let chunk_a = GenerateChunks.generate_flexer(flexer: flexer_a)
        let chunk_b = GenerateChunks.generate_flexer(flexer: flexer_b)
        let node_a = GenerateNodes.generate_skeleton_node(chunks: [chunk_a, chunk_b])
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        let row = GenerateRows.generate_Row(section: section)
        
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a, flexer_b], layoutPriority: .required)
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
        guard growthPlan.amount == 2 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_2_flexer_c() {
        
        let flexer_a = GenerateFlexers.generate_flexer(10)
        let flexer_b = GenerateFlexers.generate_flexer(10)
        let chunk_a = GenerateChunks.generate_flexer(flexer: flexer_a)
        let chunk_b = GenerateChunks.generate_flexer(flexer: flexer_b)
        let node_a = GenerateNodes.generate_skeleton_node(chunks: [chunk_a])
        let node_b = GenerateNodes.generate_skeleton_node(chunks: [chunk_b])
        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b])
        let row = GenerateRows.generate_Row(section: section)
        
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a, flexer_b], layoutPriority: .required)
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
        guard growthPlan.amount == 2 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_2_flexer_d() {
        
        let flexer_a = GenerateFlexers.generate_flexer(10)
        let flexer_b = GenerateFlexers.generate_flexer(10)
        let chunk_a = GenerateChunks.generate_flexer(flexer: flexer_a)
        let chunk_b = GenerateChunks.generate_flexer(flexer: flexer_b)
        let node_a = GenerateNodes.generate_skeleton_node(chunks: [chunk_a])
        let node_b = GenerateNodes.generate_skeleton_node(chunks: [chunk_b])
        let section_a = GenerateSections.generate_section(skeleton_nodes: [node_a])
        let section_b = GenerateSections.generate_section(skeleton_nodes: [node_b])
        
        let row = GenerateRows.generate_Row(sections: [section_a, section_b])
        
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a, flexer_b], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
        
        guard rowGrowthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        
        let rowGrowthPlan = rowGrowthPlans[0]
        guard rowGrowthPlan.growthPlans.count == 2 else {
            #expect(Bool(false))
            return
        }
        let growthPlan1 = rowGrowthPlan.growthPlans[0]
        guard growthPlan1.amount == 1 else {
            #expect(Bool(false))
            return
        }
        let growthPlan2 = rowGrowthPlan.growthPlans[1]
        guard growthPlan2.amount == 1 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_1_chunk() {
        
        let chunk_a = GenerateChunks.generate_fixed(size: 10)
        let node_a = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        let row = GenerateRows.generate_Row(section: section)
        let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: [chunk_a], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                                     chunkListCount: chunkGroup.linkedList.count,
                                                                                     elementAmountList: [1])
        
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
        guard growthPlan.amount == 1 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_2_chunks_a() {
        
        let chunk_a = GenerateChunks.generate_fixed(size: 10)
        let chunk_b = GenerateChunks.generate_fixed(size: 10)
        let node_a = GenerateNodes.generate_skeleton_node(chunks: [chunk_a, chunk_b])
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        let row = GenerateRows.generate_Row(section: section)
        let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: [chunk_a, chunk_b], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                                     chunkListCount: chunkGroup.linkedList.count,
                                                                                     elementAmountList: [1, 1])
        
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
        guard growthPlan.amount == 2 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_2_chunks_b() {
        
        let chunk_a = GenerateChunks.generate_fixed(size: 10)
        let chunk_b = GenerateChunks.generate_fixed(size: 10)
        let node_a = GenerateNodes.generate_skeleton_node(chunks: [chunk_a])
        let node_b = GenerateNodes.generate_skeleton_node(chunks: [chunk_b])
        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b])
        let row = GenerateRows.generate_Row(section: section)
        let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: [chunk_a, chunk_b], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                                     chunkListCount: chunkGroup.linkedList.count,
                                                                                     elementAmountList: [1, 1])
        
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
        guard growthPlan.amount == 2 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_2_chunks_c() {
        
        let chunk_a = GenerateChunks.generate_fixed(size: 10)
        let chunk_b = GenerateChunks.generate_fixed(size: 10)
        let node_a = GenerateNodes.generate_skeleton_node(chunks: [chunk_a])
        let node_b = GenerateNodes.generate_skeleton_node(chunks: [chunk_b])
        let section_a = GenerateSections.generate_section(skeleton_nodes: [node_a])
        let section_b = GenerateSections.generate_section(skeleton_nodes: [node_b])
        let row = GenerateRows.generate_Row(sections: [section_a, section_b])
        let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: [chunk_a, chunk_b], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                                     chunkListCount: chunkGroup.linkedList.count,
                                                                                     elementAmountList: [1, 1])
        
        guard rowGrowthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        
        let rowGrowthPlan = rowGrowthPlans[0]
        guard rowGrowthPlan.growthPlans.count == 2 else {
            #expect(Bool(false))
            return
        }
        let growthPlan1 = rowGrowthPlan.growthPlans[0]
        guard growthPlan1.amount == 1 else {
            #expect(Bool(false))
            return
        }
        let growthPlan2 = rowGrowthPlan.growthPlans[1]
        guard growthPlan2.amount == 1 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_1_node() {
        let node_a = GenerateNodes.generate_fixed(size: 10)
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        let row = GenerateRows.generate_Row(section: section)
        let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: [node_a], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                                    nodeListCount: nodeGroup.linkedList.count,
                                                                                    nodeAmountList: [1])
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
        guard growthPlan.amount == 1 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_2_nodes_a() {
        let node_a = GenerateNodes.generate_fixed(size: 10)
        let node_b = GenerateNodes.generate_fixed(size: 10)
        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b])
        let row = GenerateRows.generate_Row(section: section)
        let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: [node_a, node_b], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                                    nodeListCount: nodeGroup.linkedList.count,
                                                                                    nodeAmountList: [1, 1])
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
        guard growthPlan.amount == 2 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_2_nodes_b() {
        let node_a = GenerateNodes.generate_fixed(size: 10)
        let node_b = GenerateNodes.generate_fixed(size: 10)
        let section_a = GenerateSections.generate_section(skeleton_nodes: [node_a])
        let section_b = GenerateSections.generate_section(skeleton_nodes: [node_b])
        
        let row = GenerateRows.generate_Row(sections: [section_a, section_b])
        let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: [node_a, node_b], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                                    nodeListCount: nodeGroup.linkedList.count,
                                                                                    nodeAmountList: [1, 1])
        guard rowGrowthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        
        let rowGrowthPlan = rowGrowthPlans[0]
        guard rowGrowthPlan.growthPlans.count == 2 else {
            #expect(Bool(false))
            return
        }
        let growthPlan1 = rowGrowthPlan.growthPlans[0]
        guard growthPlan1.amount == 1 else {
            #expect(Bool(false))
            return
        }
        let growthPlan2 = rowGrowthPlan.growthPlans[1]
        guard growthPlan2.amount == 1 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_1_section() {
        
        let section_a = GenerateSections.generate_section_already_placed(x: 0, width: 100)
        let row = GenerateRows.generate_Row(section: section_a)
        let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: [section_a], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForSections(sectionList: sectionGroup.linkedList,
                                                                                       sectionListCount: sectionGroup.linkedList.count,
                                                                                       sectionAmountList: [1])
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
        guard growthPlan.amount == 1 else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_growth_plan_2_sections() {
        
        let section_a = GenerateSections.generate_section_already_placed(x: 0, width: 100)
        let section_b = GenerateSections.generate_section_already_placed(x: 0, width: 100)
        let row = GenerateRows.generate_Row(sections: [section_a, section_b])
        let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: [section_a, section_b], layoutPriority: .required)
        let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForSections(sectionList: sectionGroup.linkedList,
                                                                                       sectionListCount: sectionGroup.linkedList.count,
                                                                                       sectionAmountList: [1, 1])
        guard rowGrowthPlans.count == 1 else {
            #expect(Bool(false))
            return
        }
        
        let rowGrowthPlan = rowGrowthPlans[0]
        guard rowGrowthPlan.growthPlans.count == 2 else {
            #expect(Bool(false))
            return
        }
        let growthPlan1 = rowGrowthPlan.growthPlans[0]
        guard growthPlan1.amount == 1 else {
            #expect(Bool(false))
            return
        }
        let growthPlan2 = rowGrowthPlan.growthPlans[1]
        guard growthPlan2.amount == 1 else {
            #expect(Bool(false))
            return
        }
    }
    
}
