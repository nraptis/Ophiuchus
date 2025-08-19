//
//  UnderFillToOverFillSimpleTests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/19/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct UnderFillToOverFillSimpleTests {
    
    @MainActor @Test func test_one_flexer_grows_over_no_center() {
        
        let flexer = Flexer(id: 10, flexerIdentifier: .unknown, 2)
        flexer.name = "A"
        
        
        let node = WiseLayoutNode(id: 0, flexers: [flexer])
        let section = SkeletonSection(id: 0, nodes: [node])
        let row = GenerateRows.generate(sections: [section])
        row.snap_minimum_after_children_ready(menuWidthWithSafeArea: 1, safeAreaLeft: 0, safeAreaRight: 0)
        
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [],
                                pieceRules: [])
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        //SmartLayoutExpanderPass.prepare_intelligent(groupData: groupData, layoutPriority: .required)
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .required)
        
        #expect(row.growthBudget == 0)
        #expect(flexer.currentSize == 1)
        #expect(node.currentSize == 1)
        #expect(section.currentSize == 1)
    }
    
    @MainActor @Test func test_one_flexer_grows_over_centered() {
        
        let flexer = Flexer(id: 10, flexerIdentifier: .unknown, 2)
        flexer.name = "A"
        
        
        let node = WiseLayoutNode(id: 0, flexers: [flexer])
        let section = SkeletonSection(id: 0, nodes: [node])
        let row = GenerateRows.generate(sections: [section], centeredSection: section)
        row.snap_minimum_after_children_ready(menuWidthWithSafeArea: 1, safeAreaLeft: 0, safeAreaRight: 0)
        
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [],
                                pieceRules: [])
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        //SmartLayoutExpanderPass.prepare_intelligent(groupData: groupData, layoutPriority: .required)
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .required)
        
        #expect(row.growthBudget == 0)
        #expect(flexer.currentSize == 1)
        #expect(node.currentSize == 1)
        #expect(section.currentSize == 1)
        
        print("now da flexar us \(flexer.currentSize)")
        
        
    }
    
    @MainActor @Test func test_one_flexer_grows_over_lefted() {
        
        let flexer = Flexer(id: 10, flexerIdentifier: .unknown, 2)
        flexer.name = "A"
        
        
        let node = WiseLayoutNode(id: 0, flexers: [flexer])
        let section = SkeletonSection(id: 0, nodes: [node])
        let section_center = SkeletonSection(id: 1, nodes: [])
        let row = GenerateRows.generate(sections: [section, section_center], centeredSection: section_center)
        row.snap_minimum_after_children_ready(menuWidthWithSafeArea: 1, safeAreaLeft: 0, safeAreaRight: 0)
        
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [],
                                pieceRules: [])
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        //SmartLayoutExpanderPass.prepare_intelligent(groupData: groupData, layoutPriority: .required)
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .required)
        
        #expect(row.growthBudget == 0)
        #expect(flexer.currentSize == 1)
        #expect(node.currentSize == 1)
        #expect(section.currentSize == 1)
        
        
    }
    
    @MainActor @Test func test_one_flexer_grows_over_righted() {
        
        let flexer = Flexer(id: 10, flexerIdentifier: .unknown, 2)
        flexer.name = "A"
        
        
        let node = WiseLayoutNode(id: 0, flexers: [flexer])
        let section = SkeletonSection(id: 0, nodes: [node])
        let section_center = SkeletonSection(id: 1, nodes: [])
        let row = GenerateRows.generate(sections: [section_center, section], centeredSection: section_center)
        row.snap_minimum_after_children_ready(menuWidthWithSafeArea: 1, safeAreaLeft: 0, safeAreaRight: 0)
        
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [],
                                pieceRules: [])
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        //SmartLayoutExpanderPass.prepare_intelligent(groupData: groupData, layoutPriority: .required)
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .required)
        
        #expect(row.growthBudget == 0)
        #expect(flexer.currentSize == 1)
        #expect(node.currentSize == 1)
        #expect(section.currentSize == 1)
        
        
    }
    
}
