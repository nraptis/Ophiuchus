//
//  PulseStepBTests_A.swift
//  OphiuchusTests
//
//  Created by Nick on 8/12/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct PulseStepBTests_A {
    
    @MainActor func testAttemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(nodes: [WiseLayoutNode],
                                                                                    sections: [SkeletonSection],
                                                                                    rows: [SkeletonRow],
                                                                                    book: SkeletonBook,
                                                                                    times: Int) -> Bool {
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        _ = SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        let nodeGroups = GenerateAdvanced.generateUniqueNodeGroups(nodeGroups: groupData.nodeGroups)
        
        if nodeGroups.count != groupData.nodeGroups.count {
            fatalError("Hmm, something went wrong...")
        }
        
        var expectedResult = false
        
        let bags = GenerateAdvanced.generateBags(nodeGroups: groupData.nodeGroups)
        
        
        var row_map = [Int: WrappedRow]()
        var section_map = [Int: WrappedSection]()
        var node_map = [Int: WrappedNode]()
        
        for row in rows {
            let wrappedRow = WrappedRow(row: row)
            wrappedRow.inject(row_map: &row_map,
                              section_map: &section_map,
                              node_map: &node_map)
        }
        
        for row in rows {
            guard row_map[row.id] !== nil else { fatalError("didn't linked row...") }
            for section in row.sections {
                guard section_map[section.id] !== nil else { fatalError("didn't linked section...") }
                for node in section.nodes {
                    guard node_map[node.id] !== nil else { fatalError("didn't linked node...") }
                    
                }
            }
        }
        
        var loop = 0
        
        while loop < times {
            
            print("LOOP \(loop + 1) / \(times)")
            
            for bag in bags {
                let nodeGroup = bag.nodeGroup
                var highest = Int.max
                var lowest = Int.max
                for sectionItem in bag.sectionItems {
                    let section = sectionItem.section
                    
                    
                    for node in sectionItem.nodes {
                        let gap = node.currentSize - node.childrenSize
                        if gap < 0 { fatalError("misconfiguration, gap \(gap)") }
                        
                        var bubble = node.requestedGrowthFromChildren - gap
                        if bubble < 0 {
                            bubble = 0
                        }
                        
                        bubble += node.currentSize
                        highest = min(highest, bubble)
                        lowest = min(lowest, node.currentSize)
                    }
                    
                }
                
                if highest == Int.max {
                    fatalError("We need a node, this makes no sense..")
                }
                if lowest == Int.max {
                    fatalError("We need a node, this makes no sense..")
                }
                
                print("### IOIO The shelf of this bag is \(highest) and \(lowest), for node group")
                
                var chosen: Int?
                var target = lowest
                while target <= highest {
                    
                    // We want all the nodes to be "grow"
                    /*
                     for node in nodeGroup.linkedList {
                     let section = node.section!
                     guard let wrappedSection = section_map[section.id] else { fatalError("no wrapped section") }
                     wrappedSection.temp = 0
                     }
                     
                     var sectionMap = [Int: SkeletonSection]()
                     for node in nodeGroup.linkedList {
                     let section = node.section!
                     
                     guard let wrappedNod = section_map[section.id] else { fatalError("no wrapped section") }
                     guard let wrappedSection = section_map[section.id] else { fatalError("no wrapped section") }
                     
                     
                     let gap = node.currentSize - node.childrenSize
                     if gap < 0 { fatalError("misconfiguration, gap \(gap)") }
                     let target = (target - gap)
                     
                     var amount = (target - node.currentSize)
                     if amount < 0 { amount = 0 }
                     
                     wrappedSection.temp += amount
                     print("Added Temp, Which is \(wrappedSection.temp)")
                     
                     sectionMap[section.id] = section
                     
                     }
                     
                     var totalGrowth = 0
                     for section in sectionMap.values {
                     guard let wrappedSection = section_map[section.id] else { fatalError("no wrapped section") }
                     totalGrowth += wrappedSection.temp
                     }
                     
                     
                     var per_row = [Int: Int]()
                     for section in sectionMap.values {
                     guard let wrappedSection = section_map[section.id] else { fatalError("no wrapped section") }
                     let row = section.row!
                     per_row[row.id, default: 0] += wrappedSection.temp
                     }
                     */
                    
                    for sectionItem in bag.sectionItems {
                        let section = sectionItem.section
                        guard let wrappedSection = section_map[section.id] else { fatalError("no wrapped section") }
                        wrappedSection.temp = 0
                        
                        for node in sectionItem.nodes {
                            
                            guard let wrappedNode = node_map[node.id] else { fatalError("no wrapped node") }
                            
                            let gap = wrappedNode.expectedSize - node.childrenSize
                            if gap < 0 { fatalError("misconfiguration, gap \(gap)") }
                            let target = (target - gap)
                            var amount = (target - wrappedNode.expectedSize)
                            if amount < 0 { amount = 0 }
                            
                            wrappedSection.temp += amount
                            print("Added Temp, Which is \(wrappedSection.temp)")
                        }
                    }
                    
                    var totalGrowth = 0
                    for sectionItem in bag.sectionItems {
                        let section = sectionItem.section
                        guard let wrappedSection = section_map[section.id] else { fatalError("no wrapped section") }
                        totalGrowth += wrappedSection.temp
                    }
                    
                    
                    var per_row = [Int: Int]()
                    for sectionItem in bag.sectionItems {
                        let section = sectionItem.section
                        guard let wrappedSection = section_map[section.id] else { fatalError("no wrapped section") }
                        let row = section.row!
                        per_row[row.id, default: 0] += wrappedSection.temp
                    }
                    
                    
                    var isEveryRowCapable = true
                    for row in rows {
                        
                        let requiredGrowth = per_row[row.id] ?? 0
                        if row.growthBudget < requiredGrowth {
                            isEveryRowCapable = false
                        }
                        
                        
                    }
                    
                    print("At \(target), isEveryRowCapable: \(isEveryRowCapable)")
                    
                    if isEveryRowCapable {
                        chosen = target
                    }
                    target += 1
                }
                
                print("The real growing step: \(chosen ?? -9999)")
                
                if let chosen = chosen {
                    
                    // All the nodes will grow to exactly "chosen"
                    for sectionItem in bag.sectionItems {
                        let section = sectionItem.section
                        guard let wrappedSection = section_map[section.id] else { fatalError("no wrapped section") }
                        
                        print("&&HERE&& Wrapped Section: \(ObjectIdentifier(wrappedSection))")
                        
                        for node in sectionItem.nodes {
                            
                            guard let wrappedNode = node_map[node.id] else { fatalError("no wrapped node") }
                            
                            let gap = node.currentSize - node.childrenSize
                            if gap < 0 { fatalError("misconfiguration, gap \(gap)") }
                            
                            let target = (chosen - gap)
                            var amount = (target - wrappedNode.expectedSize)
                            if amount < 0 { amount = 0 }
                            
                            print("Wr added \(amount) to id: \(node.id)")
                            wrappedNode.expectedSize += amount
                            wrappedSection.expectedSize += amount
                            let wrappedRow = wrappedSection.row!
                            wrappedRow.expectedGrowthBudget -= amount
                            
                            if amount > 0 {
                                expectedResult = true
                            }
                        }
                    }
                }
            }
            
            let actualPulseResult = SmartLayoutFlooder
                .attemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(uniqueNodeList: nodes,
                                                                             uniqueNodeListCount: nodes.count)
            
            if (actualPulseResult != expectedResult) {
                print("Expected pulse result: (\(expectedResult)), but got (\(actualPulseResult))...")
                #expect(Bool(false))
                return false
            }
            
            print("The actual pulse result: \(actualPulseResult)")
            
            
            for node in nodes {
                guard let wrappedNode = node_map[node.id] else {
                    print("Expect every node is wrapped...")
                    #expect(Bool(false))
                    return false
                }
                
                if (wrappedNode.expectedSize != node.currentSize) {
                    print("For node [\(node.id)] we expected a current size of \(wrappedNode.expectedSize), got size \(node.currentSize).")
                    #expect(Bool(false))
                    return false
                }
                
                let section = node.section!
                let wrappedSection = wrappedNode.section!
                
                if (wrappedSection.expectedSize != section.currentSize) {
                    print("For section [\(node.id)] we expected a current size of \(wrappedSection.expectedSize), got size \(section.currentSize).")
                    #expect(Bool(false))
                    return false
                }
                
                let row = node.row!
                let wrappedRow = wrappedSection.row!
                if (wrappedRow.expectedGrowthBudget != row.growthBudget) {
                    print("For row [\(row.id)] we expected a growth budget of \(wrappedRow.expectedGrowthBudget), got budget \(row.growthBudget).")
                    #expect(Bool(false))
                    return false
                }
                
            }
            
            loop += 1
            
        }
        
        return true
    }
    
    
    
    
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
        let preparePassResult = SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        #expect(preparePassResult == true)
        
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
        if !testAttemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(nodes: nodes,
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
        
        let preparePassResult = SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        #expect(preparePassResult == true)
        
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
        
        if !testAttemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(nodes: nodes,
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
        let preparePassResult = SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        #expect(preparePassResult == true)
        
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
        
        if !testAttemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(nodes: nodes,
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
        let preparePassResult = SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        #expect(preparePassResult == true)
        
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
        
        if !testAttemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(nodes: nodes,
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
        let preparePassResult = SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        #expect(preparePassResult == true)
        
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
        
        if !testAttemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(nodes: nodes,
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
        
        let preparePassResult = SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        #expect(preparePassResult == true)
        
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
        
        if !testAttemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(nodes: nodes,
                                                                            sections: sections,
                                                                            rows: rows,
                                                                            book: book,
                                                                            times: 1) {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func grow_3_nodes_test_case_7_7_7_equal_target() {
        
        let nr_a = GenerateNodes.generate(currentSize: 4, withPiecesToGrow: 3, byAmount: 1)
        let nr_b = GenerateNodes.generate(currentSize: 2, withPiecesToGrow: 5, byAmount: 1)
        let nr_c = GenerateNodes.generate(currentSize: 6, withPiecesToGrow: 1, byAmount: 1)
        
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
        let preparePassResult = SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(preparePassResult == true)
        
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
        
        if !testAttemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(nodes: nodes,
                                                                            sections: sections,
                                                                            rows: rows,
                                                                            book: book,
                                                                            times: 1) {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func grow_5_nodes_mixed_ownership_a() {
        
        let nr_a = GenerateNodes.generate(currentSize: 10, withPiecesToGrow: 10, byAmount: 1)
        let node_a = nr_a.0
        node_a.childrenSize = 10
        
        let nr_b = GenerateNodes.generate(currentSize: 10, withPiecesToGrow: 10, byAmount: 1)
        let node_b = nr_b.0
        node_b.childrenSize = 10
        
        let nr_c = GenerateNodes.generate(currentSize: 10, withPiecesToGrow: 10, byAmount: 1)
        let node_c = nr_c.0
        node_c.childrenSize = 5
        
        let nr_d = GenerateNodes.generate(currentSize: 5, withPiecesToGrow: 15, byAmount: 1)
        let node_d = nr_d.0
        node_d.childrenSize = 5
        
        let nr_e = GenerateNodes.generate(currentSize: 10, withPiecesToGrow: 10, byAmount: 1)
        let node_e = nr_e.0
        node_e.childrenSize = 5
        
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
        let preparePassResult = SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(preparePassResult == true)
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
        
        let nr_a = GenerateNodes.generate(currentSize: 10, withPiecesToGrow: 10, byAmount: 1)
        let node_a = nr_a.0
        node_a.childrenSize = 10
        
        let nr_b = GenerateNodes.generate(currentSize: 10, withPiecesToGrow: 10, byAmount: 1)
        let node_b = nr_b.0
        node_b.childrenSize = 10
        
        let nr_c = GenerateNodes.generate(currentSize: 10, withPiecesToGrow: 10, byAmount: 1)
        let node_c = nr_c.0
        node_c.childrenSize = 5
        
        let nr_d = GenerateNodes.generate(currentSize: 5, withPiecesToGrow: 15, byAmount: 1)
        let node_d = nr_d.0
        node_d.childrenSize = 5
        
        let nr_e = GenerateNodes.generate(currentSize: 10, withPiecesToGrow: 10, byAmount: 1)
        let node_e = nr_e.0
        node_e.childrenSize = 5
        
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
        
        if !testAttemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(nodes: nodes,
                                                                            sections: sections,
                                                                            rows: rows,
                                                                            book: book,
                                                                            times: 8) {
            #expect(Bool(false))
            return
        }
        
    }
    
    @MainActor @Test func grow_5_nodes_mixed_ownership_b() {
        
        let nr_a = GenerateNodes.generate(currentSize: 15, withPiecesToGrow: 5, byAmount: 1)
        let node_a = nr_a.0
        node_a.childrenSize = 10
        
        let nr_b = GenerateNodes.generate(currentSize: 5, withPiecesToGrow: 15, byAmount: 1)
        let node_b = nr_b.0
        node_b.childrenSize = 0
        
        let nr_c = GenerateNodes.generate(currentSize: 10, withPiecesToGrow: 15, byAmount: 1)
        let node_c = nr_c.0
        node_c.childrenSize = 0
        
        let nr_d = GenerateNodes.generate(currentSize: 15, withPiecesToGrow: 30, byAmount: 1)
        let node_d = nr_d.0
        node_d.childrenSize = 10
        
        let nr_e = GenerateNodes.generate(currentSize: 5, withPiecesToGrow: 20, byAmount: 1)
        let node_e = nr_e.0
        node_e.childrenSize = 0
        
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
        let preparePassResult = SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
        
        #expect(preparePassResult == true)
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
        #expect(stepResult1 == true)
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
        
        let nr_a = GenerateNodes.generate(currentSize: 15, withPiecesToGrow: 5, byAmount: 1)
        let node_a = nr_a.0
        node_a.childrenSize = 10
        
        let nr_b = GenerateNodes.generate(currentSize: 5, withPiecesToGrow: 15, byAmount: 1)
        let node_b = nr_b.0
        node_b.childrenSize = 0
        
        let nr_c = GenerateNodes.generate(currentSize: 10, withPiecesToGrow: 15, byAmount: 1)
        let node_c = nr_c.0
        node_c.childrenSize = 0
        
        let nr_d = GenerateNodes.generate(currentSize: 15, withPiecesToGrow: 30, byAmount: 1)
        let node_d = nr_d.0
        node_d.childrenSize = 10
        
        let nr_e = GenerateNodes.generate(currentSize: 5, withPiecesToGrow: 20, byAmount: 1)
        let node_e = nr_e.0
        node_e.childrenSize = 0
        
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
        
        if !testAttemptToFloodUniqueNodeGroupsByRequestedGrowthFromChildren(nodes: nodes,
                                                                            sections: sections,
                                                                            rows: rows,
                                                                            book: book,
                                                                            times: 10) {
            #expect(Bool(false))
            return
        }
    }
    
}
