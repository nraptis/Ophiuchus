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
    
    @MainActor @Test func test_growth_plan_wild_nodes_small_test_1_row() {
        for _ in 0..<2048 {
            
            let sectionCount = Int.random(in: 0..<8)
            var sections_final = [SkeletonSection]()
            var sections_trash = [SkeletonSection]()
            
            
            var nodes_final = [SkeletonNode]()
            var nodes_trash = [SkeletonNode]()
            
            
            for _ in 0..<sectionCount {
                
                let section_gap = Int.random(in: 0...8)
                
                let nodeCount = Int.random(in: 0..<8)
                var nodes = [SkeletonNode]()
                for _ in 0..<nodeCount {
                    let node = GenerateNodes.generate_fixed(size: 10)
                    nodes.append(node)
                }
                
                let section = GenerateSections.generate_section(skeleton_nodes: nodes, gap: section_gap)
                
                if Bool.random() {
                    sections_final.append(section)
                    for node in nodes {
                        if Bool.random() {
                            nodes_final.append(node)
                        }
                    }
                }
                
                sections_trash.append(section)
                for node in nodes {
                    nodes_trash.append(node)
                }
            }
            
            let row = GenerateRows.generate_Row(sections: sections_final)
           
            
            let nodesGroup = ExploderGroup<SkeletonNode>(linkedList: nodes_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodesGroup.linkedList,
                                                                                             nodeListCount: nodesGroup.linkedList.count,
                                                                                             nodeAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            let rows = [row]
            if !GrowthPlanValidator.checkNodes(pRows: rows,
                                               pNodes: nodes_final,
                                               pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_nodes_small_test_1_row_shuffled() {
        for _ in 0..<2048 {
            
            let sectionCount = Int.random(in: 0..<8)
            var sections_final = [SkeletonSection]()
            var sections_trash = [SkeletonSection]()
            
            
            var nodes_final = [SkeletonNode]()
            var nodes_trash = [SkeletonNode]()
            
            
            for _ in 0..<sectionCount {
                
                let section_gap = Int.random(in: 0...8)
                
                let nodeCount = Int.random(in: 0..<8)
                var nodes = [SkeletonNode]()
                for _ in 0..<nodeCount {
                    let node = GenerateNodes.generate_fixed(size: 10)
                    nodes.append(node)
                }
                
                nodes.shuffle()
                let section = GenerateSections.generate_section(skeleton_nodes: nodes, gap: section_gap)
                
                if Bool.random() {
                    sections_final.append(section)
                    for node in nodes {
                        if Bool.random() {
                            nodes_final.append(node)
                        }
                    }
                }
                
                sections_trash.append(section)
                for node in nodes {
                    nodes_trash.append(node)
                }
            }
            sections_final.shuffle()
            sections_trash.shuffle()
            nodes_final.shuffle()
            
            let row = GenerateRows.generate_Row(sections: sections_final)
           
            let nodesGroup = ExploderGroup<SkeletonNode>(linkedList: nodes_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodesGroup.linkedList,
                                                                                             nodeListCount: nodesGroup.linkedList.count,
                                                                                             nodeAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            let rows = [row]
            if !GrowthPlanValidator.checkNodes(pRows: rows,
                                               pNodes: nodes_final,
                                               pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_nodes_small_test_n_rows() {
        for _ in 0..<2048 {
            
            let rowCount = Int.random(in: 0..<8)
            var rows = [SkeletonRow]()
            var nodes_final = [SkeletonNode]()
            var nodes_trash = [SkeletonNode]()
            
            
            for _ in 0..<rowCount {
                let sectionCount = Int.random(in: 0..<8)
                var sections_final = [SkeletonSection]()
                var sections_trash = [SkeletonSection]()
                
                for _ in 0..<sectionCount {
                    
                    let section_gap = Int.random(in: 0...8)
                    
                    let nodeCount = Int.random(in: 0..<8)
                    var nodes = [SkeletonNode]()
                    for _ in 0..<nodeCount {
                        let node = GenerateNodes.generate_fixed(size: 10)
                        nodes.append(node)
                    }
                    
                    let section = GenerateSections.generate_section(skeleton_nodes: nodes, gap: section_gap)
                    
                    if Bool.random() {
                        sections_final.append(section)
                        for node in nodes {
                            if Bool.random() {
                                nodes_final.append(node)
                            }
                        }
                    }
                    
                    sections_trash.append(section)
                    for node in nodes {
                        nodes_trash.append(node)
                    }
                }
                
                let row = GenerateRows.generate_Row(sections: sections_final)
                rows.append(row)
                
            }
           
            
            let nodesGroup = ExploderGroup<SkeletonNode>(linkedList: nodes_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodesGroup.linkedList,
                                                                                             nodeListCount: nodesGroup.linkedList.count,
                                                                                             nodeAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            if !GrowthPlanValidator.checkNodes(pRows: rows,
                                               pNodes: nodes_final,
                                               pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_nodes_small_test_n_rows_shuffled() {
        for _ in 0..<2048 {
            
            let rowCount = Int.random(in: 0..<8)
            var rows = [SkeletonRow]()
            var rows_orphaned = [SkeletonRow]()
            var nodes_final = [SkeletonNode]()
            var nodes_trash = [SkeletonNode]()
            
            
            for _ in 0..<rowCount {
                let sectionCount = Int.random(in: 0..<8)
                var sections_final = [SkeletonSection]()
                var sections_trash = [SkeletonSection]()
                
                for _ in 0..<sectionCount {
                    
                    let section_gap = Int.random(in: 0...8)
                    
                    let nodeCount = Int.random(in: 0..<8)
                    var nodes = [SkeletonNode]()
                    for _ in 0..<nodeCount {
                        let node = GenerateNodes.generate_fixed(size: 10)
                        nodes.append(node)
                    }
                    nodes.shuffle()
                    
                    let section = GenerateSections.generate_section(skeleton_nodes: nodes, gap: section_gap)
                    
                    if Bool.random() {
                        sections_final.append(section)
                        for node in nodes {
                            if Bool.random() {
                                nodes_final.append(node)
                            }
                        }
                    }
                    
                    sections_trash.append(section)
                    for node in nodes {
                        nodes_trash.append(node)
                    }
                }
                
                nodes_trash.shuffle()
                sections_final.shuffle()
                
                let row = GenerateRows.generate_Row(sections: sections_final)
                if Bool.random() {
                    rows.append(row)
                } else {
                    rows_orphaned.append(row)
                }
            }
            
            let nodesGroup = ExploderGroup<SkeletonNode>(linkedList: nodes_final, layoutPriority: .required)
            var pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodesGroup.linkedList,
                                                                                             nodeListCount: nodesGroup.linkedList.count,
                                                                                             nodeAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            pRowGrowthPlansList.shuffle()
            
            if !GrowthPlanValidator.checkNodes(pRows: rows,
                                               pNodes: nodes_final,
                                               pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
}
