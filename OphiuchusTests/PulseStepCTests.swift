//
//  PulseStepCTests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/15/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct PulseStepCTests {
    
    @MainActor @Test func test_minimal_cannot_grow_one_flexer_one_time() {
        
        let flexer = GenerateFlexers.generate(currentSize: 0, targetSizeCurrentPriority: 0)
        let node = GenerateNodes.generate(flexer: flexer)
        let section = GenerateSections.generate_currentSizeAccumulate(nodes: [node])
        let row = GenerateRows.generate(sections: [section])
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [],
                                pieceRules: [])
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(flexer.currentSize == 0)
        #expect(flexer.targetSizeCurrentPriority == 0)
        #expect(node.childrenSize == 0)
        #expect(node.currentSize == 0)
        #expect(section.currentSize == 0)
        #expect(row.growthBudget == 1000)
        
        let applyNodeRuleResult1 = SmartLayoutExpanderPulse.step_c_apply_flexers()
        #expect(applyNodeRuleResult1 == false)
        #expect(flexer.currentSize == 0)
        #expect(flexer.targetSizeCurrentPriority == 0)
        #expect(node.childrenSize == 0)
        #expect(node.currentSize == 0)
        #expect(section.currentSize == 0)
        #expect(row.growthBudget == 1000)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_c_apply_flexers()
            #expect(extraCheck == false)
            #expect(flexer.currentSize == 0)
            #expect(flexer.targetSizeCurrentPriority == 0)
            #expect(node.childrenSize == 0)
            #expect(node.currentSize == 0)
            #expect(section.currentSize == 0)
            #expect(row.growthBudget == 1000)
        }
    }
    
    @MainActor @Test func test_minimal_can_grow_one_flexer_one_time() {
        
        let flexer = GenerateFlexers.generate(currentSize: 0, targetSizeCurrentPriority: 1)
        let node = GenerateNodes.generate(flexer: flexer)
        let section = GenerateSections.generate_currentSizeAccumulate(nodes: [node])
        let row = GenerateRows.generate(sections: [section])
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [],
                                pieceRules: [])
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(flexer.currentSize == 0)
        #expect(flexer.targetSizeCurrentPriority == 1)
        #expect(node.childrenSize == 0)
        #expect(node.currentSize == 0)
        #expect(section.currentSize == 0)
        #expect(row.growthBudget == 1000)
        
        let applyNodeRuleResult1 = SmartLayoutExpanderPulse.step_c_apply_flexers()
        #expect(applyNodeRuleResult1 == true)
        #expect(flexer.currentSize == 1)
        #expect(flexer.targetSizeCurrentPriority == 1)
        #expect(node.childrenSize == 1)
        #expect(node.currentSize == 1)
        #expect(section.currentSize == 1)
        #expect(row.growthBudget == 999)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_c_apply_flexers()
            #expect(extraCheck == false)
            #expect(flexer.currentSize == 1)
            #expect(flexer.targetSizeCurrentPriority == 1)
            #expect(node.childrenSize == 1)
            #expect(node.currentSize == 1)
            #expect(section.currentSize == 1)
            #expect(row.growthBudget == 999)
        }
    }
    
    @MainActor @Test func test_two_grow_one_simple_rule_few_pulses() {
        
        //
        let node = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 10,
                                                                          currentSize: 10,
                                                                          growCount: 5,
                                                                          amount: 3)
        
        let section = GenerateSections.generate_currentSizeAccumulate(nodes: [node])
        let row = GenerateRows.generate(sections: [section])
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [],
                                pieceRules: [])
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(node.childrenSize == 10)
        #expect(node.currentSize == 10)
        #expect(section.currentSize == 10)
        #expect(row.growthBudget == 1000)
        
        let applyNodeRuleResult1 = SmartLayoutExpanderPulse.step_c_apply_flexers()
        #expect(applyNodeRuleResult1 == true)
        #expect(node.childrenSize == 15)
        #expect(node.currentSize == 15)
        #expect(section.currentSize == 15)
        #expect(row.growthBudget == 995)
        
        let applyNodeRuleResult2 = SmartLayoutExpanderPulse.step_c_apply_flexers()
        #expect(applyNodeRuleResult2 == true)
        #expect(node.childrenSize == 20)
        #expect(node.currentSize == 20)
        #expect(section.currentSize == 20)
        #expect(row.growthBudget == 990)
        
        let applyNodeRuleResult3 = SmartLayoutExpanderPulse.step_c_apply_flexers()
        #expect(applyNodeRuleResult3 == true)
        #expect(node.childrenSize == 25)
        #expect(node.currentSize == 25)
        #expect(section.currentSize == 25)
        #expect(row.growthBudget == 985)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_c_apply_flexers()
            #expect(extraCheck == false)
            #expect(node.childrenSize == 25)
            #expect(node.currentSize == 25)
            #expect(section.currentSize == 25)
            #expect(row.growthBudget == 985)
        }
    }
    
    @MainActor @Test func grow_3_nodes_test_case_7_7_7_equal_target() {
        
        let node_a = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 4, currentSize: 4, growCount: 3, amount: 1)
        let node_b = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 2, currentSize: 2, growCount: 5, amount: 1)
        let node_c = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 6, currentSize: 6, growCount: 1, amount: 1)
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a, node_b, node_c])
        let row_a = GenerateRows.generate(sections: [section_a])
        
        //let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c], layoutPriority: .required)
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c],
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 100
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        let stepResult1 = SmartLayoutExpanderPulse.step_c_apply_flexers()
        #expect(stepResult1 == true)
        #expect(node_a.currentSize == 7)
        #expect(node_b.currentSize == 7)
        #expect(node_c.currentSize == 7)
        #expect(section_a.currentSize == 21)
        #expect(row_a.growthBudget == (100 - 9))
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_c_apply_flexers()
            #expect(extraCheck == false)
            #expect(node_a.currentSize == 7)
            #expect(node_b.currentSize == 7)
            #expect(node_c.currentSize == 7)
            #expect(section_a.currentSize == 21)
            #expect(row_a.growthBudget == (100 - 9))
        }
    }
    
    @MainActor @Test func grow_3_nodes_test_case_7_7_7_equal_target_utility() {
        
        let node_a = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 4, currentSize: 4, growCount: 3, amount: 1)
        let node_b = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 2, currentSize: 2, growCount: 5, amount: 1)
        let node_c = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 6, currentSize: 6, growCount: 1, amount: 1)
        
        let nodes = [node_a, node_b, node_c]
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: nodes)
        let sections = [section_a]
        
        let row_a = GenerateRows.generate(sections: sections)
        let rows = [row_a]
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c],
                                                  layoutPriority: .required)
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        row_a.growthBudget = 100
        
        if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                    sections: sections,
                                                                                                    rows: rows,
                                                                                                    book: book,
                                                                                                    times: 1) {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func grow_5_nodes_mixed_ownership_a() {
        
        let node_a = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 10, currentSize: 10, growCount: 10, amount: 1)
        let node_b = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 10, currentSize: 10, growCount: 10, amount: 1)
        let node_c = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 5, currentSize: 10, growCount: 10, amount: 1)
        let node_d = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 5, currentSize: 5, growCount: 15, amount: 1)
        let node_e = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 5, currentSize: 10, growCount: 10, amount: 1)
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a, node_b, node_c])
        let section_b = GenerateSections.generate_currentSizeAccumulate(nodes: [node_d, node_e])
        let sections = [section_a, section_b]
        
        let row_a = GenerateRows.generate(sections: sections)
        let rows = [row_a]
        
        let node_rule1 = SkeletonLinkageRule_Nodes(nodes: [node_a, node_c, node_e],
                                                   layoutPriority: .required)
        let node_rule2 = SkeletonLinkageRule_Nodes(nodes: [node_b, node_d],
                                                   layoutPriority: .required)
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [node_rule1, node_rule2],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 60
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(node_a.currentSize == 10) //
        #expect(node_a.childrenSize == 10) //
        #expect(node_b.currentSize == 10) //
        #expect(node_b.childrenSize == 10) //
        #expect(node_c.currentSize == 10)
        #expect(node_c.childrenSize == 5)
        #expect(node_d.currentSize == 5)
        #expect(node_d.childrenSize == 5)
        #expect(node_e.currentSize == 10)
        #expect(node_e.childrenSize == 5)
        #expect(section_a.currentSize == 30)
        #expect(section_b.currentSize == 15)
        #expect(row_a.growthBudget == 60)
        
        let stepResult1 = SmartLayoutExpanderPulse.step_c_apply_flexers()
        
        #expect(stepResult1 == true)
        #expect(node_a.currentSize == 15)
        #expect(node_a.childrenSize == 15)
        #expect(node_b.currentSize == 20)
        #expect(node_b.childrenSize == 20)
        #expect(node_c.currentSize == 15)
        #expect(node_c.childrenSize == 15)
        #expect(node_d.currentSize == 20)
        #expect(node_d.childrenSize == 20)
        #expect(node_e.currentSize == 15)
        #expect(node_e.childrenSize == 15)
        #expect(section_a.currentSize == 50)
        #expect(section_b.currentSize == 35)
        #expect(row_a.growthBudget == 20)
        
        let stepResult2 = SmartLayoutExpanderPulse.step_c_apply_flexers()
        
        #expect(stepResult2 == true)
        #expect(node_a.currentSize == 20)
        #expect(node_a.childrenSize == 20)
        #expect(node_b.currentSize == 20)
        #expect(node_b.childrenSize == 20)
        #expect(node_c.currentSize == 20)
        #expect(node_c.childrenSize == 15)
        #expect(node_d.currentSize == 20)
        #expect(node_d.childrenSize == 20)
        #expect(node_e.currentSize == 20)
        #expect(node_e.childrenSize == 15)
        #expect(section_a.currentSize == 60)
        #expect(section_b.currentSize == 40)
        #expect(row_a.growthBudget == 5)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_c_apply_flexers()
            #expect(extraCheck == false)
            #expect(node_a.currentSize == 20)
            #expect(node_a.childrenSize == 20)
            #expect(node_b.currentSize == 20)
            #expect(node_b.childrenSize == 20)
            #expect(node_c.currentSize == 20)
            #expect(node_c.childrenSize == 15)
            #expect(node_d.currentSize == 20)
            #expect(node_d.childrenSize == 20)
            #expect(node_e.currentSize == 20)
            #expect(node_e.childrenSize == 15)
            #expect(section_a.currentSize == 60)
            #expect(section_b.currentSize == 40)
            #expect(row_a.growthBudget == 5)
        }
    }
    
    @MainActor @Test func grow_5_nodes_mixed_ownership_a_utility() {
        
        let node_a = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 10, currentSize: 10, growCount: 10, amount: 1)
        let node_b = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 10, currentSize: 10, growCount: 10, amount: 1)
        let node_c = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 5, currentSize: 10, growCount: 10, amount: 1)
        let node_d = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 5, currentSize: 5, growCount: 15, amount: 1)
        let node_e = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 5, currentSize: 10, growCount: 10, amount: 1)
        
        let nodes = [node_a, node_b, node_c, node_d, node_e]
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a, node_b, node_c])
        let section_b = GenerateSections.generate_currentSizeAccumulate(nodes: [node_d, node_e])
        let sections = [section_a, section_b]
        
        let row_a = GenerateRows.generate(sections: sections)
        let rows = [row_a]
        
        let node_rule1 = SkeletonLinkageRule_Nodes(nodes: [node_a, node_c, node_e],
                                                   layoutPriority: .required)
        let node_rule2 = SkeletonLinkageRule_Nodes(nodes: [node_b, node_d],
                                                   layoutPriority: .required)
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [node_rule1, node_rule2],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 60
        
        if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                    sections: sections,
                                                                                                    rows: rows,
                                                                                                    book: book,
                                                                                                    times: 8) {
            #expect(Bool(false))
            return
        }
        
    }
    
    @MainActor @Test func grow_5_nodes_mixed_ownership_b() {
        
        let node_a = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 10, currentSize: 15, growCount: 5, amount: 1)
        let node_b = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 0, currentSize: 5, growCount: 15, amount: 1)
        let node_c = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 0, currentSize: 10, growCount: 15, amount: 1)
        let node_d = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 10, currentSize: 15, growCount: 30, amount: 1)
        let node_e = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 0, currentSize: 5, growCount: 20, amount: 1)
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a, node_b])
        let section_b = GenerateSections.generate_currentSizeAccumulate(nodes: [node_c, node_d, node_e])
        let sections = [section_a, section_b]
        
        let row_a = GenerateRows.generate(sections: sections)
        let rows = [row_a]
        
        let node_rule1 = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c],
                                                   layoutPriority: .required)
        let node_rule2 = SkeletonLinkageRule_Nodes(nodes: [node_d, node_e],
                                                   layoutPriority: .required)
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [node_rule1, node_rule2],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 90
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(node_a.currentSize == 15)
        #expect(node_a.childrenSize == 10)
        #expect(node_b.currentSize == 5)
        #expect(node_b.childrenSize == 0)
        #expect(node_c.currentSize == 10)
        #expect(node_c.childrenSize == 0)
        #expect(node_d.currentSize == 15)
        #expect(node_d.childrenSize == 10)
        #expect(node_e.currentSize == 5)
        #expect(node_e.childrenSize == 0)
        #expect(section_a.currentSize == 20)
        #expect(section_b.currentSize == 30)
        #expect(row_a.growthBudget == 90)
        
        let stepResult1 = SmartLayoutExpanderPulse.step_c_apply_flexers()
        #expect(stepResult1 == true)
        #expect(node_a.currentSize == 15)
        #expect(node_a.childrenSize == 15)
        #expect(node_b.currentSize == 15)
        #expect(node_b.childrenSize == 15)
        #expect(node_c.currentSize == 15)
        #expect(node_c.childrenSize == 15)
        #expect(node_d.currentSize == 20)
        #expect(node_d.childrenSize == 20)
        #expect(node_e.currentSize == 20)
        #expect(node_e.childrenSize == 20)
        #expect(section_a.currentSize == 30)
        #expect(section_b.currentSize == 55)
        #expect(row_a.growthBudget == 55)
        
        let stepResult2 = SmartLayoutExpanderPulse.step_c_apply_flexers()
        #expect(stepResult2 == true)
        #expect(node_a.currentSize == 15)
        #expect(node_a.childrenSize == 15)
        #expect(node_b.currentSize == 15)
        #expect(node_b.childrenSize == 15)
        #expect(node_c.currentSize == 15)
        #expect(node_c.childrenSize == 15)
        #expect(node_d.currentSize == 40)
        #expect(node_d.childrenSize == 40)
        #expect(node_e.currentSize == 40)
        #expect(node_e.childrenSize == 20)
        #expect(section_a.currentSize == 30)
        #expect(section_b.currentSize == 95)
        #expect(row_a.growthBudget == 15)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_c_apply_flexers()
            #expect(extraCheck == false)
            #expect(node_a.currentSize == 15)
            #expect(node_a.childrenSize == 15)
            #expect(node_b.currentSize == 15)
            #expect(node_b.childrenSize == 15)
            #expect(node_c.currentSize == 15)
            #expect(node_c.childrenSize == 15)
            #expect(node_d.currentSize == 40)
            #expect(node_d.childrenSize == 40)
            #expect(node_e.currentSize == 40)
            #expect(node_e.childrenSize == 20)
            #expect(section_a.currentSize == 30)
            #expect(section_b.currentSize == 95)
            #expect(row_a.growthBudget == 15)
        }
    }
    
    @MainActor @Test func grow_5_nodes_mixed_ownership_b_utility() {
        
        let node_a = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 10, currentSize: 15, growCount: 5, amount: 1)
        let node_b = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 0, currentSize: 5, growCount: 15, amount: 1)
        let node_c = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 0, currentSize: 10, growCount: 15, amount: 1)
        let node_d = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 10, currentSize: 15, growCount: 30, amount: 1)
        let node_e = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: 0, currentSize: 5, growCount: 20, amount: 1)
        
        let nodes = [node_a, node_b, node_c, node_d, node_e]
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a, node_b])
        let section_b = GenerateSections.generate_currentSizeAccumulate(nodes: [node_c, node_d, node_e])
        let sections = [section_a, section_b]
        
        let row_a = GenerateRows.generate(sections: sections)
        let rows = [row_a]
        
        let node_rule1 = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c],
                                                   layoutPriority: .required)
        let node_rule2 = SkeletonLinkageRule_Nodes(nodes: [node_d, node_e],
                                                   layoutPriority: .required)
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [node_rule1, node_rule2],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 90
        
        if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                    sections: sections,
                                                                                                    rows: rows,
                                                                                                    book: book,
                                                                                                    times: 10) {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func grow_up_tp_4_nodes_multi_pulse_check_a() {
        
        for _ in 0..<1000 {
            struct Item {
                let childrenSize: Int
                let currentSize: Int
                let wtg: Int
            }
            
            let nodeCount = Int.random(in: 0...4)
            
            var items = [Item]()
            for _ in 0..<nodeCount {
                let childrenSize = Int.random(in: 0...2)
                let currentSize = Int.random(in: childrenSize...2)
                let wtg = Int.random(in: 0...2)
                let item = Item(childrenSize: childrenSize,
                                currentSize: currentSize,
                                wtg: wtg)
                items.append(item)
            }
            
            var partitions = getAllPartitions(items)
            partitions.shuffle()
            
            for partition in partitions {
                
                
                
                var node_rules = [SkeletonLinkageRule_Nodes]()
                var nodes = [WiseLayoutNode]()
                for items in partition {
                    
                    var subnodes = [WiseLayoutNode]()
                    for item in items {
                        let node = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: item.childrenSize,
                                                                                          currentSize: item.currentSize,
                                                                                          growCount: item.wtg,
                                                                                          amount: 1)
                        subnodes.append(node)
                    }
                    nodes.append(contentsOf: subnodes)
                    
                    let rule = SkeletonLinkageRule_Nodes(nodes: subnodes, layoutPriority: .required)
                    node_rules.append(rule)
                }
                
                var sections = [SkeletonSection]()
                let sectionCount = Int.random(in: 1...2)
                
                var node_buckets = [[WiseLayoutNode]](repeating: [WiseLayoutNode](), count: sectionCount)
                for node in nodes {
                    let index = Int.random(in: 0..<sectionCount)
                    node_buckets[index].append(node)
                }
                
                for index in 0..<sectionCount {
                    let section = GenerateSections.generate(nodes: node_buckets[index])
                    sections.append(section)
                }
                
                var rows = [SkeletonRow]()
                let rowCount = Int.random(in: 1...2)
                
                var row_buckets = [[SkeletonSection]](repeating: [SkeletonSection](), count: rowCount)
                
                for section_index in 0..<sectionCount {
                    let row_index = Int.random(in: 0..<rowCount)
                    row_buckets[row_index].append(sections[section_index])
                }
                
                for index in 0..<rowCount {
                    let row = GenerateRows.generate(sections: row_buckets[index])
                    rows.append(row)
                }
                
                let book = SkeletonBook(rows: rows,
                                        nodeRules: node_rules,
                                        flexerRules: [],
                                        pieceRules: [])
                
                for row in rows {
                    row.growthBudget = Int.random(in: 0...100)
                }
                
                
                //book.codegen_grow_node_with_flexer_group()
                
                if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                            sections: sections,
                                                                                                            rows: rows,
                                                                                                            book: book,
                                                                                                            times: 1) {
                    
                    
                    
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @MainActor @Test func grow_up_tp_4_nodes_multi_pulse_check_b() {
        
        for _ in 0..<1000 {
            struct Item {
                let childrenSize: Int
                let currentSize: Int
                let wtg: Int
            }
            
            let nodeCount = Int.random(in: 0...4)
            
            var items = [Item]()
            for _ in 0..<nodeCount {
                let childrenSize = Int.random(in: 0...6)
                let currentSize = Int.random(in: childrenSize...6)
                let wtg = Int.random(in: 0...12)
                let item = Item(childrenSize: childrenSize,
                                currentSize: currentSize,
                                wtg: wtg)
                items.append(item)
            }
            
            var partitions = getAllPartitions(items)
            partitions.shuffle()
            
            for partition in partitions {
                
                
                
                var node_rules = [SkeletonLinkageRule_Nodes]()
                var nodes = [WiseLayoutNode]()
                for items in partition {
                    
                    var subnodes = [WiseLayoutNode]()
                    for item in items {
                        let node = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: item.childrenSize,
                                                                                          currentSize: item.currentSize,
                                                                                          growCount: item.wtg,
                                                                                          amount: 1)
                        subnodes.append(node)
                    }
                    nodes.append(contentsOf: subnodes)
                    
                    let rule = SkeletonLinkageRule_Nodes(nodes: subnodes, layoutPriority: .required)
                    node_rules.append(rule)
                }
                
                var sections = [SkeletonSection]()
                let sectionCount = Int.random(in: 1...4)
                
                var node_buckets = [[WiseLayoutNode]](repeating: [WiseLayoutNode](), count: sectionCount)
                for node in nodes {
                    let index = Int.random(in: 0..<sectionCount)
                    node_buckets[index].append(node)
                }
                
                for index in 0..<sectionCount {
                    let section = GenerateSections.generate(nodes: node_buckets[index])
                    sections.append(section)
                }
                
                var rows = [SkeletonRow]()
                let rowCount = Int.random(in: 1...4)
                
                var row_buckets = [[SkeletonSection]](repeating: [SkeletonSection](), count: rowCount)
                
                for section_index in 0..<sectionCount {
                    let row_index = Int.random(in: 0..<rowCount)
                    row_buckets[row_index].append(sections[section_index])
                }
                
                for index in 0..<rowCount {
                    let row = GenerateRows.generate(sections: row_buckets[index])
                    rows.append(row)
                }
                
                let book = SkeletonBook(rows: rows,
                                        nodeRules: node_rules,
                                        flexerRules: [],
                                        pieceRules: [])
                
                for row in rows {
                    row.growthBudget = Int.random(in: 0...200)
                }
                
                if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                            sections: sections,
                                                                                                            rows: rows,
                                                                                                            book: book,
                                                                                                            times: 6) {
                    
                    
                    
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @MainActor @Test func grow_up_tp_6_nodes_multi_pulse_check_a() {
        
        for _ in 0..<1000 {
            struct Item {
                let childrenSize: Int
                let currentSize: Int
                let wtg: Int
            }
            
            let nodeCount = Int.random(in: 0...6)
            
            var items = [Item]()
            for _ in 0..<nodeCount {
                let childrenSize = Int.random(in: 0...12)
                let currentSize = Int.random(in: childrenSize...12)
                let wtg = Int.random(in: 0...24)
                let item = Item(childrenSize: childrenSize,
                                currentSize: currentSize,
                                wtg: wtg)
                items.append(item)
            }
            
            var partitions = getAllPartitions(items)
            partitions.shuffle()
            
            for partition in partitions {
                
                
                
                var node_rules = [SkeletonLinkageRule_Nodes]()
                var nodes = [WiseLayoutNode]()
                for items in partition {
                    
                    var subnodes = [WiseLayoutNode]()
                    for item in items {
                        let node = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: item.childrenSize,
                                                                                          currentSize: item.currentSize,
                                                                                          growCount: item.wtg,
                                                                                          amount: 1)
                        subnodes.append(node)
                        
                    }
                    nodes.append(contentsOf: subnodes)
                    
                    let rule = SkeletonLinkageRule_Nodes(nodes: subnodes, layoutPriority: .required)
                    node_rules.append(rule)
                }
                
                var sections = [SkeletonSection]()
                let sectionCount = Int.random(in: 1...4)
                
                var node_buckets = [[WiseLayoutNode]](repeating: [WiseLayoutNode](), count: sectionCount)
                for node in nodes {
                    let index = Int.random(in: 0..<sectionCount)
                    node_buckets[index].append(node)
                }
                
                for index in 0..<sectionCount {
                    let section = GenerateSections.generate(nodes: node_buckets[index])
                    sections.append(section)
                }
                
                var rows = [SkeletonRow]()
                let rowCount = Int.random(in: 1...2)
                
                var row_buckets = [[SkeletonSection]](repeating: [SkeletonSection](), count: rowCount)
                
                for section_index in 0..<sectionCount {
                    let row_index = Int.random(in: 0..<rowCount)
                    row_buckets[row_index].append(sections[section_index])
                }
                
                for index in 0..<rowCount {
                    let row = GenerateRows.generate(sections: row_buckets[index])
                    rows.append(row)
                }
                
                let book = SkeletonBook(rows: rows,
                                        nodeRules: node_rules,
                                        flexerRules: [],
                                        pieceRules: [])
                
                for row in rows {
                    row.growthBudget = Int.random(in: 0...200)
                }
                
                if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                            sections: sections,
                                                                                                            rows: rows,
                                                                                                            book: book,
                                                                                                            times: 12) {
                    
                    
                    
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @MainActor @Test func grow_up_tp_6_nodes_multi_pulse_check_b() {
        
        for _ in 0..<1000 {
            struct Item {
                let childrenSize: Int
                let currentSize: Int
                let wtg: Int
            }
            
            let nodeCount = Int.random(in: 0...6)
            var items = [Item]()
            for _ in 0..<nodeCount {
                let childrenSize = Int.random(in: 0...2)
                let currentSize = Int.random(in: childrenSize...24)
                let wtg = Int.random(in: 0...64)
                let item = Item(childrenSize: childrenSize,
                                currentSize: currentSize,
                                wtg: wtg)
                items.append(item)
            }
            
            var partitions = getAllPartitions(items)
            partitions.shuffle()
            
            for partition in partitions {
                
                
                var node_rules = [SkeletonLinkageRule_Nodes]()
                var nodes = [WiseLayoutNode]()
                for items in partition {
                    
                    var subnodes = [WiseLayoutNode]()
                    for item in items {
                        let node = GenerateNodes.generate_growing_flexers_mono_ubiquitous(childrenSize: item.childrenSize,
                                                                                          currentSize: item.currentSize,
                                                                                          growCount: item.wtg,
                                                                                          amount: 1)
                        subnodes.append(node)
                    }
                    nodes.append(contentsOf: subnodes)
                    
                    let rule = SkeletonLinkageRule_Nodes(nodes: subnodes, layoutPriority: .required)
                    node_rules.append(rule)
                }
                
                var sections = [SkeletonSection]()
                let sectionCount = Int.random(in: 1...8)
                
                var node_buckets = [[WiseLayoutNode]](repeating: [WiseLayoutNode](), count: sectionCount)
                for node in nodes {
                    let index = Int.random(in: 0..<sectionCount)
                    node_buckets[index].append(node)
                }
                
                for index in 0..<sectionCount {
                    let section = GenerateSections.generate(nodes: node_buckets[index])
                    sections.append(section)
                }
                
                var rows = [SkeletonRow]()
                let rowCount = Int.random(in: 1...6)
                
                var row_buckets = [[SkeletonSection]](repeating: [SkeletonSection](), count: rowCount)
                
                for section_index in 0..<sectionCount {
                    let row_index = Int.random(in: 0..<rowCount)
                    row_buckets[row_index].append(sections[section_index])
                }
                
                for index in 0..<rowCount {
                    let row = GenerateRows.generate(sections: row_buckets[index])
                    rows.append(row)
                }
                
                let book = SkeletonBook(rows: rows,
                                        nodeRules: node_rules,
                                        flexerRules: [],
                                        pieceRules: [])
                
                for row in rows {
                    row.growthBudget = Int.random(in: 0...400)
                }
                
                
                
                if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                            sections: sections,
                                                                                                            rows: rows,
                                                                                                            book: book,
                                                                                                            times: 24) {
                    
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
}
