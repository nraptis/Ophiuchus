//
//  PulseStepBTests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/12/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct PulseStepBTests {
    
    @MainActor @Test func grow_2_pieces_1_section_grow_by_1() {
        
        // We expect this to happen:
        // 1.) node a grows by 1, section a grows by 1, row a grows by 1 (growthBudget reduced by 1)
        // 2.) node a grows by 1, section a grows by 1, row a grows by 1 (growthBudget reduced by 1)
        
        // 3.) nodes a & b grows by 1, section a grows by 2, row a grows by 2 (growthBudget reduced by 2)
        // 4.) nodes a & b grows by 1, section a grows by 2, row a grows by 2 (growthBudget reduced by 2)
        
        // 5.) we should reach some type of termination case.
        
        let piece_a = GeneratePieces.generate(size: 1)
        let piece_b = GeneratePieces.generate(size: 2)
        
        let node_a = GenerateNodes.generate_currentSizeAccumulate(pieces: [piece_a, piece_b])
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a])
        let row_a = GenerateRows.generate(sections: [section_a])
        
        //let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c], layoutPriority: .required)
        let piece_rule = SkeletonLinkageRule_Pieces(pieces: [piece_a, piece_b], layoutPriority: .required)
        
        
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [],
                                flexerRules: [],
                                pieceRules: [piece_rule])
        
        row_a.growthBudget = 100
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        let stepResult1 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        
        #expect(stepResult1 == true)
        #expect(piece_a.currentSize == 2)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.currentSize == 4)
        #expect(section_a.currentSize == 4)
        #expect(row_a.growthBudget == 99)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
            #expect(extraCheck == false)
            #expect(piece_a.currentSize == 2)
            #expect(piece_b.currentSize == 2)
            #expect(node_a.currentSize == 4)
            #expect(section_a.currentSize == 4)
            #expect(row_a.growthBudget == 99)
        }
    }
    
    @MainActor @Test func grow_2_pieces_1_section_grow_by_1_utility() {
        let node_a = GenerateNodes.generate_currentSizeAccumulate(pieces: [])
        node_a.requestedGrowthFromChildren = 1
        let nodes = [node_a]
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: nodes)
        let sections = [section_a]
        let row_a = GenerateRows.generate(sections: sections)
        let rows = [row_a]
        row_a.growthBudget = 100
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [],
                                pieceRules: [])
        if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                    sections: sections,
                                                                                                    rows: rows,
                                                                                                    book: book,
                                                                                                    times: 1) {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func grow_large_piece_grow_no_gaps_10_exact_fit() {
        
        var pieceListA = GeneratePieces.generate_n(10, size: 0)
        pieceListA.append(GeneratePieces.generate(size: 1))
        
        var pieceListB = GeneratePieces.generate_n(10, size: 0)
        pieceListB.append(GeneratePieces.generate(size: 1))
        
        let piece_rule_a = SkeletonLinkageRule_Pieces(pieces: pieceListA, layoutPriority: .required)
        let piece_rule_b = SkeletonLinkageRule_Pieces(pieces: pieceListB, layoutPriority: .required)
        
        let node_a = GenerateNodes.generate(pieces: pieceListA)
        node_a.currentSize = 0
        node_a.childrenSize = 0
        
        let node_b = GenerateNodes.generate(pieces: pieceListB)
        node_b.currentSize = 0
        node_b.childrenSize = 0
        
        let section_a = GenerateSections.generate(nodes: [node_a, node_b])
        let row_a = GenerateRows.generate(sections: [section_a])
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b],
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [piece_rule_a, piece_rule_b])
        
        row_a.growthBudget = 20
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(node_a.currentSize == 0)
        #expect(node_a.childrenSize == 0)
        #expect(node_b.currentSize == 0 )
        #expect(node_b.childrenSize == 0 )
        #expect(section_a.currentSize == 0)
        #expect(row_a.growthBudget == 20)
        
        let stepResult1 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        #expect(stepResult1 == true)
        
        #expect(node_a.currentSize == 10)
        #expect(node_a.childrenSize == 10)
        #expect(node_b.currentSize == 10)
        #expect(node_b.childrenSize == 10)
        #expect(section_a.currentSize == 20)
        #expect(row_a.growthBudget == 0)
        
        let stepResult2 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        #expect(stepResult2 == false)
        #expect(node_a.currentSize == 10)
        #expect(node_a.childrenSize == 10)
        #expect(node_b.currentSize == 10)
        #expect(node_b.childrenSize == 10)
        #expect(section_a.currentSize == 20)
        #expect(row_a.growthBudget == 0)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
            #expect(extraCheck == false)
            #expect(node_a.currentSize == 10)
            #expect(node_a.childrenSize == 10)
            #expect(node_b.currentSize == 10)
            #expect(node_b.childrenSize == 10)
            #expect(section_a.currentSize == 20)
            #expect(row_a.growthBudget == 0)
        }
    }
    
    @MainActor @Test func grow_large_piece_grow_no_gaps_10_exact_fit_utility() {
        
        let node_a = GenerateNodes.generate()
        node_a.currentSize = 0
        node_a.childrenSize = 0
        node_a.requestedGrowthFromChildren = 10
        
        let node_b = GenerateNodes.generate()
        node_b.currentSize = 0
        node_b.childrenSize = 0
        node_b.requestedGrowthFromChildren = 10
        
        let nodes =  [node_a, node_b]
        let section_a = GenerateSections.generate(nodes: nodes)
        let sections = [section_a]
        
        let row_a = GenerateRows.generate(sections: sections)
        let rows = [row_a]
        
        let node_rule = SkeletonLinkageRule_Nodes(nodes: nodes,
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 1000
        
        if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                    sections: sections,
                                                                                                    rows: rows,
                                                                                                    book: book,
                                                                                                    times: 1) {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func grow_large_piece_grow_no_gaps_10_miss_by_1_a() {
        
        var pieceListA = GeneratePieces.generate_n(10, size: 0)
        pieceListA.append(GeneratePieces.generate(size: 1))
        
        var pieceListB = GeneratePieces.generate_n(11, size: 0)
        pieceListB.append(GeneratePieces.generate(size: 1))
        
        let piece_rule_a = SkeletonLinkageRule_Pieces(pieces: pieceListA, layoutPriority: .required)
        let piece_rule_b = SkeletonLinkageRule_Pieces(pieces: pieceListB, layoutPriority: .required)
        
        let node_a = GenerateNodes.generate(pieces: pieceListA)
        node_a.currentSize = 0
        node_a.childrenSize = 0
        
        let node_b = GenerateNodes.generate(pieces: pieceListB)
        node_b.currentSize = 0
        node_b.childrenSize = 0
        
        let section_a = GenerateSections.generate(nodes: [node_a, node_b])
        let row_a = GenerateRows.generate(sections: [section_a])
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b],
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [piece_rule_a, piece_rule_b])
        
        row_a.growthBudget = 20
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(node_a.currentSize == 0)
        #expect(node_a.childrenSize == 0)
        #expect(node_b.currentSize == 0 )
        #expect(node_b.childrenSize == 0 )
        #expect(section_a.currentSize == 0)
        #expect(row_a.growthBudget == 20)
        
        let stepResult1 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        #expect(stepResult1 == true)
        
        #expect(node_a.currentSize == 10)
        #expect(node_a.childrenSize == 10)
        #expect(node_b.currentSize == 10)
        #expect(node_b.childrenSize == 0)
        #expect(section_a.currentSize == 20)
        #expect(row_a.growthBudget == 0)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
            #expect(extraCheck == false)
            #expect(node_a.currentSize == 10)
            #expect(node_a.childrenSize == 10)
            #expect(node_b.currentSize == 10)
            #expect(node_b.childrenSize == 0)
            #expect(section_a.currentSize == 20)
            #expect(row_a.growthBudget == 0)
        }
    }
    
    @MainActor @Test func grow_large_piece_grow_no_gaps_10_miss_by_1_a_utility() {
        
        let node_a = GenerateNodes.generate(pieces: [])
        node_a.currentSize = 0
        node_a.childrenSize = 0
        node_a.requestedGrowthFromChildren = 10
        
        let node_b = GenerateNodes.generate(pieces: [])
        node_b.currentSize = 0
        node_b.childrenSize = 0
        node_b.requestedGrowthFromChildren = 11
        
        let nodes = [node_a, node_b]
        
        let section_a = GenerateSections.generate(nodes: nodes)
        let sections = [section_a]
        
        let row_a = GenerateRows.generate(sections: sections)
        let rows = [row_a]
        let node_rule = SkeletonLinkageRule_Nodes(nodes: nodes,
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 20
        
        if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                    sections: sections,
                                                                                                    rows: rows,
                                                                                                    book: book,
                                                                                                    times: 1) {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func grow_large_piece_grow_no_gaps_10_miss_by_1_b() {
        
        var pieceListA = GeneratePieces.generate_n(11, size: 0)
        pieceListA.append(GeneratePieces.generate(size: 1))
        
        var pieceListB = GeneratePieces.generate_n(10, size: 0)
        pieceListB.append(GeneratePieces.generate(size: 1))
        
        let piece_rule_a = SkeletonLinkageRule_Pieces(pieces: pieceListA, layoutPriority: .required)
        let piece_rule_b = SkeletonLinkageRule_Pieces(pieces: pieceListB, layoutPriority: .required)
        
        let node_a = GenerateNodes.generate(pieces: pieceListA)
        node_a.currentSize = 0
        node_a.childrenSize = 0
        
        let node_b = GenerateNodes.generate(pieces: pieceListB)
        node_b.currentSize = 0
        node_b.childrenSize = 0
        
        let section_a = GenerateSections.generate(nodes: [node_a, node_b])
        let row_a = GenerateRows.generate(sections: [section_a])
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b],
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [piece_rule_a, piece_rule_b])
        
        row_a.growthBudget = 20
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(node_a.currentSize == 0)
        #expect(node_a.childrenSize == 0)
        #expect(node_b.currentSize == 0 )
        #expect(node_b.childrenSize == 0 )
        #expect(section_a.currentSize == 0)
        #expect(row_a.growthBudget == 20)
        
        let stepResult1 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        #expect(stepResult1 == true)
        
        #expect(node_a.currentSize == 10)
        #expect(node_a.childrenSize == 0)
        #expect(node_b.currentSize == 10)
        #expect(node_b.childrenSize == 10)
        #expect(section_a.currentSize == 20)
        #expect(row_a.growthBudget == 0)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
            #expect(extraCheck == false)
            #expect(node_a.currentSize == 10)
            #expect(node_a.childrenSize == 0)
            #expect(node_b.currentSize == 10)
            #expect(node_b.childrenSize == 10)
            #expect(section_a.currentSize == 20)
            #expect(row_a.growthBudget == 0)
        }
    }
    
    @MainActor @Test func grow_large_piece_grow_no_gaps_10_miss_by_1_b_utility() {
        
        let node_a = GenerateNodes.generate(pieces: [])
        node_a.currentSize = 0
        node_a.childrenSize = 0
        node_a.requestedGrowthFromChildren = 11
        
        let node_b = GenerateNodes.generate(pieces: [])
        node_b.currentSize = 0
        node_b.childrenSize = 0
        node_b.requestedGrowthFromChildren = 10
        
        let nodes = [node_a, node_b]
        let section_a = GenerateSections.generate(nodes: nodes)
        let sections = [section_a]
        let row_a = GenerateRows.generate(sections: sections)
        let rows = [row_a]
        let node_rule = SkeletonLinkageRule_Nodes(nodes: nodes,
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 20
        
        if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                    sections: sections,
                                                                                                    rows: rows,
                                                                                                    book: book,
                                                                                                    times: 1) {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func grow_large_piece_grow_no_gaps_10_miss_by_1_c() {
        
        var pieceListA = GeneratePieces.generate_n(10, size: 0)
        pieceListA.append(GeneratePieces.generate(size: 1))
        
        var pieceListB = GeneratePieces.generate_n(10, size: 0)
        pieceListB.append(GeneratePieces.generate(size: 1))
        
        let piece_rule_a = SkeletonLinkageRule_Pieces(pieces: pieceListA, layoutPriority: .required)
        let piece_rule_b = SkeletonLinkageRule_Pieces(pieces: pieceListB, layoutPriority: .required)
        
        let node_a = GenerateNodes.generate(pieces: pieceListA)
        node_a.currentSize = 0
        node_a.childrenSize = 0
        
        let node_b = GenerateNodes.generate(pieces: pieceListB)
        node_b.currentSize = 0
        node_b.childrenSize = 0
        
        let section_a = GenerateSections.generate(nodes: [node_a, node_b])
        let row_a = GenerateRows.generate(sections: [section_a])
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b],
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [piece_rule_a, piece_rule_b])
        
        row_a.growthBudget = 19
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(node_a.currentSize == 0)
        #expect(node_a.childrenSize == 0)
        #expect(node_b.currentSize == 0 )
        #expect(node_b.childrenSize == 0 )
        #expect(section_a.currentSize == 0)
        #expect(row_a.growthBudget == 19)
        
        let stepResult1 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        #expect(stepResult1 == true)
        
        #expect(node_a.currentSize == 9)
        #expect(node_a.childrenSize == 0)
        #expect(node_b.currentSize == 9)
        #expect(node_b.childrenSize == 0)
        #expect(section_a.currentSize == 18)
        #expect(row_a.growthBudget == 1)
        
        let stepResult2 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        #expect(stepResult2 == false)
        
        #expect(node_a.currentSize == 9)
        #expect(node_a.childrenSize == 0)
        #expect(node_b.currentSize == 9)
        #expect(node_b.childrenSize == 0)
        #expect(section_a.currentSize == 18)
        #expect(row_a.growthBudget == 1)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
            #expect(extraCheck == false)
            #expect(node_a.currentSize == 9)
            #expect(node_a.childrenSize == 0)
            #expect(node_b.currentSize == 9)
            #expect(node_b.childrenSize == 0)
            #expect(section_a.currentSize == 18)
            #expect(row_a.growthBudget == 1)
        }
        
    }
    
    @MainActor @Test func grow_large_piece_grow_no_gaps_10_miss_by_1_c_utility() {
        
        let node_a = GenerateNodes.generate(pieces: [])
        node_a.currentSize = 0
        node_a.childrenSize = 0
        node_a.requestedGrowthFromChildren = 10
        
        let node_b = GenerateNodes.generate(pieces: [])
        node_b.currentSize = 0
        node_b.childrenSize = 0
        node_b.requestedGrowthFromChildren = 10
        
        let nodes = [node_a, node_b]
        let section_a = GenerateSections.generate(nodes: [node_a, node_b])
        let sections = [section_a]
        let row_a = GenerateRows.generate(sections: [section_a])
        let rows = [row_a]
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b],
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 19
        
        if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                    sections: sections,
                                                                                                    rows: rows,
                                                                                                    book: book,
                                                                                                    times: 1) {
            #expect(Bool(false))
            return
        }
    }
    
    
    @MainActor @Test func grow_3_nodes_test_2_2_weave_a() {
        
        let piece_a_1 = GeneratePieces.generate(size: 2)
        let piece_a_2 = GeneratePieces.generate(size: 2)
        let piece_b_1 = GeneratePieces.generate(size: 2)
        let piece_b_2 = GeneratePieces.generate(size: 2)
        let piece_grow_1 = GeneratePieces.generate(size: 4)
        let piece_grow_2 = GeneratePieces.generate(size: 4)
        let piece_rule_a = SkeletonLinkageRule_Pieces(pieces: [piece_a_1, piece_b_1, piece_grow_1], layoutPriority: .required)
        let piece_rule_b = SkeletonLinkageRule_Pieces(pieces: [piece_a_2, piece_b_2, piece_grow_2], layoutPriority: .required)
        let node_a = GenerateNodes.generate(pieces: [piece_a_1, piece_a_2, piece_grow_1])
        let node_b = GenerateNodes.generate(pieces: [piece_b_1, piece_b_2, piece_grow_2])
        let section_a = GenerateSections.generate(nodes: [node_a, node_b])
        let row_a = GenerateRows.generate(sections: [section_a])
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b],
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [piece_rule_a, piece_rule_b])
        
        row_a.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(piece_a_1.currentSize == 2)
        #expect(piece_a_2.currentSize == 2)
        #expect(piece_b_1.currentSize == 2)
        #expect(piece_b_2.currentSize == 2)
        #expect(piece_grow_1.currentSize == 4)
        #expect(piece_grow_2.currentSize == 4)
        #expect(node_a.currentSize == 8)
        #expect(node_b.currentSize == 8)
        #expect(node_a.childrenSize == 8)
        #expect(node_b.childrenSize == 8)
        #expect(section_a.currentSize == (node_a.currentSize + node_b.currentSize))
        #expect(row_a.growthBudget == (1000))
        
        let stepResult1 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        #expect(stepResult1 == true)
        
        #expect(piece_a_1.currentSize == 3)
        #expect(piece_a_2.currentSize == 3)
        #expect(piece_b_1.currentSize == 3)
        #expect(piece_b_2.currentSize == 3)
        #expect(piece_grow_1.currentSize == 4)
        #expect(piece_grow_2.currentSize == 4)
        #expect(node_a.currentSize == 10)
        #expect(node_b.currentSize == 10)
        #expect(node_a.childrenSize == 10)
        #expect(node_b.childrenSize == 10)
        #expect(section_a.currentSize == (node_a.currentSize + node_b.currentSize))
        #expect(row_a.growthBudget == (1000 - 4))
        
        let stepResult2 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        #expect(stepResult2 == true)
        #expect(piece_a_1.currentSize == 4)
        #expect(piece_a_2.currentSize == 4)
        #expect(piece_b_1.currentSize == 4)
        #expect(piece_b_2.currentSize == 4)
        #expect(piece_grow_1.currentSize == 4)
        #expect(piece_grow_2.currentSize == 4)
        #expect(node_a.currentSize == 12)
        #expect(node_b.currentSize == 12)
        #expect(node_a.childrenSize == 12)
        #expect(node_b.childrenSize == 12)
        #expect(section_a.currentSize == (node_a.currentSize + node_b.currentSize))
        #expect(row_a.growthBudget == (1000 - 8))
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
            #expect(extraCheck == false)
            #expect(stepResult2 == true)
            #expect(piece_a_1.currentSize == 4)
            #expect(piece_a_2.currentSize == 4)
            #expect(piece_b_1.currentSize == 4)
            #expect(piece_b_2.currentSize == 4)
            #expect(piece_grow_1.currentSize == 4)
            #expect(piece_grow_2.currentSize == 4)
            #expect(node_a.currentSize == 12)
            #expect(node_b.currentSize == 12)
            #expect(node_a.childrenSize == 12)
            #expect(node_b.childrenSize == 12)
            #expect(section_a.currentSize == (node_a.currentSize + node_b.currentSize))
            #expect(row_a.growthBudget == (1000 - 8))
        }
    }
    
    @MainActor @Test func grow_3_nodes_test_2_2_weave_a_utility() {
        
        let node_a = GenerateNodes.generate(pieces: [])
        node_a.currentSize = 8
        node_a.childrenSize = 8
        node_a.requestedGrowthFromChildren = 2
        
        
        let node_b = GenerateNodes.generate(pieces: [])
        node_b.currentSize = 8
        node_b.childrenSize = 8
        node_b.requestedGrowthFromChildren = 2
        
        let nodes = [node_a, node_b]
        
        let section_a = GenerateSections.generate(nodes: nodes)
        let sections = [section_a]
        
        let row_a = GenerateRows.generate(sections: [section_a])
        let rows = [row_a]
        
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b],
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [])
        
        row_a.growthBudget = 1000
        
        if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                    sections: sections,
                                                                                                    rows: rows,
                                                                                                    book: book,
                                                                                                    times: 1) {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func grow_3_nodes_test_case_7_7_7_equal_target() {
        
        let nr_a = GenerateNodes.generate_growing_pieces(childrenSize: 4, currentSize: 4, growCount: 3, amount: 1)
        let nr_b = GenerateNodes.generate_growing_pieces(childrenSize: 2, currentSize: 2, growCount: 5, amount: 1)
        let nr_c = GenerateNodes.generate_growing_pieces(childrenSize: 6, currentSize: 6, growCount: 1, amount: 1)
        
        let node_a = nr_a.0
        node_a.childrenSize = node_a.currentSize
        
        let node_b = nr_b.0
        node_b.childrenSize = node_b.currentSize
        
        let node_c = nr_c.0
        node_c.childrenSize = node_c.currentSize
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: [node_a, node_b, node_c])
        let row_a = GenerateRows.generate(sections: [section_a])
        
        //let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c], layoutPriority: .required)
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c],
                                                  layoutPriority: .required)
        
        let book = SkeletonBook(rows: [row_a],
                                nodeRules: [node_rule],
                                flexerRules: [],
                                pieceRules: [nr_a.1, nr_b.1, nr_c.1])
        
        row_a.growthBudget = 100
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        let stepResult1 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        #expect(stepResult1 == true)
        #expect(node_a.currentSize == 7)
        #expect(node_b.currentSize == 7)
        #expect(node_c.currentSize == 7)
        #expect(section_a.currentSize == 21)
        #expect(row_a.growthBudget == (100 - 9))
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
            #expect(extraCheck == false)
            #expect(node_a.currentSize == 7)
            #expect(node_b.currentSize == 7)
            #expect(node_c.currentSize == 7)
            #expect(section_a.currentSize == 21)
            #expect(row_a.growthBudget == (100 - 9))
        }
    }
    
    @MainActor @Test func grow_3_nodes_test_case_7_7_7_equal_target_utility() {
        
        let nr_a = GenerateNodes.generate(size: 4)
        nr_a.requestedGrowthFromChildren = 3
        
        let nr_b = GenerateNodes.generate(size: 2)
        nr_b.requestedGrowthFromChildren = 5
        
        let nr_c = GenerateNodes.generate(size: 6)
        nr_c.requestedGrowthFromChildren = 1
        
        let nodes = [nr_a, nr_b, nr_c]
        
        let section_a = GenerateSections.generate_currentSizeAccumulate(nodes: nodes)
        let sections = [section_a]
        
        let row_a = GenerateRows.generate(sections: sections)
        let rows = [row_a]
        let node_rule = SkeletonLinkageRule_Nodes(nodes: [nr_a, nr_b, nr_c],
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
        
        let nr_a = GenerateNodes.generate_growing_pieces(childrenSize: 10, currentSize: 10, growCount: 10, amount: 1)
        let node_a = nr_a.0
        
        let nr_b = GenerateNodes.generate_growing_pieces(childrenSize: 10, currentSize: 10, growCount: 10, amount: 1)
        let node_b = nr_b.0
        
        let nr_c = GenerateNodes.generate_growing_pieces(childrenSize: 5, currentSize: 10, growCount: 10, amount: 1)
        let node_c = nr_c.0
        
        let nr_d = GenerateNodes.generate_growing_pieces(childrenSize: 5, currentSize: 5, growCount: 15, amount: 1)
        let node_d = nr_d.0
        
        let nr_e = GenerateNodes.generate_growing_pieces(childrenSize: 5, currentSize: 10, growCount: 10, amount: 1)
        let node_e = nr_e.0
        
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
                                pieceRules: [nr_a.1, nr_b.1, nr_c.1, nr_d.1, nr_e.1])
        
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
        
        let stepResult1 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        
        #expect(stepResult1 == true)
        #expect(node_a.currentSize == 15)
        #expect(node_a.childrenSize == 10)
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
        
        let stepResult2 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        
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
            let extraCheck = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
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
        
        let nr_a = GenerateNodes.generate_growing_pieces(childrenSize: 10, currentSize: 10, growCount: 10, amount: 1)
        let node_a = nr_a.0
        
        let nr_b = GenerateNodes.generate_growing_pieces(childrenSize: 10, currentSize: 10, growCount: 10, amount: 1)
        let node_b = nr_b.0
        
        let nr_c = GenerateNodes.generate_growing_pieces(childrenSize: 5, currentSize: 10, growCount: 10, amount: 1)
        let node_c = nr_c.0
        
        let nr_d = GenerateNodes.generate_growing_pieces(childrenSize: 5, currentSize: 5, growCount: 15, amount: 1)
        let node_d = nr_d.0
        
        let nr_e = GenerateNodes.generate_growing_pieces(childrenSize: 5, currentSize: 10, growCount: 10, amount: 1)
        let node_e = nr_e.0
        
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
                                pieceRules: [nr_a.1, nr_b.1, nr_c.1, nr_d.1, nr_e.1])
        
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
        
        let nr_a = GenerateNodes.generate_growing_pieces(childrenSize: 10, currentSize: 15, growCount: 5, amount: 1)
        let node_a = nr_a.0
        
        let nr_b = GenerateNodes.generate_growing_pieces(childrenSize: 0, currentSize: 5, growCount: 15, amount: 1)
        let node_b = nr_b.0
        
        let nr_c = GenerateNodes.generate_growing_pieces(childrenSize: 0, currentSize: 10, growCount: 15, amount: 1)
        let node_c = nr_c.0
        
        let nr_d = GenerateNodes.generate_growing_pieces(childrenSize: 10, currentSize: 15, growCount: 30, amount: 1)
        let node_d = nr_d.0
        
        let nr_e = GenerateNodes.generate_growing_pieces(childrenSize: 0, currentSize: 5, growCount: 20, amount: 1)
        let node_e = nr_e.0
        
        
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
                                pieceRules: [nr_a.1, nr_b.1, nr_c.1, nr_d.1, nr_e.1])
        
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
        
        let stepResult1 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        #expect(stepResult1 == true)
        #expect(node_a.currentSize == 15)
        #expect(node_a.childrenSize == 15)
        #expect(node_b.currentSize == 15)
        #expect(node_b.childrenSize == 15)
        #expect(node_c.currentSize == 15)
        #expect(node_c.childrenSize == 15)
        #expect(node_d.currentSize == 20)
        #expect(node_d.childrenSize == 10)
        #expect(node_e.currentSize == 20)
        #expect(node_e.childrenSize == 20)
        #expect(section_a.currentSize == 30)
        #expect(section_b.currentSize == 55)
        #expect(row_a.growthBudget == 55)
        
        let stepResult2 = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
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
            let extraCheck = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
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
        
        let nr_a = GenerateNodes.generate_growing_pieces(childrenSize: 10, currentSize: 15, growCount: 5, amount: 1)
        let node_a = nr_a.0
        
        let nr_b = GenerateNodes.generate_growing_pieces(childrenSize: 0, currentSize: 5, growCount: 15, amount: 1)
        let node_b = nr_b.0
        
        let nr_c = GenerateNodes.generate_growing_pieces(childrenSize: 0, currentSize: 10, growCount: 15, amount: 1)
        let node_c = nr_c.0
        
        let nr_d = GenerateNodes.generate_growing_pieces(childrenSize: 10, currentSize: 15, growCount: 30, amount: 1)
        let node_d = nr_d.0
        
        let nr_e = GenerateNodes.generate_growing_pieces(childrenSize: 0, currentSize: 5, growCount: 20, amount: 1)
        let node_e = nr_e.0
        
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
                                pieceRules: [nr_a.1, nr_b.1, nr_c.1, nr_d.1, nr_e.1])
        
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
    
    @Test @MainActor func testFailingRandomCase_A() {
        
        let nnod_a = GenerateNodes.generate_growing_pieces(childrenSize: 1, currentSize: 2, growCount: 2, amount: 1)
        let nod_a = nnod_a.0
        nod_a.name = "A"
        
        let nnod_b = GenerateNodes.generate_growing_pieces(childrenSize: 2, currentSize: 2, growCount: 0, amount: 1)
        let nod_b = nnod_b.0
        nod_b.name = "B"
        
        let sec_a = GenerateSections.generate(nodes: [nod_a, nod_b])
        sec_a.currentSize = 4
        
        
        let row_a = GenerateRows.generate(sections:  [sec_a])
        row_a.growthBudget = 1000
        
        var pieceRules = [SkeletonLinkageRule_Pieces]()
        pieceRules.append(nnod_a.1)
        pieceRules.append(nnod_b.1)
        
        let rows = [row_a]
        let nodeRules = [SkeletonLinkageRule_Nodes(nodes: [nod_a], layoutPriority: LayoutPriority.required),
                         SkeletonLinkageRule_Nodes(nodes: [nod_b], layoutPriority: LayoutPriority.required)]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: nodeRules,
                                flexerRules: [],
                                pieceRules: pieceRules)
        
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(nod_a.childrenSize == 1)
        #expect(nod_a.currentSize == 2)
        #expect(nod_b.childrenSize == 2)
        #expect(nod_b.currentSize == 2)
        #expect(sec_a.currentSize == 4)
        #expect(row_a.growthBudget == 1000)
        
        let pulseResultA = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
        #expect(pulseResultA == true)
        #expect(nod_a.childrenSize == 3)
        #expect(nod_a.currentSize == 3)
        #expect(nod_b.childrenSize == 2)
        #expect(nod_b.currentSize == 2)
        #expect(sec_a.currentSize == 5)
        #expect(row_a.growthBudget == 999)
        
        for _ in 0..<4 {
            let extraCheck = SmartLayoutExpanderPulse.step_b_apply_piece_group_rules()
            #expect(extraCheck == false)
            #expect(nod_a.childrenSize == 3)
            #expect(nod_a.currentSize == 3)
            #expect(nod_b.childrenSize == 2)
            #expect(nod_b.currentSize == 2)
            #expect(sec_a.currentSize == 5)
            #expect(row_a.growthBudget == 999)
        }
    }
    
    @Test @MainActor func testFailingRandomCase_A_utility() {
        
        let nnod_a = GenerateNodes.generate_growing_pieces(childrenSize: 1, currentSize: 2, growCount: 2, amount: 1)
        let nod_a = nnod_a.0
        let nnod_b = GenerateNodes.generate_growing_pieces(childrenSize: 2, currentSize: 2, growCount: 0, amount: 1)
        let nod_b = nnod_b.0
        
        let sec_a = GenerateSections.generate(nodes: [nod_a, nod_b])
        sec_a.currentSize = 4
        
        
        let row_a = GenerateRows.generate(sections:  [sec_a])
        row_a.growthBudget = 1000
        
        
        var pieceRules = [SkeletonLinkageRule_Pieces]()
        pieceRules.append(nnod_a.1)
        pieceRules.append(nnod_b.1)
        
        let rows = [row_a]
        let sections = [sec_a]
        let nodes = [nod_a, nod_b]
        let nodeRules = [SkeletonLinkageRule_Nodes(nodes: [nod_a], layoutPriority: LayoutPriority.required),
                         SkeletonLinkageRule_Nodes(nodes: [nod_b], layoutPriority: LayoutPriority.required)]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: nodeRules,
                                flexerRules: [],
                                pieceRules: pieceRules)
        
        
        if !DoubleVerifyNodeGrowthTool.testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: nodes,
                                                                                                    sections: sections,
                                                                                                    rows: rows,
                                                                                                    book: book,
                                                                                                    times: 3) {
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
                
                
                var piece_rules = [SkeletonLinkageRule_Pieces]()
                var node_rules = [SkeletonLinkageRule_Nodes]()
                var nodes = [WiseLayoutNode]()
                for items in partition {
                    
                    var subnodes = [WiseLayoutNode]()
                    for item in items {
                        let node = GenerateNodes.generate_growing_pieces(childrenSize: item.childrenSize,
                                                                         currentSize: item.currentSize,
                                                                         growCount: item.wtg,
                                                                         amount: 1)
                        subnodes.append(node.0)
                        piece_rules.append(node.1)
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
                                        pieceRules: piece_rules)
                
                for row in rows {
                    row.growthBudget = Int.random(in: 0...100)
                }
                
                
                //book.codegen_grow_node_with_piece_group()
                
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
                
                
                var piece_rules = [SkeletonLinkageRule_Pieces]()
                var node_rules = [SkeletonLinkageRule_Nodes]()
                var nodes = [WiseLayoutNode]()
                for items in partition {
                    
                    var subnodes = [WiseLayoutNode]()
                    for item in items {
                        let node = GenerateNodes.generate_growing_pieces(childrenSize: item.childrenSize,
                                                                         currentSize: item.currentSize,
                                                                         growCount: item.wtg,
                                                                         amount: 1)
                        subnodes.append(node.0)
                        piece_rules.append(node.1)
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
                                        pieceRules: piece_rules)
                
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
                
                
                var piece_rules = [SkeletonLinkageRule_Pieces]()
                var node_rules = [SkeletonLinkageRule_Nodes]()
                var nodes = [WiseLayoutNode]()
                for items in partition {
                    
                    var subnodes = [WiseLayoutNode]()
                    for item in items {
                        let node = GenerateNodes.generate_growing_pieces(childrenSize: item.childrenSize,
                                                                         currentSize: item.currentSize,
                                                                         growCount: item.wtg,
                                                                         amount: 1)
                        subnodes.append(node.0)
                        piece_rules.append(node.1)
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
                                        pieceRules: piece_rules)
                
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
                
                
                var piece_rules = [SkeletonLinkageRule_Pieces]()
                var node_rules = [SkeletonLinkageRule_Nodes]()
                var nodes = [WiseLayoutNode]()
                for items in partition {
                    
                    var subnodes = [WiseLayoutNode]()
                    for item in items {
                        let node = GenerateNodes.generate_growing_pieces(childrenSize: item.childrenSize,
                                                                         currentSize: item.currentSize,
                                                                         growCount: item.wtg,
                                                                         amount: 1)
                        subnodes.append(node.0)
                        piece_rules.append(node.1)
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
                                        pieceRules: piece_rules)
                
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
