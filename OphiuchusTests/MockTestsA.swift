//
//  MockTestsA.swift
//  OphiuchusTests
//
//  Created by Nick on 8/10/25.
//

import Foundation
import Foundation
import Testing
@testable import Ophiuchus

struct MockTestsA {
    
    
    @Test func test_first_pulse() {
        
        let flexer_a = GenerateFlexers.generate(currentSize: 1, targetSizeCurrentPriority: 2, name: "A")
        let flexer_b = GenerateFlexers.generate(currentSize: 1, targetSizeCurrentPriority: 2, name: "B")
        let flexer_c = GenerateFlexers.generate(currentSize: 1, targetSizeCurrentPriority: 2, name: "C")
        let flexer_d = GenerateFlexers.generate(currentSize: 1, targetSizeCurrentPriority: 2, name: "D")
        let flexer_e = GenerateFlexers.generate(currentSize: 1, targetSizeCurrentPriority: 2, name: "E")
        let flexer_f = GenerateFlexers.generate(currentSize: 1, targetSizeCurrentPriority: 2, name: "F")
        let flexer_g = GenerateFlexers.generate(currentSize: 1, targetSizeCurrentPriority: 2, name: "G")
        let flexer_h = GenerateFlexers.generate(currentSize: 1, targetSizeCurrentPriority: 2, name: "H")
        
        let node_a = GenerateNodes.generate(currentSize: 3, flexers: [flexer_a, flexer_b, flexer_c])
        let node_b = GenerateNodes.generate(currentSize: 2, flexers: [flexer_d, flexer_e])
        let node_c = GenerateNodes.generate(currentSize: 3, flexers: [flexer_f, flexer_g, flexer_h])
        
        let section_a = GenerateSections.generate(currentSize: 3, nodes: [node_a])
        let section_b = GenerateSections.generate(currentSize: 2, nodes: [node_b])
        let section_c = GenerateSections.generate(currentSize: 3, nodes: [node_c])
        
        let row = GenerateRows.generate(sections: [section_a, section_b, section_c])
        
        let flexer_rule_a = SkeletonLinkageRule_Flexers(flexers: [flexer_a, flexer_c, flexer_f], layoutPriority: .required)
        let flexer_rule_b = SkeletonLinkageRule_Flexers(flexers: [flexer_b, flexer_d], layoutPriority: .required)
        let flexer_rule_c = SkeletonLinkageRule_Flexers(flexers: [flexer_e, flexer_g, flexer_h], layoutPriority: .required)
        
        let node_rule_a = SkeletonLinkageRule_Nodes(nodes: [node_a, node_b, node_c], layoutPriority: .required)
        
        let book = SkeletonBook(rows: [row],
                                nodeRules: [node_rule_a],
                                flexerRules: [flexer_rule_a, flexer_rule_b, flexer_rule_c],
                                pieceRules: [])
        
        book.pages[0].rows[0].growthBudget = 100_000_000
        
        let groupsData = SkeletonLayoutGrouper.getAll(book: book)
        
        // Verify initial state
        guard flexer_a.currentSize == 1, flexer_a.targetSizeCurrentPriority == 2 else {
            fatalError("Flexer A not in initial state!")
        }
        guard flexer_b.currentSize == 1, flexer_b.targetSizeCurrentPriority == 2 else {
            fatalError("Flexer B not in initial state!")
        }
        guard flexer_c.currentSize == 1, flexer_c.targetSizeCurrentPriority == 2 else {
            fatalError("Flexer C not in initial state!")
        }
        guard flexer_d.currentSize == 1, flexer_d.targetSizeCurrentPriority == 2 else {
            fatalError("Flexer D not in initial state!")
        }
        guard flexer_e.currentSize == 1, flexer_e.targetSizeCurrentPriority == 2 else {
            fatalError("Flexer E not in initial state!")
        }
        guard flexer_f.currentSize == 1, flexer_f.targetSizeCurrentPriority == 2 else {
            fatalError("Flexer F not in initial state!")
        }
        guard flexer_g.currentSize == 1, flexer_g.targetSizeCurrentPriority == 2 else {
            fatalError("Flexer G not in initial state!")
        }
        guard flexer_h.currentSize == 1, flexer_h.targetSizeCurrentPriority == 2 else {
            fatalError("Flexer H not in initial state!")
        }
        
        guard node_a.currentSize == 3, node_a.childrenSize == 3 else {
            fatalError("Node A not in initial state!")
        }
        guard node_b.currentSize == 2, node_b.childrenSize == 2 else {
            fatalError("Node B not in initial state!")
        }
        guard node_c.currentSize == 3, node_c.childrenSize == 3 else {
            fatalError("Node C not in initial state!")
        }
        
        guard section_a.currentSize == 3 else {
            fatalError("Section A not in initial state!")
        }
        guard section_b.currentSize == 2 else {
            fatalError("Section B not in initial state!")
        }
        guard section_c.currentSize == 3 else {
            fatalError("Section C not in initial state!")
        }
        
        var exists_a = false
        var exists_b = false
        var exists_c = false
        
        for flexerGroup in groupsData.flexerGroups {
            
            let names = flexerGroup.linkedList.map { $0.name }
            print("group of \(names)")
            
            if flexerGroup.contains(elements: [flexer_a, flexer_c, flexer_f]) {
                if flexerGroup.linkedList.count == 3 {
                    exists_a = true
                }
            }
            if flexerGroup.contains(elements: [flexer_b, flexer_d]) {
                if flexerGroup.linkedList.count == 2 {
                    exists_b = true
                }
            }
            if flexerGroup.contains(elements: [flexer_e, flexer_g, flexer_h]) {
                if flexerGroup.linkedList.count == 3 {
                    exists_c = true
                }
            }
        }
        
        guard groupsData.flexerGroups.count == 3 && (exists_a && exists_b && exists_c) else {
            fatalError("Flexer groups!")
        }
        
        
        guard groupsData.nodeGroups[0].contains(elements: [node_a, node_b, node_c]) &&
            groupsData.nodeGroups[0].linkedList.count == 3 &&
            groupsData.nodeGroups.count == 1 else {
            fatalError("Node groups!")
        }
        
        
        
        
        if !SkeletonLayoutBruteForceExpander.expand_where_possible_pulse(groupData: groupsData) {
            fatalError("Fail! Expected \"expand_where_possible_pulse\" to return true!")
            return
        }
        
        
        
    }
    
    
}
