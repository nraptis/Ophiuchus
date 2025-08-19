//
//  DoubleVerifyNodeGrowthTool.swift
//  OphiuchusTests
//
//  Created by Nick on 8/17/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct DoubleVerifyNodeGrowthTool {
    
    @MainActor static func testFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(nodes: [WiseLayoutNode],
                                                                                        sections: [SkeletonSection],
                                                                                        rows: [SkeletonRow],
                                                                                        book: SkeletonBook,
                                                                                        times: Int) -> Bool {
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        SmartLayoutExpanderMain.prepare(groupData: groupData)
        SmartLayoutExpanderPass.prepare_naive(groupData: groupData, layoutPriority: .required)
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
            for bag in bags {
                let nodeGroup = bag.nodeGroup
                var highest = Int.max
                var lowest = Int.max
                
                var smallestMaxBubble = Int.max
                var smallestCurrentSize = Int.max
                
                
                for sectionItem in bag.sectionItems {
                    let section = sectionItem.section
                    
                    for node in sectionItem.nodes {
                        if node.currentSize < smallestCurrentSize {
                            smallestCurrentSize = node.currentSize
                            lowest = min(lowest, smallestCurrentSize)
                        }
                    }
                    
                    for node in sectionItem.nodes {
                        
                        let gap = (node.currentSize - node.childrenSize)
                        node.gap = gap
                        if gap < 0 { fatalError("TODO: Should not be possible.") }
                        
                        var bubbleMax = node.requestedGrowthFromChildrenMax - gap
                        if bubbleMax < 0 { bubbleMax = 0 }
                        bubbleMax += node.currentSize
                        if bubbleMax < smallestMaxBubble {
                            smallestMaxBubble = bubbleMax
                        }
                        
                        highest = min(highest, smallestMaxBubble)
                    }
                }
                
                if highest == Int.max {
                    fatalError("We need a node, this makes no sense..")
                }
                if lowest == Int.max {
                    fatalError("We need a node, this makes no sense..")
                }
                
                var chosen: Int?
                var target = lowest
                while target <= highest {
                    
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
                    
                    if isEveryRowCapable {
                        chosen = target
                    }
                    target += 1
                }
                
                if let chosen = chosen {
                    
                    // All the nodes will grow to exactly "chosen"
                    for sectionItem in bag.sectionItems {
                        let section = sectionItem.section
                        guard let wrappedSection = section_map[section.id] else { fatalError("no wrapped section") }
                        
                        for node in sectionItem.nodes {
                            
                            guard let wrappedNode = node_map[node.id] else { fatalError("no wrapped node") }
                            
                            let gap = node.currentSize - node.childrenSize
                            if gap < 0 { fatalError("misconfiguration, gap \(gap)") }
                            
                            let target = (chosen - gap)
                            var amount = (target - wrappedNode.expectedSize)
                            if amount < 0 { amount = 0 }
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
                .attemptToFloodUniqueNodeGroupsByRequestedGrowthMinMaxFromChildren(uniqueNodeList: nodes,
                                                                                   uniqueNodeListCount: nodes.count)
            
            if (actualPulseResult != expectedResult) {
                print("Expected pulse result: (\(expectedResult)), but got (\(actualPulseResult))...")
                #expect(Bool(false))
                return false
            }
            
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
}
