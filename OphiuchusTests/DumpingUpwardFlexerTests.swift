//
//  DumpingUpwardFlexerTests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/1/25.
//

import Foundation
import Foundation
import Testing
@testable import Ophiuchus

struct DumpingUpwardFlexerTests {
    
    @Test func test_simple_example_section_needs_to_grow_by_1() {
        
        let flexer = GenerateFlexers.generate_flexer(100)
        let chunk = GenerateChunks.generate_flexer(flexer: flexer)
        let node = GenerateNodes.generate_node(chunk: chunk)
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        
        flexer.current_size = 50
        flexer.target_size = 51
        
        chunk.current_size = 50
        chunk.children_size = 50
        
        node.skeletonNodes[0].current_size = 50
        node.skeletonNodes[0].children_size = 50
        
        section.current_size = 50
        section.children_size = 50
        
        row.remaining_size = 10000
        
        let growPlan = row.getGrowPlan_Flexer(flexers: [flexer])
        guard growPlan.count == 1 else {
            print("Expected a single legitimate grow plan, got \(growPlan.count) grow plans.")
            #expect(Bool(false))
            return
        }
        
        guard growPlan[0].section === section else {
            print("Expected grow plan section to be our section.")
            #expect(Bool(false))
            return
        }
        
        guard growPlan[0].amount == 1 else {
            print("Expected grow plan amount to be exactly 1.")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_simple_example_section_does_not_needs_to_grow_by_1_a() {
        
        let flexer = GenerateFlexers.generate_flexer(100)
        let chunk = GenerateChunks.generate_flexer(flexer: flexer)
        let node = GenerateNodes.generate_node(chunk: chunk)
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        
        flexer.current_size = 50
        flexer.target_size = 51
        
        chunk.current_size = 51
        chunk.children_size = 50
        
        node.skeletonNodes[0].current_size = 50
        node.skeletonNodes[0].children_size = 50
        
        section.current_size = 50
        section.children_size = 50
        
        row.remaining_size = 10000
        
        let growPlan = row.getGrowPlan_Flexer(flexers: [flexer])
        guard growPlan.count == 1 else {
            print("Expected a single legitimate grow plan, got \(growPlan.count) grow plans.")
            #expect(Bool(false))
            return
        }
        
        guard growPlan[0].section === section else {
            print("Expected grow plan section to be our section.")
            #expect(Bool(false))
            return
        }
        
        guard growPlan[0].amount == 0 else {
            print("Expected grow plan amount to be exactly 0.")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_simple_example_section_does_not_needs_to_grow_by_1_b() {
        
        let flexer = GenerateFlexers.generate_flexer(100)
        let chunk = GenerateChunks.generate_flexer(flexer: flexer)
        let node = GenerateNodes.generate_node(chunk: chunk)
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        
        flexer.current_size = 50
        flexer.target_size = 51
        
        chunk.current_size = 50
        chunk.children_size = 50
        
        node.skeletonNodes[0].current_size = 51
        node.skeletonNodes[0].children_size = 50
        
        section.current_size = 50
        section.children_size = 50
        
        row.remaining_size = 10000
        
        let growPlan = row.getGrowPlan_Flexer(flexers: [flexer])
        guard growPlan.count == 1 else {
            print("Expected a single legitimate grow plan, got \(growPlan.count) grow plans.")
            #expect(Bool(false))
            return
        }
        
        guard growPlan[0].section === section else {
            print("Expected grow plan section to be our section.")
            #expect(Bool(false))
            return
        }
        
        guard growPlan[0].amount == 0 else {
            print("Expected grow plan amount to be exactly 0.")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_simple_example_section_does_not_needs_to_grow_by_1_c() {
        
        let flexer = GenerateFlexers.generate_flexer(100)
        let chunk = GenerateChunks.generate_flexer(flexer: flexer)
        let node = GenerateNodes.generate_node(chunk: chunk)
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        
        flexer.current_size = 50
        flexer.target_size = 51
        
        chunk.current_size = 50
        chunk.children_size = 50
        
        node.skeletonNodes[0].current_size = 50
        node.skeletonNodes[0].children_size = 50
        
        section.current_size = 51
        section.children_size = 50
        
        row.remaining_size = 10000
        
        let growPlan = row.getGrowPlan_Flexer(flexers: [flexer])
        guard growPlan.count == 1 else {
            print("Expected a single legitimate grow plan, got \(growPlan.count) grow plans.")
            #expect(Bool(false))
            return
        }
        
        guard growPlan[0].section === section else {
            print("Expected grow plan section to be our section.")
            #expect(Bool(false))
            return
        }
        
        guard growPlan[0].amount == 0 else {
            print("Expected grow plan amount to be exactly 0.")
            #expect(Bool(false))
            return
        }
    }
    
    
    
}
