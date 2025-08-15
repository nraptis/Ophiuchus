//
//  PulseStepATests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/10/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct PulseStepATests {
    
    @MainActor @Test func cannot_grow_2_nodes_1_section() {
        
        // We expect this to happen:
        // 1.) node a grows by 1, section a grows by 1, row a grows by 1 (growthBudget reduced by 1)
        // 2.) node a grows by 1, section a grows by 1, row a grows by 1 (growthBudget reduced by 1)
        
        // 3.) nodes a & b grows by 1, section a grows by 2, row a grows by 2 (growthBudget reduced by 2)
        // 4.) nodes a & b grows by 1, section a grows by 2, row a grows by 2 (growthBudget reduced by 2)
        
        // 5.) we should reach some type of termination case.
        
        let node_a = GenerateNodes.generate(currentSize: 4)
        let node_b = GenerateNodes.generate(currentSize: 4)
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a, node_b])
        let row_a = GenerateRows.generate(sections: [section_a])
        
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b], layoutPriority: .required)
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 8
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        // We expect this to happen:
        // 1.) node a grows by 1, section a grows by 1, row a grows by 1 (growthBudget reduced by 1)
        let applyNodeRuleResult1 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult1 == false)
        #expect(node_a.currentSize == 4)
        #expect(node_b.currentSize == 4)
        #expect(row_a.growthBudget == 8)
        #expect(section_a.currentSize == 8)
        #expect(row_a.growthBudget == 8)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
            #expect(extraCheck == false)
            #expect(node_a.currentSize == 4)
            #expect(node_b.currentSize == 4)
            #expect(row_a.growthBudget == 8)
            #expect(section_a.currentSize == 8)
            #expect(row_a.growthBudget == 8)
        }
    }
    
    @MainActor @Test func grow_2_nodes_1_section_exact_fit() {
        
        let node_a = GenerateNodes.generate(currentSize: 2)
        let node_b = GenerateNodes.generate(currentSize: 3)
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a, node_b])
        let row_a = GenerateRows.generate(sections: [section_a])
        
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b], layoutPriority: .required)
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 1
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        // We expect this to happen:
        // 1.) node a grows by 1, section a grows by 1, row a grows by 1 (growthBudget reduced by 1)
        let applyNodeRuleResult1 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult1 == true)
        #expect(node_a.currentSize == 3)
        #expect(node_b.currentSize == 3)
        #expect(row_a.growthBudget == 0)
        #expect(section_a.currentSize == 6)
        #expect(row_a.growthBudget == 0)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
            #expect(extraCheck == false)
            #expect(node_a.currentSize == 3)
            #expect(node_b.currentSize == 3)
            #expect(section_a.currentSize == 6)
            #expect(row_a.growthBudget == 0)
        }
    }
    
    @MainActor @Test func grow_3_nodes_1_section_exact_fit() {
        
        // We expect this to happen:
        // 1.) node a grows by 1, section a grows by 1, row a grows by 1 (growthBudget reduced by 1)
        // 2.) node a grows by 1, section a grows by 1, row a grows by 1 (growthBudget reduced by 1)
        
        // 3.) nodes a & b grows by 1, section a grows by 2, row a grows by 2 (growthBudget reduced by 2)
        // 4.) nodes a & b grows by 1, section a grows by 2, row a grows by 2 (growthBudget reduced by 2)
        
        // 5.) we should reach some type of termination case.
        
        let node_a = GenerateNodes.generate(currentSize: 2)
        let node_b = GenerateNodes.generate(currentSize: 4)
        let node_c = GenerateNodes.generate(currentSize: 6)
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a, node_b, node_c])
        
        
        let row_a = GenerateRows.generate(sections: [section_a])
        
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c], layoutPriority: .required)
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 6
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        // We expect this to happen:
        // 1.) node a grows by 1, section a grows by 1, row a grows by 1 (growthBudget reduced by 1)
        let applyNodeRuleResult1 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult1 == true)
        #expect(node_a.currentSize == 3)
        #expect(node_b.currentSize == 4)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 5)
        #expect(section_a.currentSize == 13)
        
        // 2.) node a grows by 1, section a grows by 1, row a grows by 1 (growthBudget reduced by 1)
        let applyNodeRuleResult2 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult2 == true)
        #expect(node_a.currentSize == 4)
        #expect(node_b.currentSize == 4)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 4)
        #expect(section_a.currentSize == 14)
        
        // 3.) nodes a & b grows by 1, section a grows by 2, row a grows by 2 (growthBudget reduced by 2)
        let applyNodeRuleResult3 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult3 == true)
        #expect(node_a.currentSize == 5)
        #expect(node_b.currentSize == 5)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 2)
        #expect(section_a.currentSize == 16)
        
        // 4.) nodes a & b grows by 1, section a grows by 2, row a grows by 2 (growthBudget reduced by 2)
        let applyNodeRuleResult4 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult4 == true)
        #expect(node_a.currentSize == 6)
        #expect(node_b.currentSize == 6)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 0)
        #expect(section_a.currentSize == 18)
        
        let applyNodeRuleResult5 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult5 == false)
        #expect(node_a.currentSize == 6)
        #expect(node_b.currentSize == 6)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 0)
        #expect(section_a.currentSize == 18)
    }
    
    @MainActor @Test func grow_3_nodes_1_section_under_fit() {
        
        let node_a = GenerateNodes.generate(currentSize: 2)
        let node_b = GenerateNodes.generate(currentSize: 4)
        let node_c = GenerateNodes.generate(currentSize: 6)
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a, node_b, node_c])
        
        
        let row_a = GenerateRows.generate(sections: [section_a])
        
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c], layoutPriority: .required)
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 5
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        let applyNodeRuleResult1 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult1 == true)
        #expect(node_a.currentSize == 3)
        #expect(node_b.currentSize == 4)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 4)
        #expect(section_a.currentSize == 13)
        
        let applyNodeRuleResult2 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult2 == true)
        #expect(node_a.currentSize == 4)
        #expect(node_b.currentSize == 4)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 3)
        #expect(section_a.currentSize == 14)
        
        let applyNodeRuleResult3 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult3 == true)
        #expect(node_a.currentSize == 5)
        #expect(node_b.currentSize == 5)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 1)
        #expect(section_a.currentSize == 16)
        
        let applyNodeRuleResult4 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult4 == false)
        #expect(node_a.currentSize == 5)
        #expect(node_b.currentSize == 5)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 1)
        #expect(section_a.currentSize == 16)
        
        let applyNodeRuleResult5 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult5 == false)
        #expect(node_a.currentSize == 5)
        #expect(node_b.currentSize == 5)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 1)
        #expect(section_a.currentSize == 16)
    }
    
    @MainActor @Test func grow_3_nodes_1_section_over_fit() {
        
        let node_a = GenerateNodes.generate(currentSize: 2)
        let node_b = GenerateNodes.generate(currentSize: 4)
        let node_c = GenerateNodes.generate(currentSize: 6)
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a, node_b, node_c])
        
        
        let row_a = GenerateRows.generate(sections: [section_a])
        
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c], layoutPriority: .required)
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 100
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        let applyNodeRuleResult1 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult1 == true)
        #expect(node_a.currentSize == 3)
        #expect(node_b.currentSize == 4)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 99)
        #expect(section_a.currentSize == 13)
        
        let applyNodeRuleResult2 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult2 == true)
        #expect(node_a.currentSize == 4)
        #expect(node_b.currentSize == 4)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 98)
        #expect(section_a.currentSize == 14)
        
        let applyNodeRuleResult3 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult3 == true)
        #expect(node_a.currentSize == 5)
        #expect(node_b.currentSize == 5)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 96)
        #expect(section_a.currentSize == 16)
        
        let applyNodeRuleResult4 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult4 == true)
        #expect(node_a.currentSize == 6)
        #expect(node_b.currentSize == 6)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 94)
        #expect(section_a.currentSize == 18)
        
        let applyNodeRuleResult5 = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
        #expect(applyNodeRuleResult5 == false)
        #expect(node_a.currentSize == 6)
        #expect(node_b.currentSize == 6)
        #expect(node_c.currentSize == 6)
        #expect(row_a.growthBudget == 94)
        #expect(section_a.currentSize == 18)
    }
    
    @MainActor @Test func partitions_test_small() {
        
        var tested_count_0 = 0
        var tested_count_1 = 0
        var tested_count_2 = 0
        var tested_count_3 = 0
        var tested_count_4 = 0
        var tested_count_5 = 0
        var number_of_grows = 0
        var number_of_not_grows = 0
        
        for _ in 0..<10000 {
            
            let count = Int.random(in: 1...4)
            var sizes = [Int]()
            for _ in 0..<count { sizes.append(Int.random(in: 0...4)) }
            let nodes = sizes.map { GenerateNodes.generate(currentSize: $0) }
            let partitions = getAllPartitions(nodes)
            for partition in partitions {
                let nodeRules = partition.map { SkeletonLinkageRule_Nodes(nodes: $0, layoutPriority: .required) }
                
                let section = GenerateSections.generate_currentSizeAccumulate(nodes: Array(partition.joined()))
                let row = GenerateRows.generate(sections: [section])
                let page = SkeletonPage(rows: [row])
                let book = SkeletonBook(pages: [page],
                                        nodeRules: nodeRules,
                                        flexerRules: [],
                                        pieceRules: [])
                
                row.growthBudget = Int.random(in: 0...20)
                let groupData = SkeletonLayoutGrouper.getAll(book: book)
                
                SmartLayoutExpanderMain.prepare(groupData: groupData)
                SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
                
                var expectedGrowthBudget = row.growthBudget
                var stops = 0
                
                for _ in 0..<100 {
                    
                    for nodeGroup in groupData.nodeGroups {
                        for node in nodeGroup.linkedList {
                            node.__snapshotCurrentSize = node.currentSize
                            node.__expectedCurrentSize = node.currentSize
                        }
                    }
                    for section in groupData.sections {
                        section.__snapshotCurrentSize = section.currentSize
                        section.__expectedCurrentSize = section.currentSize
                    }
                    
                    var expectedResult = false
                    for nodeGroup in groupData.nodeGroups {
                        
                        if nodeGroup.linkedList.count == 0 { tested_count_0 += 1 }
                        if nodeGroup.linkedList.count == 1 { tested_count_1 += 1 }
                        if nodeGroup.linkedList.count == 2 { tested_count_2 += 1 }
                        if nodeGroup.linkedList.count == 3 { tested_count_3 += 1 }
                        if nodeGroup.linkedList.count == 4 { tested_count_4 += 1 }
                        if nodeGroup.linkedList.count == 5 { tested_count_5 += 1 }
                        
                        
                        // Do we expect it to grow?
                        let smallest = GenerateNodes.smallest(nodes: nodeGroup.linkedList)
                        if smallest.count > 0 {
                            
                            // Could the row handle all these growing?
                            if expectedGrowthBudget >= smallest.count {
                                // These will grow, right now!!!
                                for node in smallest {
                                    node.__expectedCurrentSize = node.currentSize + 1
                                    node.__snapshotCurrentSize += 1
                                    node.section!.__expectedCurrentSize += 1
                                    expectedGrowthBudget -= 1
                                    expectedResult = true
                                    number_of_grows += 1
                                    number_of_not_grows -= 1
                                }
                                for _ in nodeGroup.linkedList {
                                    number_of_not_grows += 1
                                }
                                
                            }
                        } else {
                            for _ in nodeGroup.linkedList {
                                number_of_not_grows += 1
                            }
                        }
                    }
                    
                    let realResult = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
                    
                    if !(realResult == expectedResult) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for section in groupData.sections {
                        if section.currentSize != section.__expectedCurrentSize {
                            #expect(Bool(false))
                            return
                        }
                    }
                    
                    for nodeGroup in groupData.nodeGroups {
                        for node in nodeGroup.linkedList {
                            if node.currentSize != node.__expectedCurrentSize {
                                #expect(Bool(false))
                                return
                            }
                        }
                    }
                    
                    if row.growthBudget != expectedGrowthBudget {
                        #expect(Bool(false))
                        return
                    }
                    
                    // Do the real pulse.
                    
                    
                    if realResult == false {
                        // No need to keep looping, things will not change.
                        stops += 1
                        if stops >= 3 {
                            // We stay at the 'stuck' state for 3 pulses.
                            break
                        }
                    }
                }
            }
        }
        
        print("partitions_test_small => tested_count_0 = \(tested_count_0)")
        print("partitions_test_small => tested_count_1 = \(tested_count_1)")
        print("partitions_test_small => tested_count_2 = \(tested_count_2)")
        print("partitions_test_small => tested_count_3 = \(tested_count_3)")
        print("partitions_test_small => tested_count_4 = \(tested_count_4)")
        print("partitions_test_small => tested_count_5 = \(tested_count_5)")
        print("partitions_test_small => number_of_grows = \(number_of_grows)")
        print("partitions_test_small => number_of_not_grows = \(number_of_not_grows)")
    }
    
    
    @MainActor @Test func partitions_test_medium() {
        
        var tested_count_0 = 0
        var tested_count_1 = 0
        var tested_count_2 = 0
        var tested_count_3 = 0
        var tested_count_4 = 0
        var tested_count_5 = 0
        var number_of_grows = 0
        var number_of_not_grows = 0
        
        for _ in 0..<10000 {
            
            let count = Int.random(in: 2...6)
            var sizes = [Int]()
            for _ in 0..<count { sizes.append(Int.random(in: 0...8)) }
            let nodes = sizes.map { GenerateNodes.generate(currentSize: $0) }
            let partitions = getAllPartitions(nodes)
            for partition in partitions {
                let nodeRules = partition.map { SkeletonLinkageRule_Nodes(nodes: $0, layoutPriority: .required) }
                
                let section = GenerateSections.generate_currentSizeAccumulate(nodes: Array(partition.joined()))
                let row = GenerateRows.generate(sections: [section])
                let page = SkeletonPage(rows: [row])
                let book = SkeletonBook(pages: [page],
                                        nodeRules: nodeRules,
                                        flexerRules: [],
                                        pieceRules: [])
                
                row.growthBudget = Int.random(in: 0...60)
                let groupData = SkeletonLayoutGrouper.getAll(book: book)
                
                SmartLayoutExpanderMain.prepare(groupData: groupData)
                SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
                
                var expectedGrowthBudget = row.growthBudget
                var stops = 0
                
                for _ in 0..<10000000000 {
                    
                    for nodeGroup in groupData.nodeGroups {
                        for node in nodeGroup.linkedList {
                            node.__snapshotCurrentSize = node.currentSize
                            node.__expectedCurrentSize = node.currentSize
                        }
                    }
                    for section in groupData.sections {
                        section.__snapshotCurrentSize = section.currentSize
                        section.__expectedCurrentSize = section.currentSize
                    }
                    
                    var expectedResult = false
                    for nodeGroup in groupData.nodeGroups {
                        
                        if nodeGroup.linkedList.count == 0 { tested_count_0 += 1 }
                        if nodeGroup.linkedList.count == 1 { tested_count_1 += 1 }
                        if nodeGroup.linkedList.count == 2 { tested_count_2 += 1 }
                        if nodeGroup.linkedList.count == 3 { tested_count_3 += 1 }
                        if nodeGroup.linkedList.count == 4 { tested_count_4 += 1 }
                        if nodeGroup.linkedList.count == 5 { tested_count_5 += 1 }
                        
                        
                        // Do we expect it to grow?
                        let smallest = GenerateNodes.smallest(nodes: nodeGroup.linkedList)
                        if smallest.count > 0 {
                            
                            // Could the row handle all these growing?
                            if expectedGrowthBudget >= smallest.count {
                                // These will grow, right now!!!
                                for node in smallest {
                                    node.__expectedCurrentSize = node.currentSize + 1
                                    node.__snapshotCurrentSize += 1
                                    node.section!.__expectedCurrentSize += 1
                                    expectedGrowthBudget -= 1
                                    expectedResult = true
                                    number_of_grows += 1
                                    number_of_not_grows -= 1
                                }
                                for _ in nodeGroup.linkedList {
                                    number_of_not_grows += 1
                                }
                                
                            }
                        } else {
                            for _ in nodeGroup.linkedList {
                                number_of_not_grows += 1
                            }
                        }
                    }
                    
                    let realResult = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
                    
                    if !(realResult == expectedResult) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for section in groupData.sections {
                        if section.currentSize != section.__expectedCurrentSize {
                            #expect(Bool(false))
                            return
                        }
                    }
                    
                    for nodeGroup in groupData.nodeGroups {
                        for node in nodeGroup.linkedList {
                            if node.currentSize != node.__expectedCurrentSize {
                                #expect(Bool(false))
                                return
                            }
                        }
                    }
                    
                    if row.growthBudget != expectedGrowthBudget {
                        #expect(Bool(false))
                        return
                    }
                    
                    // Do the real pulse.
                    
                    
                    if realResult == false {
                        // No need to keep looping, things will not change.
                        stops += 1
                        if stops >= 3 {
                            // We stay at the 'stuck' state for 3 pulses.
                            break
                        }
                    }
                }
            }
        }
        
        print("partitions_test_medium => tested_count_0 = \(tested_count_0)")
        print("partitions_test_medium => tested_count_1 = \(tested_count_1)")
        print("partitions_test_medium => tested_count_2 = \(tested_count_2)")
        print("partitions_test_medium => tested_count_3 = \(tested_count_3)")
        print("partitions_test_medium => tested_count_4 = \(tested_count_4)")
        print("partitions_test_medium => tested_count_5 = \(tested_count_5)")
        print("partitions_test_medium => number_of_grows = \(number_of_grows)")
        print("partitions_test_medium => number_of_not_grows = \(number_of_not_grows)")
    }
    
    @MainActor @Test func partitions_test_medium_discard() {
        
        var tested_count_0 = 0
        var tested_count_1 = 0
        var tested_count_2 = 0
        var tested_count_3 = 0
        var tested_count_4 = 0
        var tested_count_5 = 0
        var number_of_grows = 0
        var number_of_not_grows = 0
        
        for _ in 0..<10000 {
            
            let count = Int.random(in: 2...6)
            var sizes = [Int]()
            for _ in 0..<count { sizes.append(Int.random(in: 0...8)) }
            let nodes = sizes.map { GenerateNodes.generate(currentSize: $0) }
            let partitions = getAllPartitions(nodes)
            for partition in partitions {
                var nodeRules = [SkeletonLinkageRule_Nodes]()
                for nodes in partition {
                    if Bool.random() {
                        let rule = SkeletonLinkageRule_Nodes(nodes: nodes, layoutPriority: .required)
                        nodeRules.append(rule)
                    }
                }
                
                let section = GenerateSections.generate_currentSizeAccumulate(nodes: Array(partition.joined()))
                let row = GenerateRows.generate(sections: [section])
                let page = SkeletonPage(rows: [row])
                let book = SkeletonBook(pages: [page],
                                        nodeRules: nodeRules,
                                        flexerRules: [],
                                        pieceRules: [])
                
                row.growthBudget = Int.random(in: 0...60)
                let groupData = SkeletonLayoutGrouper.getAll(book: book)
                
                SmartLayoutExpanderMain.prepare(groupData: groupData)
                SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
                
                var expectedGrowthBudget = row.growthBudget
                var stops = 0
                
                for _ in 0..<10000000000 {
                    
                    for nodeGroup in groupData.nodeGroups {
                        for node in nodeGroup.linkedList {
                            node.__snapshotCurrentSize = node.currentSize
                            node.__expectedCurrentSize = node.currentSize
                        }
                    }
                    for section in groupData.sections {
                        section.__snapshotCurrentSize = section.currentSize
                        section.__expectedCurrentSize = section.currentSize
                    }
                    
                    var expectedResult = false
                    for nodeGroup in groupData.nodeGroups {
                        
                        if nodeGroup.linkedList.count == 0 { tested_count_0 += 1 }
                        if nodeGroup.linkedList.count == 1 { tested_count_1 += 1 }
                        if nodeGroup.linkedList.count == 2 { tested_count_2 += 1 }
                        if nodeGroup.linkedList.count == 3 { tested_count_3 += 1 }
                        if nodeGroup.linkedList.count == 4 { tested_count_4 += 1 }
                        if nodeGroup.linkedList.count == 5 { tested_count_5 += 1 }
                        
                        
                        // Do we expect it to grow?
                        let smallest = GenerateNodes.smallest(nodes: nodeGroup.linkedList)
                        if smallest.count > 0 {
                            
                            // Could the row handle all these growing?
                            if expectedGrowthBudget >= smallest.count {
                                // These will grow, right now!!!
                                for node in smallest {
                                    node.__expectedCurrentSize = node.currentSize + 1
                                    node.__snapshotCurrentSize += 1
                                    node.section!.__expectedCurrentSize += 1
                                    expectedGrowthBudget -= 1
                                    expectedResult = true
                                    number_of_grows += 1
                                    number_of_not_grows -= 1
                                }
                                for _ in nodeGroup.linkedList {
                                    number_of_not_grows += 1
                                }
                                
                            }
                        } else {
                            for _ in nodeGroup.linkedList {
                                number_of_not_grows += 1
                            }
                        }
                    }
                    
                    let realResult = SmartLayoutExpanderPulse.step_a_apply_node_group_rules()
                    
                    if !(realResult == expectedResult) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for section in groupData.sections {
                        if section.currentSize != section.__expectedCurrentSize {
                            #expect(Bool(false))
                            return
                        }
                    }
                    
                    for nodeGroup in groupData.nodeGroups {
                        for node in nodeGroup.linkedList {
                            if node.currentSize != node.__expectedCurrentSize {
                                #expect(Bool(false))
                                return
                            }
                        }
                    }
                    
                    if row.growthBudget != expectedGrowthBudget {
                        #expect(Bool(false))
                        return
                    }
                    
                    // Do the real pulse.
                    
                    
                    if realResult == false {
                        // No need to keep looping, things will not change.
                        stops += 1
                        if stops >= 3 {
                            // We stay at the 'stuck' state for 3 pulses.
                            break
                        }
                    }
                }
            }
        }
        
        print("partitions_test_medium_discard => tested_count_0 = \(tested_count_0)")
        print("partitions_test_medium_discard => tested_count_1 = \(tested_count_1)")
        print("partitions_test_medium_discard => tested_count_2 = \(tested_count_2)")
        print("partitions_test_medium_discard => tested_count_3 = \(tested_count_3)")
        print("partitions_test_medium_discard => tested_count_4 = \(tested_count_4)")
        print("partitions_test_medium_discard => tested_count_5 = \(tested_count_5)")
        print("partitions_test_medium_discard => number_of_grows = \(number_of_grows)")
        print("partitions_test_medium_discard => number_of_not_grows = \(number_of_not_grows)")
    }
    

    
}
