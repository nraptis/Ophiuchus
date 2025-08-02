//
//  LinkPriorityGroupTests.swift
//  OphiuchusTests
//
//  Created by Nick on 7/11/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct LinkPriorityGroupPieceTests {
    
    func to_rule(item: [SkeletonPiece], layoutPriority: LayoutPriority) -> SkeletonLinkageRule_Pieces {
        let result = SkeletonLinkageRule_Pieces(pieces: item, layoutPriority: layoutPriority)
        return result
    }
    
    @Test func test_all_partitions_8_one_to_medium() {
        let item_1 = GeneratePieces.generate_piece(id: 1)
        let item_2 = GeneratePieces.generate_piece(id: 2)
        let item_3 = GeneratePieces.generate_piece(id: 3)
        let item_4 = GeneratePieces.generate_piece(id: 4)
        let item_5 = GeneratePieces.generate_piece(id: 5)
        let item_6 = GeneratePieces.generate_piece(id: 6)
        let item_7 = GeneratePieces.generate_piece(id: 7)
        let item_8 = GeneratePieces.generate_piece(id: 8)
        
        let items = [item_1, item_2, item_3, item_4, item_5, item_6, item_7, item_8]
        
        let chunk1 = GenerateChunks.generate_fixed(piece: item_1)
        let chunk2 = GenerateChunks.generate_fixed(piece: item_2)
        let chunk3 = GenerateChunks.generate_fixed(piece: item_3)
        let chunk4 = GenerateChunks.generate_fixed(piece: item_4)
        let chunk5 = GenerateChunks.generate_fixed(piece: item_5)
        let chunk6 = GenerateChunks.generate_fixed(piece: item_6)
        let chunk7 = GenerateChunks.generate_fixed(piece: item_7)
        let chunk8 = GenerateChunks.generate_fixed(piece: item_8)
        
        
        let chunks = [chunk1, chunk2, chunk3, chunk4, chunk5, chunk6, chunk7, chunk8]
        let node = GenerateNodes.generate_node(chunks: chunks)
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let page = SkeletonPage(row: row)
        let pages = [page]
        
        let partitions = getAllPartitions(items)
        
        var number_checked_valid = 0
        var number_checked_invalid = 0
        
        for partition in partitions {
            var rules = [SkeletonLinkageRule_Pieces]()
            for array in partition {
                var contains_item_1 = false
                for item in array {
                    if item === item_1 {
                        contains_item_1 = true
                    }
                }
                if contains_item_1 {
                    let rule = to_rule(item: array, layoutPriority: .medium)
                    rules.append(rule)
                } else {
                    let rule = to_rule(item: array, layoutPriority: .finally)
                    rules.append(rule)
                }
            }
            
            let groups = SkeletonLayoutExecutor.getPieceGroups_Unsafe(pages: pages,
                                                                     rules: rules)
            for group in groups {
                if group.linkedList.count > 1 {
                    number_checked_valid += 1
                    if group.set.contains(item_1.id) {
                        if !(group.layoutPriority == LayoutPriority.medium) {
                            #expect(Bool(false))
                            return
                        }
                    } else {
                        if !(group.layoutPriority == LayoutPriority.finally) {
                            #expect(Bool(false))
                            return
                        }
                    }
                } else {
                    number_checked_invalid += 1
                }
            }
        }
        print("We checked \(number_checked_valid) valid and \(number_checked_invalid) invalid linkages")
    }
    
    @Test func test_all_partitions_8_one_2_priorities() {
        let item_1 = GeneratePieces.generate_piece(id: 1)
        let item_2 = GeneratePieces.generate_piece(id: 2)
        let item_3 = GeneratePieces.generate_piece(id: 3)
        let item_4 = GeneratePieces.generate_piece(id: 4)
        let item_5 = GeneratePieces.generate_piece(id: 5)
        let item_6 = GeneratePieces.generate_piece(id: 6)
        let item_7 = GeneratePieces.generate_piece(id: 7)
        let item_8 = GeneratePieces.generate_piece(id: 8)
        
        let items = [item_1, item_2, item_3, item_4, item_5, item_6, item_7, item_8]
        
        let chunk1 = GenerateChunks.generate_fixed(piece: item_1)
        let chunk2 = GenerateChunks.generate_fixed(piece: item_2)
        let chunk3 = GenerateChunks.generate_fixed(piece: item_3)
        let chunk4 = GenerateChunks.generate_fixed(piece: item_4)
        let chunk5 = GenerateChunks.generate_fixed(piece: item_5)
        let chunk6 = GenerateChunks.generate_fixed(piece: item_6)
        let chunk7 = GenerateChunks.generate_fixed(piece: item_7)
        let chunk8 = GenerateChunks.generate_fixed(piece: item_8)
        
        
        let chunks = [chunk1, chunk2, chunk3, chunk4, chunk5, chunk6, chunk7, chunk8]
        let node = GenerateNodes.generate_node(chunks: chunks)
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let page = SkeletonPage(row: row)
        let pages = [page]
        
        let partitions = getAllPartitions(items)
        
        var number_checked_valid = 0
        var number_checked_invalid = 0
        
        for _ in 0..<2048 {
            
            let first_item = items.randomElement()!
            let second_item = items.randomElement()!
            
            let first_layoutPriority = LayoutPriority.allCases.randomElement()!
            let second_layoutPriority = LayoutPriority.allCases.randomElement()!
            let higher_layoutPriority: LayoutPriority
            if first_layoutPriority.gte(layoutPriority: second_layoutPriority) {
                higher_layoutPriority = first_layoutPriority
            } else {
                higher_layoutPriority = second_layoutPriority
            }
            
            for partition in partitions {
                var rules = [SkeletonLinkageRule_Pieces]()
                for array in partition {
                    
                    var array = array
                    array.shuffle()
                    
                    var contains_item_1 = false
                    var contains_item_2 = false
                    
                    for item in array {
                        if item === first_item {
                            contains_item_1 = true
                        }
                        if item === second_item {
                            contains_item_2 = true
                        }
                    }
                    
                    if contains_item_1 {
                        let rule = to_rule(item: array, layoutPriority: first_layoutPriority)
                        rules.append(rule)
                    }
                    
                    if contains_item_2 {
                        let rule = to_rule(item: array, layoutPriority: second_layoutPriority)
                        rules.append(rule)
                    }
                }
                
                let groups = SkeletonLayoutExecutor.getPieceGroups_Unsafe(pages: pages,
                                                                          rules: rules)
                for group in groups {
                    if group.linkedList.count > 1 {
                        
                        number_checked_valid += 1
                        
                        let c1 = group.set.contains(first_item.id)
                        let c2 = group.set.contains(second_item.id)
                        
                        if (c1 && c2) {
                            if !(group.layoutPriority == higher_layoutPriority) {
                                #expect(Bool(false))
                                return
                            }
                        } else if c1 {
                            if !(group.layoutPriority == first_layoutPriority) {
                                #expect(Bool(false))
                                return
                            }
                        } else if c2 {
                            if !(group.layoutPriority == second_layoutPriority) {
                                #expect(Bool(false))
                                return
                            }
                        } else {
                            if !(group.layoutPriority == .finally) {
                                #expect(Bool(false))
                                return
                            }
                        }
                    } else {
                        number_checked_invalid += 1
                    }
                }
            }
        }
        print("We checked \(number_checked_valid) valid and \(number_checked_invalid) invalid linkages")
    }
    
    
    @Test func test_link_second_layoutPriority_missing_a() {
        let a = GeneratePieces.generate_piece(id: 1)
        let b = GeneratePieces.generate_piece(id: 2)
        let nodes = [a, b]
        
        
        let rule = to_rule(item: [a, b], layoutPriority: .required)
        
        // Link only appears with `b` as `.second`
        let links = rule.getLinks()
        
        let groups = Exploder.explode(nodes: nodes, links: links)
        
        #expect(groups.count == 1)
        let group = groups[0]
        
        let ids = group.linkedList.map { $0.id }.sorted()
        print("Group IDs: \(ids), Priority: \(group.layoutPriority)")
        
        if !(group.layoutPriority == .required) {
            #expect(Bool(false))
            return
        }
    }

    @Test func test_link_second_layoutPriority_missing_b() {
        let a = GeneratePieces.generate_piece(id: 1)
        let b = GeneratePieces.generate_piece(id: 2)
        let nodes = [b, a]
        
        
        let rule = to_rule(item: [a, b], layoutPriority: .required)
        
        // Link only appears with `b` as `.second`
        let links = rule.getLinks()
        
        let groups = Exploder.explode(nodes: nodes, links: links)
        
        #expect(groups.count == 1)
        let group = groups[0]
        
        let ids = group.linkedList.map { $0.id }.sorted()
        print("Group IDs: \(ids), Priority: \(group.layoutPriority)")
        
        if !(group.layoutPriority == .required) {
            #expect(Bool(false))
            return
        }
    }

    @Test func test_link_second_layoutPriority_missing_c() {
        let a = GeneratePieces.generate_piece(id: 1)
        let b = GeneratePieces.generate_piece(id: 2)
        let nodes = [a, b]
        let rule = to_rule(item: [b, a], layoutPriority: .required)
        
        // Link only appears with `b` as `.second`
        let links = rule.getLinks()
        
        let groups = Exploder.explode(nodes: nodes, links: links)
        
        #expect(groups.count == 1)
        let group = groups[0]
        
        let ids = group.linkedList.map { $0.id }.sorted()
        print("Group IDs: \(ids), Priority: \(group.layoutPriority)")
        
        if !(group.layoutPriority == .required) {
            #expect(Bool(false))
            return
        }
    }

    @Test func test_link_second_layoutPriority_missing_d() {
        let a = GeneratePieces.generate_piece(id: 1)
        let b = GeneratePieces.generate_piece(id: 2)
        let nodes = [b, a]
        let rule = to_rule(item: [b, a], layoutPriority: .required)
        
        // Link only appears with `b` as `.second`
        let links = rule.getLinks()
        
        let groups = Exploder.explode(nodes: nodes, links: links)
        
        #expect(groups.count == 1)
        let group = groups[0]
        
        let ids = group.linkedList.map { $0.id }.sorted()
        print("Group IDs: \(ids), Priority: \(group.layoutPriority)")
        
        if !(group.layoutPriority == .required) {
            #expect(Bool(false))
            return
        }
    }
    
}
