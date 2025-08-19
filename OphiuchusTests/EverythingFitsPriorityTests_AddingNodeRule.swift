//
//  EverythingFitsPriorityTests_AddingNodeRule.swift
//  OphiuchusTests
//
//  Created by Nick on 8/15/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct EverythingFitsPriorityTests_AddingNodeRule {
    
    @MainActor @Test func test_thunk_up_case_a() {
        
        // Step 0, before pulse
        //  pce_a = 4, pce_b = 8, pce_c = 4, pce_d = 4
        //  flx_a = 0, flx_b = 0, flx_b = 0
        //  nod_a = 12, nod_b = 8
        
        // Step 1, required (no rules active)
        //  pce_a = 4, pce_b = 8, pce_c = 4, pce_d = 4
        //  flx_a = 2, flx_b = 8, flx_b = 2
        //  nod_a = 22, nod_b = 10
        
        // Step 2, high (NODE rules active)
        //  pce_a = 4, pce_b = 8, pce_c = 4, pce_d = 4
        //  flx_a = 2, flx_b = 8, flx_b = 4 (targets are 4, 10, 4)
        //  nod_a = 22, nod_b = 22
        
        // Step 3, medium (NODE rules active, FLEXER rules active)
        //  pce_a = 4, pce_b = 8, pce_c = 4, pce_d = 4
        //  flx_a = 2, flx_b = 8, flx_b = 4 (targets are 6, 12, 4)
        //  nod_a = 22, nod_b = 22 (targets are 30 and 12)
        
        // Step 4, low (NODE rules active, FLEXER rules active, PIECE rules active...)
        //  pce_a = 4, pce_b = 8, pce_b = 4, pce_b = 4
        //  flx_a = 2, flx_b = 8, flx_b = 4 (targets are 8, 14, 6)
        //  nod_a = 22, nod_b = 22 (targets are 30 and 12)
        
        let pce_a = GeneratePieces.generate(size: 4)
        let pce_b = GeneratePieces.generate(size: 8)
        let pce_c = GeneratePieces.generate(size: 4)
        let pce_d = GeneratePieces.generate(size: 4)
        
        let pieceRules = [SkeletonLinkageRule_Pieces(pieces: [pce_b, pce_d], layoutPriority: LayoutPriority.low)]
        
        let flx_a = GenerateFlexers.generate(2, 4, 6, 24, 36)
        let flx_b = GenerateFlexers.generate(8, 10, 12, 24, 64)
        let flx_c = GenerateFlexers.generate(2, 4, 4, 42, 64)
        let flexerRules = [SkeletonLinkageRule_Flexers(flexers: [flx_a, flx_b, flx_c], layoutPriority: LayoutPriority.medium)]
        
        let nod_a = GenerateNodes.generate(pieces: [pce_a, pce_b], flexers: [flx_a, flx_b])
        let nod_b = GenerateNodes.generate(pieces: [pce_c, pce_d], flexers: [flx_c])
        let nodeRules = [SkeletonLinkageRule_Nodes(nodes: [nod_a, nod_b], layoutPriority: LayoutPriority.high)]
        
        let sec_a = GenerateSections.generate(nodes: [nod_a])
        let sec_b = GenerateSections.generate(nodes: [nod_b])
        
        let row_a = GenerateRows.generate(sections:  [sec_a])
        let row_b = GenerateRows.generate(sections:  [sec_b])
        
        let rows = [row_a, row_b]
        let book = SkeletonBook(rows: rows,
                                nodeRules: nodeRules,
                                flexerRules: flexerRules,
                                pieceRules: pieceRules)
        row_a.growthBudget = 1000
        row_b.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        
        // Step 0, before pulse
        //  pce_a = 4, pce_b = 8, pce_b = 4, pce_b = 4
        //  flx_a = 0, flx_b = 0, flx_b = 0
        //  nod_a = 12, nod_b = 8
        
        
        #expect(pce_a.currentSize == 4)
        #expect(pce_b.currentSize == 8)
        #expect(pce_c.currentSize == 4)
        #expect(pce_d.currentSize == 4)
        
        #expect(flx_a.currentSize == 0)
        #expect(flx_b.currentSize == 0)
        #expect(flx_c.currentSize == 0)
        
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 12)
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 8)
        
        #expect(sec_a.currentSize == 12)
        #expect(sec_b.currentSize == 8)
        #expect(row_a.growthBudget == 1000)
        #expect(row_b.growthBudget == 1000)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .required)
        #expect(pce_a.currentSize == 4)
        #expect(pce_b.currentSize == 8)
        #expect(pce_c.currentSize == 4)
        #expect(pce_d.currentSize == 4)
        
        #expect(flx_a.currentSize == 2)
        #expect(flx_b.currentSize == 8)
        #expect(flx_c.currentSize == 2)
        
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 22) // 10 more
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 10) // 2 more
        
        #expect(sec_a.currentSize == 22)
        #expect(sec_b.currentSize == 10)
        #expect(row_a.growthBudget == 1000 - 10)
        #expect(row_b.growthBudget == 1000 - 2)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .high)
        #expect(pce_a.currentSize == 4)
        #expect(pce_b.currentSize == 8)
        #expect(pce_c.currentSize == 4)
        #expect(pce_d.currentSize == 4)
        
        #expect(flx_a.currentSize == 2)
        #expect(flx_b.currentSize == 8)
        #expect(flx_c.currentSize == 4)
        
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 22) // 10 more
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 22) // 2 more
        
        #expect(sec_a.currentSize == 22)
        #expect(sec_b.currentSize == 22)
        #expect(row_a.growthBudget == 1000 - 10)
        #expect(row_b.growthBudget == 1000 - 14)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .medium)
        #expect(pce_a.currentSize == 4)
        #expect(pce_b.currentSize == 8)
        #expect(pce_c.currentSize == 4)
        #expect(pce_d.currentSize == 4)
        
        #expect(flx_a.currentSize == 2)
        #expect(flx_b.currentSize == 8)
        #expect(flx_c.currentSize == 4)
        
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 22) // 10 more
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 22) // 2 more
        
        #expect(sec_a.currentSize == 22)
        #expect(sec_b.currentSize == 22)
        #expect(row_a.growthBudget == 1000 - 10)
        #expect(row_b.growthBudget == 1000 - 14)

        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .low)
        #expect(pce_a.currentSize == 4)
        #expect(pce_b.currentSize == 8)
        #expect(pce_c.currentSize == 4)
        #expect(pce_d.currentSize == 8)
        
        #expect(flx_a.currentSize == 24)
        #expect(flx_b.currentSize == 24)
        #expect(flx_c.currentSize == 24)
        
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 60)
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 60)
        
        #expect(sec_a.currentSize == 60)
        #expect(sec_b.currentSize == 60)
        #expect(row_a.growthBudget == 952)
        #expect(row_b.growthBudget == 948)

        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .finally)
        #expect(pce_a.currentSize == 4)
        #expect(pce_b.currentSize == 8)
        #expect(pce_c.currentSize == 4)
        #expect(pce_d.currentSize == 8)
        
        #expect(flx_a.currentSize == 36)
        #expect(flx_b.currentSize == 36)
        #expect(flx_c.currentSize == 36)
        
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 84) // 10 more
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 84) // 2 more
        
        #expect(sec_a.currentSize == 84)
        #expect(sec_b.currentSize == 84)
        #expect(row_a.growthBudget == 928)
        #expect(row_b.growthBudget == 924)
    }
    
    
    @MainActor @Test func test_failed_case_a() {
        
        // Step 1, required (no rules active)
        //  pce_a = 1, pce_b = 9
        //  flx_a = 1, flx_b = 3
        //  nod_a = 2, nod_b = 12
        
        
        // Step 2, high (pieceRules active)
        //  pce_a = 9, pce_b = 9
        //  flx_a = 2, flx_b = 3
        //  nod_a = 11, nod_b = 12
        
        // Step 3, medium (pieceRules active, node rules active)
        //  pce_a = 9, pce_b = 9
        //  flx_a = 4, flx_b = 5 (clamped at 4)
        //  nod_a = 11, nod_b = 12 (target 13 and 14, clamped at 13)
        
        // Step 4, low (pieceRules active, node rules active, flexer rules active)
        //  pce_a = 9, pce_b = 9
        //  flx_a = 6, flx_b = 6 (targets 7 and 6, should go to 6 and 6)
        //  nod_a = 14, nod_b = 14 (clamped at 14)
        
        // Step 5, finally (pieceRules active, node rules active, flexer rules active)
        //  pce_a = 9, pce_b = 9
        //  flx_a = 6, flx_b = 6 (targets 8 and 6, should go to 6 and 6)
        //  nod_a = 14, nod_b = 14 (clamped at 14)
        
        let pce_a = GeneratePieces.generate(size: 1)
        let pce_b = GeneratePieces.generate(size: 9)
        let pieceRules = [SkeletonLinkageRule_Pieces(pieces: [pce_a, pce_b], layoutPriority: LayoutPriority.high)]
        
        let flx_a = GenerateFlexers.generate(1, 2, 4, 7, 8)
        let flx_b = GenerateFlexers.generate(3, 3, 5, 6, 6)
        let flexerRules = [SkeletonLinkageRule_Flexers(flexers: [flx_a, flx_b], layoutPriority: LayoutPriority.low)]
        
        let nod_a = GenerateNodes.generate(pieces: [pce_a], flexers: [flx_a])
        let nod_b = GenerateNodes.generate(pieces: [pce_b], flexers: [flx_b])
        let nodeRules = [SkeletonLinkageRule_Nodes(nodes: [nod_a, nod_b], layoutPriority: LayoutPriority.medium)]
        
        let sec_a = GenerateSections.generate(nodes: [nod_a, nod_b])
        let row_a = GenerateRows.generate(sections:  [sec_a])
        
        let rows = [row_a]
        let book = SkeletonBook(rows: rows,
                                nodeRules: nodeRules,
                                flexerRules: flexerRules,
                                pieceRules: pieceRules)
        row_a.growthBudget = 1000
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        
        #expect(pce_a.currentSize == 1)
        #expect(pce_b.currentSize == 9)
        #expect(flx_a.currentSize == 0)
        #expect(flx_b.currentSize == 0)
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 1)
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 9)
        #expect(row_a.growthBudget == 1000)
        
        
        // Step 1, required (no rules active)
        //  pce_a = 1, pce_b = 9
        //  flx_a = 1, flx_b = 3
        //  nod_a = 2, nod_b = 12
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .required)
        #expect(pce_a.currentSize == 1)
        #expect(pce_b.currentSize == 9)
        #expect(flx_a.currentSize == 1)
        #expect(flx_b.currentSize == 3)
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 2)
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 12)
        #expect(row_a.growthBudget == 1000 - 4)
        
        // Step 2, high (pieceRules active)
        //  pce_a = 9, pce_b = 9
        //  flx_a = 2, flx_b = 3
        //  nod_a = 11, nod_b = 12
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .high)
        #expect(pce_a.currentSize == 9)
        #expect(pce_b.currentSize == 9)
        #expect(flx_a.currentSize == 2)
        #expect(flx_b.currentSize == 3)
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 11)
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 12)
        #expect(row_a.growthBudget == 987)
        
        
        // Step 3, medium (pieceRules active, node rules active)
        //  pce_a = 9, pce_b = 9
        //  flx_a = 4, flx_b = 5 (clamped at 4)
        //  nod_a = 11, nod_b = 12
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .medium)
        #expect(pce_a.currentSize == 9)
        #expect(pce_b.currentSize == 9)
        #expect(flx_a.currentSize == 4)
        #expect(flx_b.currentSize == 4)
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 13)
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 13)
        #expect(row_a.growthBudget == 984)
        
        // Step 4, low (pieceRules active, node rules active, flexer rules active)
        //  pce_a = 9, pce_b = 9
        //  flx_a = 6, flx_b = 6 (targets 7 and 6, should go to 6 and 6)
        //  nod_a = 14, nod_b = 14 (clamped at 14)
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .low)
        #expect(pce_a.currentSize == 9)
        #expect(pce_b.currentSize == 9)
        #expect(flx_a.currentSize == 6)
        #expect(flx_b.currentSize == 6)
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 15)
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 15)
        #expect(row_a.growthBudget == 980)
        
        // Step 5, finally (pieceRules active, node rules active, flexer rules active)
        //  pce_a = 9, pce_b = 9
        //  flx_a = 6, flx_b = 6 (targets 8 and 6, should go to 6 and 6)
        //  nod_a = 14, nod_b = 14 (clamped at 14)
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .finally)
        #expect(pce_a.currentSize == 9)
        #expect(pce_b.currentSize == 9)
        #expect(flx_a.currentSize == 6)
        #expect(flx_b.currentSize == 6)
        #expect(nod_a.childrenSizeMatchesChildren())
        #expect(nod_a.currentSize == 15)
        #expect(nod_b.childrenSizeMatchesChildren())
        #expect(nod_b.currentSize == 15)
        #expect(row_a.growthBudget == 980)
    }
    
    @MainActor @Test func test_two_linked_flexers_two_linked_nodes_a() {
        
        // Here's that we expect (node rule kicks in at high) (flexer rule kicks in at low)
        
        // 1.)
        //      Flexer A is 10
        //      Flexer B is 5
        //      Node A is 10
        //      Node B is 5
        
        // 2.)
        //      Flexer A is 10
        //      Flexer B is 10
        //      Node A is 10 (This can grow if flexer B grow more)
        //      Node B is 10
        
        // 3.)
        //      Flexer A is 15
        //      Flexer B is 15
        //      Node A is 15 (This can grow if flexer B grow more)
        //      Node B is 15
        
        // 4.)
        //      Flexer A is 20
        //      Flexer B is 20
        //      Node A is 20 (This can grow if flexer B grow more)
        //      Node B is 20
        
        // 5.)
        //      Flexer A is 25
        //      Flexer B is 25
        //      Node A is 25 (This can grow if flexer B grow more)
        //      Node B is 25
        
        
        let flexer_a = Flexer(id: 0, flexerIdentifier: .unknown, 10, 20, 30, 40, 50)
        flexer_a.name = "A"
        
        let flexer_b = Flexer(id: 1, flexerIdentifier: .unknown, 5, 10, 15, 20, 25)
        flexer_b.name = "B"
        
        let node_a = GenerateNodes.generate(flexers: [flexer_a])
        let node_b = GenerateNodes.generate(flexers: [flexer_b])
        let section = GenerateSections.generate(nodes: [node_a, node_b])
        let row = GenerateRows.generate(sections: [section])
        
        
        let rows = [row]
        let nodeRule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b], layoutPriority: .high)
        let flexerRule = SkeletonLinkageRule_Flexers(flexers: [flexer_a, flexer_b], layoutPriority: .low)
        let book = SkeletonBook(rows: rows,
                                nodeRules: [nodeRule],
                                flexerRules: [flexerRule],
                                pieceRules: [])
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        #expect(flexer_a.currentSize == 0)
        #expect(flexer_b.currentSize == 0)
        #expect(node_a.childrenSize == 0)
        #expect(node_a.currentSize == 0)
        #expect(node_b.childrenSize == 0)
        #expect(node_b.currentSize == 0)
        #expect(section.currentSize == 0)
        #expect(row.growthBudget == 1000)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .required)
        #expect(flexer_a.currentSize == 10)
        #expect(flexer_a.targetSizeCurrentPriority == 10)
        #expect(flexer_b.currentSize == 5)
        #expect(flexer_b.targetSizeCurrentPriority == 5)
        #expect(node_a.childrenSize == 10)
        #expect(node_a.currentSize == 10)
        #expect(node_b.childrenSize == 5)
        #expect(node_b.currentSize == 5)
        #expect(section.currentSize == 15)
        #expect(row.growthBudget == 985)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .high)
        #expect(flexer_a.currentSize == 10)
        #expect(flexer_a.targetSizeCurrentPriority == 20)
        #expect(flexer_b.currentSize == 10)
        #expect(flexer_b.targetSizeCurrentPriority == 10)
        #expect(node_a.childrenSize == 10)
        #expect(node_a.currentSize == 10)
        #expect(node_b.childrenSize == 10)
        #expect(node_b.currentSize == 10)
        #expect(section.currentSize == 20)
        #expect(row.growthBudget == 980)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .medium)
        #expect(flexer_a.currentSize == 15)
        #expect(flexer_b.currentSize == 15)
        #expect(node_a.childrenSize == 15)
        #expect(node_a.currentSize == 15)
        #expect(node_b.childrenSize == 15)
        #expect(node_b.currentSize == 15)
        #expect(section.currentSize == 30)
        #expect(row.growthBudget == 970)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .low)
        #expect(flexer_a.currentSize == 20)
        #expect(flexer_b.currentSize == 20)
        #expect(node_a.childrenSize == 20)
        #expect(node_a.currentSize == 20)
        #expect(node_b.childrenSize == 20)
        #expect(node_b.currentSize == 20)
        #expect(section.currentSize == 40)
        #expect(row.growthBudget == 960)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .finally)
        #expect(flexer_a.currentSize == 25)
        #expect(flexer_b.currentSize == 25)
        #expect(node_a.childrenSize == 25)
        #expect(node_a.currentSize == 25)
        #expect(node_b.childrenSize == 25)
        #expect(node_b.currentSize == 25)
        #expect(section.currentSize == 50)
        #expect(row.growthBudget == 950)
    }
    
    @MainActor @Test func test_two_linked_flexers_two_linked_nodes_b() {
        
        // Here's that we expect (node rule kicks in at high) (flexer rule kicks in at low)
        
        // 1.) required
        //      Flexer A is 10
        //      Flexer B is 5
        //      Node A is 10
        //      Node B is 5
        
        // 2.) high (node rule kicks in)
        //      Flexer A is 10 (trying for 20), stuck due to node rule...
        //      Flexer B is 10
        //      Node A is 10 (This can grow if flexer B grow more)
        //      Node B is 10
        
        // 3.)
        //      Flexer A is 15
        //      Flexer B is 15
        //      Node A is 15
        //      Node B is 15
        
        // 4.)
        //      Flexer A is 20
        //      Flexer B is 20
        //      Node A is 20 (This can grow if flexer B grow more)
        //      Node B is 20
        
        // 5.)
        //      Flexer A is 25
        //      Flexer B is 25
        //      Node A is 25 (This can grow if flexer B grow more)
        //      Node B is 25
        
        
        let flexer_a = Flexer(id: 0, flexerIdentifier: .unknown, 10, 20, 30, 40, 50)
        flexer_a.name = "A"
        
        let flexer_b = Flexer(id: 1, flexerIdentifier: .unknown, 5, 10, 15, 20, 25)
        flexer_b.name = "B"
        
        let node_a = GenerateNodes.generate(flexers: [flexer_a])
        let node_b = GenerateNodes.generate(flexers: [flexer_b])
        let section = GenerateSections.generate(nodes: [node_a, node_b])
        let row = GenerateRows.generate(sections: [section])
        
        
        let rows = [row]
        let nodeRule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b], layoutPriority: .low)
        let flexerRule = SkeletonLinkageRule_Flexers(flexers: [flexer_a, flexer_b], layoutPriority: .high)
        let book = SkeletonBook(rows: rows,
                                nodeRules: [nodeRule],
                                flexerRules: [flexerRule],
                                pieceRules: [])
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        #expect(flexer_a.currentSize == 0)
        #expect(flexer_b.currentSize == 0)
        #expect(node_a.childrenSize == 0)
        #expect(node_a.currentSize == 0)
        #expect(node_b.childrenSize == 0)
        #expect(node_b.currentSize == 0)
        #expect(section.currentSize == 0)
        #expect(row.growthBudget == 1000)
        
        // 1.) required
        //      Flexer A is 10
        //      Flexer B is 5
        //      Node A is 10
        //      Node B is 5
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .required)
        #expect(flexer_a.currentSize == 10)
        #expect(flexer_a.targetSizeCurrentPriority == 10)
        #expect(flexer_b.currentSize == 5)
        #expect(flexer_b.targetSizeCurrentPriority == 5)
        #expect(node_a.childrenSize == 10)
        #expect(node_a.currentSize == 10)
        #expect(node_b.childrenSize == 5)
        #expect(node_b.currentSize == 5)
        #expect(section.currentSize == 15)
        #expect(row.growthBudget == 985)
        
        // 2.) high (node rule kicks in)
        //      Flexer A is 10 (trying for 20), stuck due to node rule...
        //      Flexer B is 10
        //      Node A is 10 (This can grow if flexer B grow more)
        //      Node B is 10
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .high)
        #expect(flexer_a.currentSize == 10)
        #expect(flexer_a.targetSizeCurrentPriority == 20)
        #expect(flexer_b.currentSize == 10)
        #expect(flexer_b.targetSizeCurrentPriority == 10)
        #expect(node_a.childrenSize == 10)
        #expect(node_a.currentSize == 10)
        #expect(node_b.childrenSize == 10)
        #expect(node_b.currentSize == 10)
        #expect(section.currentSize == 20)
        #expect(row.growthBudget == 980)
        
        // 3.)
        //      Flexer A is 15
        //      Flexer B is 15
        //      Node A is 15
        //      Node B is 15
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .medium)
        #expect(flexer_a.currentSize == 15)
        #expect(flexer_b.currentSize == 15)
        #expect(node_a.childrenSize == 15)
        #expect(node_a.currentSize == 15)
        #expect(node_b.childrenSize == 15)
        #expect(node_b.currentSize == 15)
        #expect(section.currentSize == 30)
        #expect(row.growthBudget == 970)
        
        // 4.)
        //      Flexer A is 20
        //      Flexer B is 20
        //      Node A is 20 (This can grow if flexer B grow more)
        //      Node B is 20
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .low)
        #expect(flexer_a.currentSize == 20)
        #expect(flexer_b.currentSize == 20)
        #expect(node_a.childrenSize == 20)
        #expect(node_a.currentSize == 20)
        #expect(node_b.childrenSize == 20)
        #expect(node_b.currentSize == 20)
        #expect(section.currentSize == 40)
        #expect(row.growthBudget == 960)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .finally)
        #expect(flexer_a.currentSize == 25)
        #expect(flexer_b.currentSize == 25)
        #expect(node_a.childrenSize == 25)
        #expect(node_a.currentSize == 25)
        #expect(node_b.childrenSize == 25)
        #expect(node_b.currentSize == 25)
        #expect(section.currentSize == 50)
        #expect(row.growthBudget == 950)
    }
    
    
    @MainActor @Test func test_two_linked_pieces_two_linked_nodes_a() {
        
        // 1.) [required]
        //      Piece A is 1
        //      Piece B is 2
        //      Node A is 1
        //      Node B is 2
        
        // 2.) [high]
        //      Piece A is 2
        //      Piece B is 2
        //      Node A is 2
        //      Node B is 2
        
        // 3.) [medium]
        //      Piece A is 2
        //      Piece B is 2
        //      Node A is 2
        //      Node B is 2
        
        // 4.) [low]
        //      Piece A is 2
        //      Piece B is 2
        //      Node A is 2
        //      Node B is 2
        
        // 5.) [finally]
        //      Piece A is 2
        //      Piece B is 2
        //      Node A is 2
        //      Node B is 2
        
        
        let piece_a = SkeletonPiece(id: 0, pieceIdentifier: .unknown, size: 1)
        let piece_b = SkeletonPiece(id: 1, pieceIdentifier: .unknown, size: 2)
        let node_a = GenerateNodes.generate(pieces: [piece_a])
        let node_b = GenerateNodes.generate(pieces: [piece_b])
        
        let section_a = GenerateSections.generate(nodes: [node_a])
        let section_b = GenerateSections.generate(nodes: [node_b])
        
        let row = GenerateRows.generate(sections: [section_a, section_b])
        
        
        let rows = [row]
        let nodeRule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b], layoutPriority: .low)
        let pieceRule = SkeletonLinkageRule_Pieces(pieces: [piece_a, piece_b],
                                                   layoutPriority: .high)
        let book = SkeletonBook(rows: rows,
                                nodeRules: [nodeRule],
                                flexerRules: [],
                                pieceRules: [pieceRule])
        
        
        row.growthBudget = 1000
        
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        #expect(piece_a.currentSize == 1)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 1)
        #expect(node_a.currentSize == 1)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section_a.currentSize == 1)
        #expect(section_b.currentSize == 2)
        #expect(row.growthBudget == 1000)
        
        // 1.) [required]
        //      Piece A is 1
        //      Piece B is 2
        //      Node A is 1
        //      Node B is 2
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .required)
        #expect(piece_a.currentSize == 1)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 1)
        #expect(node_a.currentSize == 1)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section_a.currentSize == 1)
        #expect(section_b.currentSize == 2)
        #expect(row.growthBudget == 1000)
        
        // 2.) [high]
        //      Piece A is 2
        //      Piece B is 2
        //      Node A is 2
        //      Node B is 2
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .high)
        #expect(piece_a.currentSize == 2)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 2)
        #expect(node_a.currentSize == 2)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section_a.currentSize == 2)
        #expect(section_b.currentSize == 2)
        #expect(row.growthBudget == 999)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .medium)
        #expect(piece_a.currentSize == 2)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 2)
        #expect(node_a.currentSize == 2)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section_a.currentSize == 2)
        #expect(section_b.currentSize == 2)
        #expect(row.growthBudget == 999)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .low)
        #expect(piece_a.currentSize == 2)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 2)
        #expect(node_a.currentSize == 2)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section_a.currentSize == 2)
        #expect(section_b.currentSize == 2)
        #expect(row.growthBudget == 999)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .finally)
        #expect(piece_a.currentSize == 2)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 2)
        #expect(node_a.currentSize == 2)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section_a.currentSize == 2)
        #expect(section_b.currentSize == 2)
        #expect(row.growthBudget == 999)
    }
    
    @MainActor @Test func test_two_linked_pieces_two_linked_nodes_b() {
        let piece_a = SkeletonPiece(id: 0, pieceIdentifier: .unknown, size: 1)
        let piece_b = SkeletonPiece(id: 1, pieceIdentifier: .unknown, size: 2)
        let node_a = GenerateNodes.generate(pieces: [piece_a])
        let node_b = GenerateNodes.generate(pieces: [piece_b])
        
        let section = GenerateSections.generate(nodes: [node_a, node_b])
        
        let row = GenerateRows.generate(sections: [section])
        
        let rows = [row]
        let nodeRule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b], layoutPriority: .high)
        let pieceRule = SkeletonLinkageRule_Pieces(pieces: [piece_a, piece_b],
                                                   layoutPriority: .low)
        let book = SkeletonBook(rows: rows,
                                nodeRules: [nodeRule],
                                flexerRules: [],
                                pieceRules: [pieceRule])
        
        
        row.growthBudget = 1000
        
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        #expect(piece_a.currentSize == 1)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 1)
        #expect(node_a.currentSize == 1)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section.currentSize == 3)
        #expect(row.growthBudget == 1000)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .required)
        #expect(piece_a.currentSize == 1)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 1)
        #expect(node_a.currentSize == 1)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section.currentSize == 3)
        #expect(row.growthBudget == 1000)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .high)
        #expect(piece_a.currentSize == 1)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 1)
        #expect(node_a.currentSize == 2)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section.currentSize == 4)
        #expect(row.growthBudget == 999)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .medium)
        #expect(piece_a.currentSize == 1)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 1)
        #expect(node_a.currentSize == 2)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section.currentSize == 4)
        #expect(row.growthBudget == 999)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .low)
        #expect(piece_a.currentSize == 2)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 2)
        #expect(node_a.currentSize == 2)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section.currentSize == 4)
        #expect(row.growthBudget == 999)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .finally)
        #expect(piece_a.currentSize == 2)
        #expect(piece_b.currentSize == 2)
        #expect(node_a.childrenSize == 2)
        #expect(node_a.currentSize == 2)
        #expect(node_b.childrenSize == 2)
        #expect(node_b.currentSize == 2)
        #expect(section.currentSize == 4)
        #expect(row.growthBudget == 999)
    }
    
    @MainActor @Test func test_10000_each_rule_randomly_activated() {
        
        //for _ in 0..<1000 {
        
        let flex_a_0 = Int.random(in: 0...3)
        let flex_a_1 = flex_a_0 + Int.random(in: 0...3)
        let flex_a_2 = flex_a_1 + Int.random(in: 0...3)
        let flex_a_3 = flex_a_2 + Int.random(in: 0...3)
        let flex_a_4 = flex_a_3 + Int.random(in: 0...3)
        //let flex_a = [flex_a_0, flex_a_1, flex_a_2, flex_a_3, flex_a_4]
        let flex_a = [1, 2, 4, 7, 8]
        let flexer_a = Flexer(id: 0, flexerIdentifier: .unknown, flex_a[0], flex_a[1], flex_a[2], flex_a[3], flex_a[4])
        
        
        
        let flex_b_0 = Int.random(in: 0...3)
        let flex_b_1 = flex_b_0 + Int.random(in: 0...3)
        let flex_b_2 = flex_b_1 + Int.random(in: 0...3)
        let flex_b_3 = flex_b_2 + Int.random(in: 0...3)
        let flex_b_4 = flex_b_3 + Int.random(in: 0...3)
        //let flex_b = [flex_b_0, flex_b_1, flex_b_2, flex_b_3, flex_b_4]
        let flex_b = [3, 3, 5, 6, 6]
        let flexer_b = Flexer(id: 1, flexerIdentifier: .unknown, flex_b[0], flex_b[1], flex_b[2], flex_b[3], flex_b[4])
        
        
        //let pice_a = Int.random(in: 0...10)
        let pice_a = 1
        let piece_a = SkeletonPiece(id: 0, pieceIdentifier: .unknown, size: pice_a)
        
        //let pice_b = Int.random(in: 0...10)
        let pice_b = 9
        let piece_b = SkeletonPiece(id: 1, pieceIdentifier: .unknown, size: pice_b)
        
        let node_a = GenerateNodes.generate(pieces: [piece_a], flexers: [flexer_a])
        let node_b = GenerateNodes.generate(pieces: [piece_b], flexers: [flexer_b])
        
        let section = GenerateSections.generate(nodes: [node_a, node_b])
        
        let row = GenerateRows.generate(sections: [section])
        
        let rows = [row]
        //let nodeRule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b], layoutPriority: LayoutPriority.random)
        //let pieceRule = SkeletonLinkageRule_Pieces(pieces: [piece_a, piece_b], layoutPriority: LayoutPriority.random)
        //let flexerRule = SkeletonLinkageRule_Flexers(flexers: [flexer_a, flexer_b], layoutPriority: LayoutPriority.random)
        
        let nodeRule = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b], layoutPriority: LayoutPriority.medium)
        let pieceRule = SkeletonLinkageRule_Pieces(pieces: [piece_a, piece_b], layoutPriority: LayoutPriority.high)
        let flexerRule = SkeletonLinkageRule_Flexers(flexers: [flexer_a, flexer_b], layoutPriority: LayoutPriority.low)
        
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [nodeRule],
                                flexerRules: [flexerRule],
                                pieceRules: [pieceRule])
        
        book.codegen()
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        
        var flex_value_a_target = 0
        var flex_value_b_target = 0
        
        var node_a_size = pice_a
        var node_a_children = node_a_size
        
        var node_b_size = pice_b
        var node_b_children = node_b_size
        
        
        var last_piece_a = pice_a
        var last_piece_b = pice_b
        
        var last_flex_a = 0
        var last_flex_b = 0
        
        var last_node_a = node_a_size
        var last_node_b = node_a_size
        
        var layoutIndex = 0
        for layoutPriority in LayoutPriority.all {
            
            print("ON PRIO: \(layoutPriority)")
            
            SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: layoutPriority)
            
            let piece_a_size: Int
            let piece_b_size: Int
            if pieceRule.layoutPriority.gte(layoutPriority: layoutPriority) {
                piece_a_size = max(pice_a, pice_b)
                piece_b_size = max(pice_a, pice_b)
            } else {
                piece_a_size = pice_a
                piece_b_size = pice_b
            }
            
            var target_flex_a = flex_a[layoutIndex]
            var target_flex_b = flex_b[layoutIndex]
            
            if flexerRule.layoutPriority.gte(layoutPriority: layoutPriority) {
                if target_flex_a < last_flex_b {
                    target_flex_a = last_flex_b
                }
                
                if target_flex_b < last_flex_b {
                    target_flex_a = last_flex_b
                }
                
                
                target_flex_a = min(flex_a[layoutIndex], flex_b[layoutIndex])
                target_flex_b = min(flex_a[layoutIndex], flex_b[layoutIndex])
                
                
            } else {
                
            }
            
            
            last_flex_a = flex_a[layoutIndex]
            last_flex_b = flex_b[layoutIndex]
            
            layoutIndex += 1
        }
        
        //}
        
        
    }
}
