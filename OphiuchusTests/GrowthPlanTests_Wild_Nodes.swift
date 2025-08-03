//
//  GrowthPlanTests_Wild_Nodes.swift
//  OphiuchusTests
//
//  Created by Nick on 8/3/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct GrowthPlanTests_Wild_Nodes {
    
    func validate(layoutRows: [SkeletonRow],
                  layoutNodes: [SkeletonNode],
                  rowGrowthPlansList: [RowGrowthPlans]) -> Bool {
        
        // We keep in mind, this is for *nodes*
        
        for layoutNode in layoutNodes {
            let nodeRow = layoutNode.row!
            var growthPlanExists = false
            for _rowGrowthPlans in rowGrowthPlansList {
                if _rowGrowthPlans.layoutRow === nodeRow {
                    growthPlanExists = true
                }
            }
            if !growthPlanExists {
                print("Failed! Node \(layoutNode.id) from row \(nodeRow.id) was *not* found in the growth plans!")
                return false
            }
        }
        
        // We compute gap from the top-down.
        for layoutRow in layoutRows {
            
            // If this row has no grow plan, let's make sure it doesn't have any nodes.
            var rowGrowthPlans: RowGrowthPlans?
            for _rowGrowthPlans in rowGrowthPlansList {
                if _rowGrowthPlans.layoutRow === layoutRow {
                    rowGrowthPlans = _rowGrowthPlans
                }
            }
            
            if let rowGrowthPlans = rowGrowthPlans {
                // We have the growth plans...
                
                // First make sure all the growth plan's sections
                // exist in the row...
                for growthPlan in rowGrowthPlans.growthPlans {
                    let layoutSection = growthPlan.layoutSection
                    var existsInRow = false
                    for _layoutSection in layoutRow.sections {
                        if _layoutSection === layoutSection {
                            existsInRow = true
                        }
                    }
                    if !existsInRow {
                        print("Failed! Section \(layoutSection.id) was in row \(layoutRow.id) growth plans, but does not exist in the row.")
                        return false
                    }
                }
                
                for layoutSection in layoutRow.sections {
                    if let growthPlan = rowGrowthPlans.getGrowthPlan(layoutSection: layoutSection) {
                        let nodeCount = layoutSection.skeletonNodes.count
                        if nodeCount > 0 {
                            // Only consider sections that are part of this grow request..
                            let sectionGap = layoutSection.currentSize - layoutSection.childrenSize
                            var _expectedGrowth = (nodeCount - sectionGap)
                            if _expectedGrowth < 0 {
                                _expectedGrowth = 0
                            }
                            if growthPlan.amount != _expectedGrowth {
                                print("Failed! Section \(layoutSection.id) was in row \(layoutRow.id) has growth plans for \(growthPlan.amount), but the expected growth was \(_expectedGrowth).")
                                return false
                            }
                        } else {
                            print("Failed! Section \(layoutSection.id) was in row \(layoutRow.id) has growth plans, but no node.")
                            return false
                        }
                    } else {
                        
                        // There is no growth plan for this section
                        // In this case, the *only* was that is true
                        // is if we do not have any nodes.
                        if layoutSection.skeletonNodes.count > 0 {
                            print("Failed! Section \(layoutSection.id) from row \(layoutRow.id) had no growth plans, but it has \(layoutSection.skeletonNodes.count) nodes!")
                            return false
                        }
                    }
                }
            } else {
                for layoutSection in layoutRow.sections {
                    if layoutSection.skeletonNodes.count > 0 {
                        print("Failed! Row \(layoutRow.id) exected to have *ZERO* nodes, section \(layoutSection.id) has \(layoutSection.skeletonNodes.count) nodes!")
                    }
                }
            }
        }
        
        return true
    }
    
    
    @MainActor @Test func test_growth_plan_wild_sections_small_test_1_row_a() {
        for _ in 0..<4096 {
            
            let sectionCount = Int.random(in: 1..<4)
            
            var layoutSections = [SkeletonSection]()
            var layoutNodes = [SkeletonNode]()

            for _ in 0..<sectionCount {
                let nodeCount = Int.random(in: 1..<4)
                let gap = Int.random(in: 1..<4)
                var skeleton_nodes = [SkeletonNode]()
                for _ in 0..<nodeCount {
                    let node = GenerateNodes.generate_skeleton_node(gap: gap)
                    skeleton_nodes.append(node)
                    layoutNodes.append(node)
                }
                
                let layoutSection = GenerateSections.generate_section(skeleton_nodes: skeleton_nodes, gap: gap)
                layoutSections.append(layoutSection)
            }
            
            let row = GenerateRows.generate_Row(sections: layoutSections)
            let layoutRows = [row]
            
            let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: layoutNodes, layoutPriority: .required)
            let rowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                                        nodeListCount: nodeGroup.linkedList.count,
                                                                                        nodeAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            if !validate(layoutRows: layoutRows,
                         layoutNodes: layoutNodes,
                         rowGrowthPlansList: rowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_sections_small_test_1_row_b() {
        for _ in 0..<4096 {
            
            let sectionCount = Int.random(in: 0..<4)
            
            var layoutSections = [SkeletonSection]()
            var layoutNodes = [SkeletonNode]()
            
            for _ in 0..<sectionCount {
                let nodeCount = Int.random(in: 0..<4)
                let gap = Int.random(in: 0..<4)
                var skeleton_nodes = [SkeletonNode]()
                for _ in 0..<nodeCount {
                    let node = GenerateNodes.generate_skeleton_node(gap: gap)
                    skeleton_nodes.append(node)
                    layoutNodes.append(node)
                }
                
                let layoutSection = GenerateSections.generate_section(skeleton_nodes: skeleton_nodes, gap: gap)
                layoutSections.append(layoutSection)
            }
            
            let row = GenerateRows.generate_Row(sections: layoutSections)
            let layoutRows = [row]
            
            let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: layoutNodes, layoutPriority: .required)
            let rowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                                        nodeListCount: nodeGroup.linkedList.count,
                                                                                        nodeAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            if !validate(layoutRows: layoutRows,
                         layoutNodes: layoutNodes,
                         rowGrowthPlansList: rowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_sections_small_test_2_rows() {
        for _ in 0..<4096 {
            
            let sectionCount = Int.random(in: 0..<4)
            
            var layoutSections = [SkeletonSection]()
            var layoutNodes = [SkeletonNode]()
            
            for _ in 0..<sectionCount {
                let nodeCount = Int.random(in: 0..<4)
                let gap = Int.random(in: 1..<8)
                var skeleton_nodes = [SkeletonNode]()
                for _ in 0..<nodeCount {
                    let node = GenerateNodes.generate_skeleton_node(gap: gap)
                    skeleton_nodes.append(node)
                    layoutNodes.append(node)
                }
                
                let layoutSection = GenerateSections.generate_section(skeleton_nodes: skeleton_nodes, gap: gap)
                layoutSections.append(layoutSection)
            }
            
            var sections_a = [SkeletonSection]()
            var sections_b = [SkeletonSection]()
            
            for layoutSection in layoutSections {
                if Bool.random() {
                    sections_a.append(layoutSection)
                } else {
                    sections_b.append(layoutSection)
                }
            }
            
            let row1 = GenerateRows.generate_Row(sections: sections_a)
            let row2 = GenerateRows.generate_Row(sections: sections_b)
            
            
            let layoutRows = [row1, row2]
            
            let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: layoutNodes, layoutPriority: .required)
            let rowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                                        nodeListCount: nodeGroup.linkedList.count,
                                                                                        nodeAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            if !validate(layoutRows: layoutRows,
                         layoutNodes: layoutNodes,
                         rowGrowthPlansList: rowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_sections_small_test_3_rows() {
        
        var process_count_no_sections_and_no_nodes = 0
        var process_count_sections_and_no_nodes = 0
        
        var process_count_not_full = 0
        var process_count_full = 0
        
        for _ in 0..<4096 {
            
            let sectionCount = Int.random(in: 0..<6)
            
            var layoutSections = [SkeletonSection]()
            var layoutNodes = [SkeletonNode]()
            
            for _ in 0..<sectionCount {
                let nodeCount = Int.random(in: 0..<6)
                let gap = Int.random(in: 0..<8)
                var skeleton_nodes = [SkeletonNode]()
                for _ in 0..<nodeCount {
                    let node = GenerateNodes.generate_skeleton_node(gap: gap)
                    skeleton_nodes.append(node)
                    layoutNodes.append(node)
                }
                
                let layoutSection = GenerateSections.generate_section(skeleton_nodes: skeleton_nodes, gap: gap)
                layoutSections.append(layoutSection)
            }
            
            var sections_a = [SkeletonSection]()
            var sections_b = [SkeletonSection]()
            var sections_c = [SkeletonSection]()
            
            for layoutSection in layoutSections {
                let random = Int.random(in: 0...2)
                if random == 0 {
                    sections_a.append(layoutSection)
                }
                if random == 1 {
                    sections_b.append(layoutSection)
                }
                if random == 2 {
                    sections_c.append(layoutSection)
                }
            }
            
            sections_a.shuffle()
            sections_b.shuffle()
            sections_c.shuffle()
            
            let row1 = GenerateRows.generate_Row(sections: sections_a)
            let row2 = GenerateRows.generate_Row(sections: sections_b)
            let row3 = GenerateRows.generate_Row(sections: sections_c)
            
            var layoutRows = [row1, row2, row3]
            
            layoutRows.shuffle()
            
            let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: layoutNodes, layoutPriority: .required)
            let rowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                                        nodeListCount: nodeGroup.linkedList.count,
                                                                                        nodeAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            if !validate(layoutRows: layoutRows,
                         layoutNodes: layoutNodes,
                         rowGrowthPlansList: rowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
            
            
            for layoutRow in layoutRows {
                if layoutRow.countSectionsWithNodes() > 0 {
                    if layoutRow.countSectionsWithoutNodes() > 0 {
                        process_count_not_full += 1
                    } else {
                        process_count_full += 1
                    }
                    
                } else if layoutRow.countSectionsWithoutNodes() > 0 {
                    process_count_sections_and_no_nodes += 1
                } else {
                    process_count_no_sections_and_no_nodes += 1
                }
            }
        }
        print("process_count_full = \(process_count_full)")
        print("process_count_not_full = \(process_count_not_full)")
        print("process_count_sections_and_no_nodes = \(process_count_sections_and_no_nodes)")
        print("process_count_no_sections_and_no_nodes = \(process_count_no_sections_and_no_nodes)")
        
    }
    
}
