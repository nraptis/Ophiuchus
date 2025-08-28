//
//  EverythingFitsPriorityTests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/15/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct EverythingFitsPriorityTests_2_4_6_8_10 {
    
    @MainActor @Test func test_one_flexer_2_4_6_8_10() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 2, 4, 6, 8, 10)
        let node = GenerateNodes.generate(flexers: [flexer])
        let section = GenerateSections.generate(nodes: [node])
        let row = GenerateRows.generate(sections: [section])
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [],
                                pieceRules: [])
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        
        SmartLayoutExpanderMain.prepare(groupData: groupData,
                                        menuWidthWithSafeArea: 1000,
        safeAreaLeft: 100,
        safeAreaRight: 100)
        
        #expect(flexer.currentSize == 0)
        #expect(flexer.targetSizeCurrentPriority == 0)
        #expect(node.childrenSize == 0)
        #expect(node.currentSize == 0)
        #expect(section.currentSize == 0)
        #expect(row.growthBudget == 1000)
        
        
        SmartLayoutExpanderPass.prepare_intelligent(groupData: groupData, layoutPriority: .required)
        let pulseResultA = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultA == true)
        #expect(flexer.currentSize == 1)
        #expect(flexer.targetSizeCurrentPriority == 2)
        #expect(node.childrenSize == 1)
        #expect(node.currentSize == 1)
        #expect(section.currentSize == 1)
        #expect(row.growthBudget == 999)
        
        let pulseResultB = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultB == true)
        #expect(flexer.currentSize == 2)
        #expect(flexer.targetSizeCurrentPriority == 2)
        #expect(node.childrenSize == 2)
        #expect(node.currentSize == 2)
        #expect(section.currentSize == 2)
        #expect(row.growthBudget == 998)
        
        let pulseResultC = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultC == false)
        #expect(flexer.currentSize == 2)
        #expect(flexer.targetSizeCurrentPriority == 2)
        #expect(node.childrenSize == 2)
        #expect(node.currentSize == 2)
        #expect(section.currentSize == 2)
        #expect(row.growthBudget == 998)
        
        
        SmartLayoutExpanderPass.prepare_intelligent(groupData: groupData, layoutPriority: .high)
        let pulseResultD = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultD == true)
        #expect(flexer.currentSize == 3)
        #expect(flexer.targetSizeCurrentPriority == 4)
        #expect(node.childrenSize == 3)
        #expect(node.currentSize == 3)
        #expect(section.currentSize == 3)
        #expect(row.growthBudget == 997)
        
        let pulseResultE = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultE == true)
        #expect(flexer.currentSize == 4)
        #expect(flexer.targetSizeCurrentPriority == 4)
        #expect(node.childrenSize == 4)
        #expect(node.currentSize == 4)
        #expect(section.currentSize == 4)
        #expect(row.growthBudget == 996)
        
        let pulseResultF = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultF == false)
        #expect(flexer.currentSize == 4)
        #expect(flexer.targetSizeCurrentPriority == 4)
        #expect(node.childrenSize == 4)
        #expect(node.currentSize == 4)
        #expect(section.currentSize == 4)
        #expect(row.growthBudget == 996)
        
        
        SmartLayoutExpanderPass.prepare_intelligent(groupData: groupData, layoutPriority: .medium)
        let pulseResultG = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultG == true)
        #expect(flexer.currentSize == 5)
        #expect(flexer.targetSizeCurrentPriority == 6)
        #expect(node.childrenSize == 5)
        #expect(node.currentSize == 5)
        #expect(section.currentSize == 5)
        #expect(row.growthBudget == 995)
        
        let pulseResultH = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultH == true)
        #expect(flexer.currentSize == 6)
        #expect(flexer.targetSizeCurrentPriority == 6)
        #expect(node.childrenSize == 6)
        #expect(node.currentSize == 6)
        #expect(section.currentSize == 6)
        #expect(row.growthBudget == 994)
        
        let pulseResultI = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultI == false)
        #expect(flexer.currentSize == 6)
        #expect(flexer.targetSizeCurrentPriority == 6)
        #expect(node.childrenSize == 6)
        #expect(node.currentSize == 6)
        #expect(section.currentSize == 6)
        #expect(row.growthBudget == 994)
        
        
        SmartLayoutExpanderPass.prepare_intelligent(groupData: groupData, layoutPriority: .low)
        let pulseResultJ = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultJ == true)
        #expect(flexer.currentSize == 7)
        #expect(flexer.targetSizeCurrentPriority == 8)
        #expect(node.childrenSize == 7)
        #expect(node.currentSize == 7)
        #expect(section.currentSize == 7)
        #expect(row.growthBudget == 993)
        
        let pulseResultK = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultK == true)
        #expect(flexer.currentSize == 8)
        #expect(flexer.targetSizeCurrentPriority == 8)
        #expect(node.childrenSize == 8)
        #expect(node.currentSize == 8)
        #expect(section.currentSize == 8)
        #expect(row.growthBudget == 992)
        
        let pulseResultL = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultL == false)
        #expect(flexer.currentSize == 8)
        #expect(flexer.targetSizeCurrentPriority == 8)
        #expect(node.childrenSize == 8)
        #expect(node.currentSize == 8)
        #expect(section.currentSize == 8)
        #expect(row.growthBudget == 992)
        
        
        SmartLayoutExpanderPass.prepare_intelligent(groupData: groupData, layoutPriority: .finally)
        let pulseResultM = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultM == true)
        #expect(flexer.currentSize == 9)
        #expect(flexer.targetSizeCurrentPriority == 10)
        #expect(node.childrenSize == 9)
        #expect(node.currentSize == 9)
        #expect(section.currentSize == 9)
        #expect(row.growthBudget == 991)
        
        let pulseResultN = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultN == true)
        #expect(flexer.currentSize == 10)
        #expect(flexer.targetSizeCurrentPriority == 10)
        #expect(node.childrenSize == 10)
        #expect(node.currentSize == 10)
        #expect(section.currentSize == 10)
        #expect(row.growthBudget == 990)
        
        let pulseResultO = SmartLayoutExpanderPulse.pulse()
        #expect(pulseResultO == false)
        #expect(flexer.currentSize == 10)
        #expect(flexer.targetSizeCurrentPriority == 10)
        #expect(node.childrenSize == 10)
        #expect(node.currentSize == 10)
        #expect(section.currentSize == 10)
        #expect(row.growthBudget == 990)
    }
    
    @MainActor @Test func test_one_flexer_2_4_6_8_10_rule_kicks_in_at_2() {
        let flexer_a = Flexer(id: 0, flexerIdentifier: .unknown, 2, 4, 6, 8, 10)
        let flexer_b = Flexer(id: 1, flexerIdentifier: .unknown, 2)
        
        let flexer_rule = SkeletonLinkageRule_Flexers(flexers: [flexer_a, flexer_b], layoutPriority: .required)
        
        let node = GenerateNodes.generate(flexers: [flexer_a, flexer_b])
        let section = GenerateSections.generate(nodes: [node])
        let row = GenerateRows.generate(sections: [section])
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [flexer_rule],
                                pieceRules: [])
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        #expect(flexer_a.currentSize == 0)
        #expect(flexer_a.targetSizeCurrentPriority == 0)
        #expect(flexer_b.currentSize == 0)
        #expect(flexer_b.targetSizeCurrentPriority == 0)
        #expect(node.childrenSize == 0)
        #expect(node.currentSize == 0)
        #expect(section.currentSize == 0)
        #expect(row.growthBudget == 1000)
        
        var targetSizeCurrentPriority_a = 2
        let priorities = [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally]
        for priority in priorities {
            SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: priority)
            #expect(flexer_a.currentSize == 2)
            #expect(flexer_a.targetSizeCurrentPriority == targetSizeCurrentPriority_a)
            #expect(flexer_b.currentSize == 2)
            #expect(flexer_b.targetSizeCurrentPriority == 2)
            #expect(node.childrenSize == 4)
            #expect(node.currentSize == 4)
            #expect(section.currentSize == 4)
            #expect(row.growthBudget == 996)
            targetSizeCurrentPriority_a += 2
        }
    }
    
    @MainActor @Test func test_one_flexer_2_4_6_8_10_rule_kicks_in_at_4() {
        let flexer_a = Flexer(id: 0, flexerIdentifier: .unknown, 2, 4, 6, 8, 10)
        let flexer_b = Flexer(id: 1, flexerIdentifier: .unknown, 2, 4)
        
        let flexer_rule = SkeletonLinkageRule_Flexers(flexers: [flexer_a, flexer_b], layoutPriority: .high)
        
        let node = GenerateNodes.generate(flexers: [flexer_a, flexer_b])
        let section = GenerateSections.generate(nodes: [node])
        let row = GenerateRows.generate(sections: [section])
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [flexer_rule],
                                pieceRules: [])
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        #expect(flexer_a.currentSize == 0)
        #expect(flexer_a.targetSizeCurrentPriority == 0)
        #expect(flexer_b.currentSize == 0)
        #expect(flexer_b.targetSizeCurrentPriority == 0)
        #expect(node.childrenSize == 0)
        #expect(node.currentSize == 0)
        #expect(section.currentSize == 0)
        #expect(row.growthBudget == 1000)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: LayoutPriority.required)
        #expect(flexer_a.currentSize == 2)
        #expect(flexer_a.targetSizeCurrentPriority == 2)
        #expect(flexer_b.currentSize == 2)
        #expect(flexer_b.targetSizeCurrentPriority == 2)
        #expect(node.childrenSize == 4)
        #expect(node.currentSize == 4)
        #expect(section.currentSize == 4)
        #expect(row.growthBudget == 996)
        
        var targetSizeCurrentPriority_a = 4
        let priorities = [LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally]
        for priority in priorities {
            SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: priority)
            #expect(flexer_a.currentSize == 4)
            #expect(flexer_a.targetSizeCurrentPriority == targetSizeCurrentPriority_a)
            #expect(flexer_b.currentSize == 4)
            #expect(flexer_b.targetSizeCurrentPriority == 4)
            #expect(node.childrenSize == 8)
            #expect(node.currentSize == 8)
            #expect(section.currentSize == 8)
            #expect(row.growthBudget == 992)
            targetSizeCurrentPriority_a += 2
        }
    }
    
    @MainActor @Test func test_one_flexer_2_4_6_8_10_rule_kicks_in_at_6() {
        let flexer_a = Flexer(id: 0, flexerIdentifier: .unknown, 2, 4, 6, 8, 10)
        let flexer_b = Flexer(id: 1, flexerIdentifier: .unknown, 2, 4, 6)
        
        let flexer_rule = SkeletonLinkageRule_Flexers(flexers: [flexer_a, flexer_b], layoutPriority: .medium)
        
        let node = GenerateNodes.generate(flexers: [flexer_a, flexer_b])
        let section = GenerateSections.generate(nodes: [node])
        let row = GenerateRows.generate(sections: [section])
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [flexer_rule],
                                pieceRules: [])
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        #expect(flexer_a.currentSize == 0)
        #expect(flexer_a.targetSizeCurrentPriority == 0)
        #expect(flexer_b.currentSize == 0)
        #expect(flexer_b.targetSizeCurrentPriority == 0)
        #expect(node.childrenSize == 0)
        #expect(node.currentSize == 0)
        #expect(section.currentSize == 0)
        #expect(row.growthBudget == 1000)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: LayoutPriority.required)
        #expect(flexer_a.currentSize == 2)
        #expect(flexer_a.targetSizeCurrentPriority == 2)
        #expect(flexer_b.currentSize == 2)
        #expect(flexer_b.targetSizeCurrentPriority == 2)
        #expect(node.childrenSize == 4)
        #expect(node.currentSize == 4)
        #expect(section.currentSize == 4)
        #expect(row.growthBudget == 996)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: LayoutPriority.high)
        #expect(flexer_a.currentSize == 4)
        #expect(flexer_a.targetSizeCurrentPriority == 4)
        #expect(flexer_b.currentSize == 4)
        #expect(flexer_b.targetSizeCurrentPriority == 4)
        #expect(node.childrenSize == 8)
        #expect(node.currentSize == 8)
        #expect(section.currentSize == 8)
        #expect(row.growthBudget == 992)
        
        var targetSizeCurrentPriority_a = 6
        let priorities = [LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally]
        for priority in priorities {
            SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: priority)
            #expect(flexer_a.currentSize == 6)
            #expect(flexer_a.targetSizeCurrentPriority == targetSizeCurrentPriority_a)
            #expect(flexer_b.currentSize == 6)
            #expect(flexer_b.targetSizeCurrentPriority == 6)
            #expect(node.childrenSize == 12)
            #expect(node.currentSize == 12)
            #expect(section.currentSize == 12)
            #expect(row.growthBudget == 988)
            targetSizeCurrentPriority_a += 2
        }
    }
    
    @MainActor @Test func test_one_flexer_2_4_6_8_10_rule_kicks_in_at_8() {
        let flexer_a = Flexer(id: 0, flexerIdentifier: .unknown, 2, 4, 6, 8, 10)
        let flexer_b = Flexer(id: 1, flexerIdentifier: .unknown, 2, 4, 6, 8)
        
        let flexer_rule = SkeletonLinkageRule_Flexers(flexers: [flexer_a, flexer_b], layoutPriority: .medium)
        
        let node = GenerateNodes.generate(flexers: [flexer_a, flexer_b])
        let section = GenerateSections.generate(nodes: [node])
        let row = GenerateRows.generate(sections: [section])
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [flexer_rule],
                                pieceRules: [])
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        #expect(flexer_a.currentSize == 0)
        #expect(flexer_a.targetSizeCurrentPriority == 0)
        #expect(flexer_b.currentSize == 0)
        #expect(flexer_b.targetSizeCurrentPriority == 0)
        #expect(node.childrenSize == 0)
        #expect(node.currentSize == 0)
        #expect(section.currentSize == 0)
        #expect(row.growthBudget == 1000)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: LayoutPriority.required)
        #expect(flexer_a.currentSize == 2)
        #expect(flexer_a.targetSizeCurrentPriority == 2)
        #expect(flexer_b.currentSize == 2)
        #expect(flexer_b.targetSizeCurrentPriority == 2)
        #expect(node.childrenSize == 4)
        #expect(node.currentSize == 4)
        #expect(section.currentSize == 4)
        #expect(row.growthBudget == 996)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: LayoutPriority.high)
        #expect(flexer_a.currentSize == 4)
        #expect(flexer_a.targetSizeCurrentPriority == 4)
        #expect(flexer_b.currentSize == 4)
        #expect(flexer_b.targetSizeCurrentPriority == 4)
        #expect(node.childrenSize == 8)
        #expect(node.currentSize == 8)
        #expect(section.currentSize == 8)
        #expect(row.growthBudget == 992)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: LayoutPriority.medium)
        #expect(flexer_a.currentSize == 6)
        #expect(flexer_a.targetSizeCurrentPriority == 6)
        #expect(flexer_b.currentSize == 6)
        #expect(flexer_b.targetSizeCurrentPriority == 6)
        #expect(node.childrenSize == 12)
        #expect(node.currentSize == 12)
        #expect(section.currentSize == 12)
        #expect(row.growthBudget == 988)
        
        var targetSizeCurrentPriority_a = 8
        let priorities = [LayoutPriority.low, LayoutPriority.finally]
        for priority in priorities {
            SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: priority)
            #expect(flexer_a.currentSize == 8)
            #expect(flexer_a.targetSizeCurrentPriority == targetSizeCurrentPriority_a)
            #expect(flexer_b.currentSize == 8)
            #expect(flexer_b.targetSizeCurrentPriority == 8)
            #expect(node.childrenSize == 16)
            #expect(node.currentSize == 16)
            #expect(section.currentSize == 16)
            #expect(row.growthBudget == 984)
            targetSizeCurrentPriority_a += 2
        }
    }
    
    @MainActor @Test func test_one_flexer_2_4_6_8_10_rule_kicks_in_at_10() {
        let flexer_a = Flexer(id: 0, flexerIdentifier: .unknown, 2, 4, 6, 8, 10)
        let flexer_b = Flexer(id: 1, flexerIdentifier: .unknown, 2, 4, 6, 8, 10)
        
        let flexer_rule = SkeletonLinkageRule_Flexers(flexers: [flexer_a, flexer_b], layoutPriority: .low)
        
        let node = GenerateNodes.generate(flexers: [flexer_a, flexer_b])
        let section = GenerateSections.generate(nodes: [node])
        let row = GenerateRows.generate(sections: [section])
        let rows = [row]
        
        let book = SkeletonBook(rows: rows,
                                nodeRules: [],
                                flexerRules: [flexer_rule],
                                pieceRules: [])
        
        row.growthBudget = 1000
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        #expect(flexer_a.currentSize == 0)
        #expect(flexer_a.targetSizeCurrentPriority == 0)
        #expect(flexer_b.currentSize == 0)
        #expect(flexer_b.targetSizeCurrentPriority == 0)
        #expect(node.childrenSize == 0)
        #expect(node.currentSize == 0)
        #expect(section.currentSize == 0)
        #expect(row.growthBudget == 1000)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: LayoutPriority.required)
        #expect(flexer_a.currentSize == 2)
        #expect(flexer_a.targetSizeCurrentPriority == 2)
        #expect(flexer_b.currentSize == 2)
        #expect(flexer_b.targetSizeCurrentPriority == 2)
        #expect(node.childrenSize == 4)
        #expect(node.currentSize == 4)
        #expect(section.currentSize == 4)
        #expect(row.growthBudget == 996)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: LayoutPriority.high)
        #expect(flexer_a.currentSize == 4)
        #expect(flexer_a.targetSizeCurrentPriority == 4)
        #expect(flexer_b.currentSize == 4)
        #expect(flexer_b.targetSizeCurrentPriority == 4)
        #expect(node.childrenSize == 8)
        #expect(node.currentSize == 8)
        #expect(section.currentSize == 8)
        #expect(row.growthBudget == 992)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: LayoutPriority.medium)
        #expect(flexer_a.currentSize == 6)
        #expect(flexer_a.targetSizeCurrentPriority == 6)
        #expect(flexer_b.currentSize == 6)
        #expect(flexer_b.targetSizeCurrentPriority == 6)
        #expect(node.childrenSize == 12)
        #expect(node.currentSize == 12)
        #expect(section.currentSize == 12)
        #expect(row.growthBudget == 988)
        
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: LayoutPriority.low)
        #expect(flexer_a.currentSize == 8)
        #expect(flexer_a.targetSizeCurrentPriority == 8)
        #expect(flexer_b.currentSize == 8)
        #expect(flexer_b.targetSizeCurrentPriority == 8)
        #expect(node.childrenSize == 16)
        #expect(node.currentSize == 16)
        #expect(section.currentSize == 16)
        #expect(row.growthBudget == 984)
        
        var targetSizeCurrentPriority_a = 10
        let priorities = [LayoutPriority.finally]
        for priority in priorities {
            SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: priority)
            #expect(flexer_a.currentSize == 10)
            #expect(flexer_a.targetSizeCurrentPriority == targetSizeCurrentPriority_a)
            #expect(flexer_b.currentSize == 10)
            #expect(flexer_b.targetSizeCurrentPriority == 10)
            #expect(node.childrenSize == 20)
            #expect(node.currentSize == 20)
            #expect(section.currentSize == 20)
            #expect(row.growthBudget == 980)
            targetSizeCurrentPriority_a += 2
        }
    }
    
    
}
