//
//  BruteForceExpanderTests_OneRule.swift
//  OphiuchusTests
//
//  Created by Nick on 7/9/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct BruteForceExpanderTests_LargeRowSimpleRules {
    
    func get_random_pages() -> [SkeletonPage] {
        var pages = [SkeletonPage]()
        let page_count = Int.random(in: 1...4)
        for _ in 0..<page_count {
            let row_count = Int.random(in: 1...4)
            var rows = [SkeletonRow]()
            for _ in 0..<row_count {
                let section_count = Int.random(in: 1...4)
                var sections: [SkeletonSection] = []
                for _ in 0..<section_count {
                    var nodes = [WiseLayoutNode]()
                    let node_count = Int.random(in: 1...4)
                    for _ in 0..<node_count {
                        let chunk_count = Int.random(in: 1...4)
                        var chunks = [any SkeletonChunkConforming]()
                        for _ in 0..<chunk_count {
                            let chunk = GenerateChunks.generate_random_10_flexer()
                            chunks.append(chunk)
                        }
                        let node = GenerateNodes.generate_node(chunks: chunks)
                        nodes.append(node)
                    }
                    let section = GenerateSections.generate_section(nodes: nodes)
                    sections.append(section)
                }
                let row = SkeletonRow(sections: sections, attemptedCenteredSection: nil)
                rows.append(row)
            }
            let page = SkeletonPage(rows: rows)
            pages.append(page)
        }
        return pages
    }
    
    func get_random_pieces(pages: [SkeletonPage], n: Int) -> [SkeletonPiece] {
        
        let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
        let result = getRandomElements(input: all_pieces, count: n)
        return result
    }
    
    func get_linkage_rule(pieces: [SkeletonPiece]) -> SkeletonLinkageRule_Pieces {
        return SkeletonLinkageRule_Pieces(pieces: pieces, layoutPriority: .required)
    }
    
    func are_all_equal_to_largest(pieces: [SkeletonPiece]) -> Bool {
        if pieces.count < 2 { return true }
        var largest = pieces[0].currentSize
        for piece in pieces {
            if piece.currentSize > largest {
                largest = piece.currentSize
            }
        }
        var all_equal = true
        for piece in pieces {
            if piece.currentSize != largest {
                all_equal = false
            }
        }
        if !all_equal {
            print("Pieces were *NOT* all equal to \(largest)!")
            for piece in pieces {
                print("\(piece.id), size = \(piece.currentSize)")
            }
            return false
        }
        return true
    }
    
    func get_random_flexers(pages: [SkeletonPage], n: Int) -> [Flexer] {
        
        let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
        let result = getRandomElements(input: all_flexers, count: n)
        return result
    }
    
    func get_linkage_rule(flexers: [Flexer]) -> SkeletonLinkageRule_Flexers {
        return SkeletonLinkageRule_Flexers(flexers: flexers, layoutPriority: .required)
    }
    
    func are_all_equal_to_largest(flexers: [Flexer]) -> Bool {
        if flexers.count < 2 { return true }
        var largest = flexers[0].currentSize
        for flexer in flexers {
            if flexer.currentSize > largest {
                largest = flexer.currentSize
            }
        }
        var all_equal = true
        for flexer in flexers {
            if flexer.currentSize != largest {
                all_equal = false
            }
        }
        if !all_equal {
            print("Flexers were *NOT* all equal to \(largest)!")
            for flexer in flexers {
                print("\(flexer.id), size = \(flexer.currentSize)")
            }
            return false
        }
        return true
    }
    
    
    func get_random_chunks(pages: [SkeletonPage], n: Int) -> [any SkeletonChunkConforming] {
        
        let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
        let result = getRandomElements(input: all_chunks, count: n)
        return result
    }
    
    func get_linkage_rule(chunks: [any SkeletonChunkConforming]) -> SkeletonLinkageRule_Chunks {
        return SkeletonLinkageRule_Chunks(chunks: chunks, layoutPriority: .required)
    }
    
    func are_all_equal_to_largest(chunks: [any SkeletonChunkConforming]) -> Bool {
        if chunks.count < 2 { return true }
        var largest = chunks[0].currentSize
        for chunk in chunks {
            if chunk.currentSize > largest {
                largest = chunk.currentSize
            }
        }
        var all_equal = true
        for chunk in chunks {
            if chunk.currentSize != largest {
                all_equal = false
            }
        }
        if !all_equal {
            print("Chunks were *NOT* all equal to \(largest)!")
            for chunk in chunks {
                print("\(chunk.id), size = \(chunk.currentSize)")
            }
            return false
        }
        return true
    }
    
    
    
    func get_random_nodes(pages: [SkeletonPage], n: Int) -> [SkeletonNode] {
        
        let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
        let result = getRandomElements(input: all_nodes, count: n)
        return result
    }
    
    func get_linkage_rule(nodes: [SkeletonNode]) -> SkeletonLinkageRule_Nodes {
        return SkeletonLinkageRule_Nodes(nodes: nodes, layoutPriority: .required)
    }
    
    func are_all_equal_to_largest(nodes: [SkeletonNode]) -> Bool {
        if nodes.count < 2 { return true }
        var largest = nodes[0].currentSize
        for node in nodes {
            if node.currentSize > largest {
                largest = node.currentSize
            }
        }
        var all_equal = true
        for node in nodes {
            if node.currentSize != largest {
                all_equal = false
            }
        }
        if !all_equal {
            print("Nodes were *NOT* all equal to \(largest)!")
            for node in nodes {
                print("\(node.id), size = \(node.currentSize)")
            }
            return false
        }
        return true
    }
    
    
    func get_random_sections(pages: [SkeletonPage], n: Int) -> [SkeletonSection] {
        
        let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
        let result = getRandomElements(input: all_sections, count: n)
        return result
    }
    
    func get_linkage_rule(sections: [SkeletonSection]) -> SkeletonLinkageRule_Sections {
        return SkeletonLinkageRule_Sections(sections: sections, layoutPriority: .required)
    }
    
    func are_all_equal_to_largest(sections: [SkeletonSection]) -> Bool {
        if sections.count < 2 { return true }
        var largest = sections[0].currentSize
        for section in sections {
            if section.currentSize > largest {
                largest = section.currentSize
            }
        }
        var all_equal = true
        for section in sections {
            if section.currentSize != largest {
                all_equal = false
            }
        }
        if !all_equal {
            print("Sections were *NOT* all equal to \(largest)!")
            for section in sections {
                print("\(section.id), size = \(section.currentSize)")
            }
            return false
        }
        return true
    }
    
    
    @Test func test_expand_with_one_rule_for_piece() {
        
        for _ in 0..<128 {
            let pages = get_random_pages()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            let link_pieces = getRandomElements(input: all_pieces, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRule = get_linkage_rule(pieces: link_pieces)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [pieceRule])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(pieces: link_pieces) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_with_one_rule_for_flexer() {
        
        for _ in 0..<128 {
            let pages = get_random_pages()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            let link_flexers = getRandomElements(input: all_flexers, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let flexerRule = get_linkage_rule(flexers: link_flexers)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [flexerRule])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(flexers: link_flexers) {
                    print("flexer linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_with_one_rule_for_chunk() {
        
        for _ in 0..<128 {
            let pages = get_random_pages()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
            let link_chunks = getRandomElements(input: all_chunks, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let chunkRule = get_linkage_rule(chunks: link_chunks)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [chunkRule])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(chunks: link_chunks) {
                    print("chunk linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_with_one_rule_for_node() {
        
        for _ in 0..<128 {
            let pages = get_random_pages()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
            let link_nodes = getRandomElements(input: all_nodes, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let nodeRule = get_linkage_rule(nodes: link_nodes)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [nodeRule])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(nodes: link_nodes) {
                    print("node linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_with_one_rule_for_section() {
        
        for _ in 0..<128 {
            let pages = get_random_pages()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
            let link_sections = getRandomElements(input: all_sections, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let sectionRule = get_linkage_rule(sections: link_sections)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [sectionRule])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(sections: link_sections) {
                    print("section linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    
    @Test func test_expand_with_one_rule_for_each() {
        
        for _ in 0..<128 {
            let pages = get_random_pages()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            let link_pieces = getRandomElements(input: all_pieces, count: 2)
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            let link_flexers = getRandomElements(input: all_flexers, count: 2)
            
            let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
            let link_chunks = getRandomElements(input: all_chunks, count: 2)
            
            let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
            let link_nodes = getRandomElements(input: all_nodes, count: 2)
            
            let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
            let link_sections = getRandomElements(input: all_sections, count: 2)
            
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRule = get_linkage_rule(pieces: link_pieces)
            let flexerRule = get_linkage_rule(flexers: link_flexers)
            let chunkRule = get_linkage_rule(chunks: link_chunks)
            let nodeRule = get_linkage_rule(nodes: link_nodes)
            let sectionRule = get_linkage_rule(sections: link_sections)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [pieceRule])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [flexerRule])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [chunkRule])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [nodeRule])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [sectionRule])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                
                if !are_all_equal_to_largest(pieces: link_pieces) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(flexers: link_flexers) {
                    print("flexer linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(chunks: link_chunks) {
                    print("chunk linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(nodes: link_nodes) {
                    print("node linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(sections: link_sections) {
                    print("section linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
            }
        }
    }
    
    @Test func test_expand_with_one_rule_for_each_ii() {
        
        for _ in 0..<128 {
            let pages = get_random_pages()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            let link_pieces = getRandomElements(input: all_pieces, count: Int.random(in: 2...6))
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            let link_flexers = getRandomElements(input: all_flexers, count: Int.random(in: 2...6))
            
            let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
            let link_chunks = getRandomElements(input: all_chunks, count: Int.random(in: 2...6))
            
            let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
            let link_nodes = getRandomElements(input: all_nodes, count: Int.random(in: 2...6))
            
            let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
            let link_sections = getRandomElements(input: all_sections, count: Int.random(in: 2...6))
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRule = get_linkage_rule(pieces: link_pieces)
            let flexerRule = get_linkage_rule(flexers: link_flexers)
            let chunkRule = get_linkage_rule(chunks: link_chunks)
            let nodeRule = get_linkage_rule(nodes: link_nodes)
            let sectionRule = get_linkage_rule(sections: link_sections)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [pieceRule])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [flexerRule])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [chunkRule])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [nodeRule])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [sectionRule])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(pieces: link_pieces) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(chunks: link_chunks) {
                    print("chunk linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(nodes: link_nodes) {
                    print("node linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(sections: link_sections) {
                    print("section linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_with_two_rules_for_each() {
        
        for _ in 0..<128 {
            let pages = get_random_pages()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            let link_pieces_a = getRandomElements(input: all_pieces, count: 2)
            let link_pieces_b = getRandomElements(input: all_pieces, count: 2)
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            let link_flexers_a = getRandomElements(input: all_flexers, count: 2)
            let link_flexers_b = getRandomElements(input: all_flexers, count: 2)
            
            let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
            let link_chunks_a = getRandomElements(input: all_chunks, count: 2)
            let link_chunks_b = getRandomElements(input: all_chunks, count: 2)
            
            let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
            let link_nodes_a = getRandomElements(input: all_nodes, count: 2)
            let link_nodes_b = getRandomElements(input: all_nodes, count: 2)
            
            let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
            let link_sections_a = getRandomElements(input: all_sections, count: 2)
            let link_sections_b = getRandomElements(input: all_sections, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRule_a = get_linkage_rule(pieces: link_pieces_a)
            let pieceRule_b = get_linkage_rule(pieces: link_pieces_b)
            
            let flexerRule_a = get_linkage_rule(flexers: link_flexers_a)
            let flexerRule_b = get_linkage_rule(flexers: link_flexers_b)
            
            let chunkRule_a = get_linkage_rule(chunks: link_chunks_a)
            let chunkRule_b = get_linkage_rule(chunks: link_chunks_b)
            
            let nodeRule_a = get_linkage_rule(nodes: link_nodes_a)
            let nodeRule_b = get_linkage_rule(nodes: link_nodes_b)
            
            let sectionRule_a = get_linkage_rule(sections: link_sections_a)
            let sectionRule_b = get_linkage_rule(sections: link_sections_b)
            
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [pieceRule_a, pieceRule_b])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [flexerRule_a, flexerRule_b])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [chunkRule_a, chunkRule_b])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [nodeRule_a, nodeRule_b])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [sectionRule_a, sectionRule_b])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(pieces: link_pieces_a) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(pieces: link_pieces_b) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(chunks: link_chunks_a) {
                    print("chunk linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(chunks: link_chunks_b) {
                    print("chunk linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                
                if !are_all_equal_to_largest(nodes: link_nodes_a) {
                    print("node linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(nodes: link_nodes_b) {
                    print("node linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                
                if !are_all_equal_to_largest(sections: link_sections_a) {
                    print("section linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(sections: link_sections_b) {
                    print("section linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_more_rigorous_large_row_size() {
        
        for _ in 0..<128 {
            let pages = get_random_pages()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let count_pieces = Int.random(in: 0...6)
            let count_flexers = Int.random(in: 0...6)
            let count_chunks = Int.random(in: 0...6)
            let count_nodes = Int.random(in: 0...6)
            let count_sections = Int.random(in: 0...6)
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            var links_pieces = [[SkeletonPiece]]()
            for _ in 0..<count_pieces {
                links_pieces.append(getRandomElements(input: all_pieces, count: Int.random(in: 2...4)))
            }
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            var links_flexers = [[Flexer]]()
            for _ in 0..<count_flexers {
                links_flexers.append(getRandomElements(input: all_flexers, count: Int.random(in: 2...4)))
            }
            
            let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
            var links_chunks = [[any SkeletonChunkConforming]]()
            for _ in 0..<count_chunks {
                links_chunks.append(getRandomElements(input: all_chunks, count: Int.random(in: 2...4)))
            }
            
            let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
            var links_nodes = [[SkeletonNode]]()
            for _ in 0..<count_nodes {
                links_nodes.append(getRandomElements(input: all_nodes, count: Int.random(in: 2...4)))
            }
            
            let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
            var links_sections = [[SkeletonSection]]()
            for _ in 0..<count_sections {
                links_sections.append(getRandomElements(input: all_sections, count: Int.random(in: 2...4)))
            }
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRules = links_pieces.map { get_linkage_rule(pieces: $0) }
            let flexerRules = links_flexers.map { get_linkage_rule(flexers: $0) }
            let chunkRules = links_chunks.map { get_linkage_rule(chunks: $0) }
            let nodeRules = links_nodes.map { get_linkage_rule(nodes: $0) }
            let sectionRules = links_sections.map { get_linkage_rule(sections: $0) }
            
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: pieceRules)
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: flexerRules)
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: chunkRules)
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: nodeRules)
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: sectionRules)
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                for links in links_pieces {
                    if !are_all_equal_to_largest(pieces: links) {
                        print("piece linkage rule did not work.")
                        #expect(Bool(false))
                        return
                    }
                }
                
                
                for links in links_chunks {
                    if !are_all_equal_to_largest(chunks: links) {
                        print("chunk linkage rule did not work.")
                        #expect(Bool(false))
                        return
                    }
                }
                
                for links in links_nodes {
                    if !are_all_equal_to_largest(nodes: links) {
                        print("node linkage rule did not work.")
                        #expect(Bool(false))
                        return
                    }
                }
                
                for links in links_sections {
                    if !are_all_equal_to_largest(sections: links) {
                        print("section linkage rule did not work.")
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    func get_random_pages_centered() -> [SkeletonPage] {
        var pages = [SkeletonPage]()
        let page_count = Int.random(in: 1...8)
        for _ in 0..<page_count {
            let row_count = Int.random(in: 1...8)
            var rows = [SkeletonRow]()
            for _ in 0..<row_count {
                let section_count = Int.random(in: 1...8)
                var sections: [SkeletonSection] = []
                for _ in 0..<section_count {
                    var nodes = [WiseLayoutNode]()
                    let node_count = Int.random(in: 1...8)
                    for _ in 0..<node_count {
                        let chunk_count = Int.random(in: 1...8)
                        var chunks = [any SkeletonChunkConforming]()
                        for _ in 0..<chunk_count {
                            let chunk = GenerateChunks.generate_random_10_flexer()
                            chunks.append(chunk)
                        }
                        let node = GenerateNodes.generate_node(chunks: chunks)
                        nodes.append(node)
                    }
                    let section = GenerateSections.generate_section(nodes: nodes)
                    sections.append(section)
                }
                let row = SkeletonRow(sections: sections, attemptedCenteredSection: sections.randomElement())
                rows.append(row)
            }
            let page = SkeletonPage(rows: rows)
            pages.append(page)
        }
        return pages
    }
    
    @Test func test_expand_with_one_rule_for_piece_centered() {
        
        for _ in 0..<128 {
            let pages = get_random_pages_centered()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            let link_pieces = getRandomElements(input: all_pieces, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRule = get_linkage_rule(pieces: link_pieces)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [pieceRule])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(pieces: link_pieces) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_with_one_rule_for_flexer_centered() {
        for _ in 0..<128 {
            let pages = get_random_pages_centered()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            let link_flexers = getRandomElements(input: all_flexers, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let flexerRule = get_linkage_rule(flexers: link_flexers)
            
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [flexerRule])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(flexers: link_flexers) {
                    print("flexer linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_with_one_rule_for_chunk_centered() {
        
        for _ in 0..<128 {
            let pages = get_random_pages_centered()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
            let link_chunks = getRandomElements(input: all_chunks, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let chunkRule = get_linkage_rule(chunks: link_chunks)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [chunkRule])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(chunks: link_chunks) {
                    print("chunk linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_with_one_rule_for_node_centered() {
        
        for _ in 0..<128 {
            let pages = get_random_pages_centered()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
            let link_nodes = getRandomElements(input: all_nodes, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let nodeRule = get_linkage_rule(nodes: link_nodes)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [nodeRule])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(nodes: link_nodes) {
                    print("node linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_with_one_rule_for_section_centered() {
        
        for _ in 0..<128 {
            let pages = get_random_pages_centered()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
            let link_sections = getRandomElements(input: all_sections, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let sectionRule = get_linkage_rule(sections: link_sections)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [sectionRule])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(sections: link_sections) {
                    print("section linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    
    @Test func test_expand_with_one_rule_for_each_centered() {
        
        for _ in 0..<128 {
            let pages = get_random_pages_centered()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            let link_pieces = getRandomElements(input: all_pieces, count: 2)
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            let link_flexers = getRandomElements(input: all_flexers, count: 2)
            
            let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
            let link_chunks = getRandomElements(input: all_chunks, count: 2)
            
            let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
            let link_nodes = getRandomElements(input: all_nodes, count: 2)
            
            let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
            let link_sections = getRandomElements(input: all_sections, count: 2)
            
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRule = get_linkage_rule(pieces: link_pieces)
            let flexerRule = get_linkage_rule(flexers: link_flexers)
            let chunkRule = get_linkage_rule(chunks: link_chunks)
            let nodeRule = get_linkage_rule(nodes: link_nodes)
            let sectionRule = get_linkage_rule(sections: link_sections)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [pieceRule])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [flexerRule])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [chunkRule])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [nodeRule])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [sectionRule])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(pieces: link_pieces) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(flexers: link_flexers) {
                    print("flexer linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(chunks: link_chunks) {
                    print("chunk linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(nodes: link_nodes) {
                    print("node linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(sections: link_sections) {
                    print("section linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
            }
        }
    }
    
    @Test func test_expand_with_one_rule_for_each_ii_centered() {
        
        for _ in 0..<128 {
            let pages = get_random_pages_centered()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            let link_pieces = getRandomElements(input: all_pieces, count: Int.random(in: 2...6))
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            let link_flexers = getRandomElements(input: all_flexers, count: Int.random(in: 2...6))
            
            let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
            let link_chunks = getRandomElements(input: all_chunks, count: Int.random(in: 2...6))
            
            let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
            let link_nodes = getRandomElements(input: all_nodes, count: Int.random(in: 2...6))
            
            let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
            let link_sections = getRandomElements(input: all_sections, count: Int.random(in: 2...6))
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRule = get_linkage_rule(pieces: link_pieces)
            let flexerRule = get_linkage_rule(flexers: link_flexers)
            let chunkRule = get_linkage_rule(chunks: link_chunks)
            let nodeRule = get_linkage_rule(nodes: link_nodes)
            let sectionRule = get_linkage_rule(sections: link_sections)
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [pieceRule])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [flexerRule])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [chunkRule])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [nodeRule])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [sectionRule])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(pieces: link_pieces) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(flexers: link_flexers) {
                    print("flexer linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(chunks: link_chunks) {
                    print("chunk linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(nodes: link_nodes) {
                    print("node linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(sections: link_sections) {
                    print("section linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_with_two_rules_for_each_centered() {
        
        for _ in 0..<128 {
            let pages = get_random_pages_centered()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            let link_pieces_a = getRandomElements(input: all_pieces, count: 2)
            let link_pieces_b = getRandomElements(input: all_pieces, count: 2)
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            let link_flexers_a = getRandomElements(input: all_flexers, count: 2)
            let link_flexers_b = getRandomElements(input: all_flexers, count: 2)
            
            let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
            let link_chunks_a = getRandomElements(input: all_chunks, count: 2)
            let link_chunks_b = getRandomElements(input: all_chunks, count: 2)
            
            
            let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
            let link_nodes_a = getRandomElements(input: all_nodes, count: 2)
            let link_nodes_b = getRandomElements(input: all_nodes, count: 2)
            
            let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
            let link_sections_a = getRandomElements(input: all_sections, count: 2)
            let link_sections_b = getRandomElements(input: all_sections, count: 2)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRule_a = get_linkage_rule(pieces: link_pieces_a)
            let pieceRule_b = get_linkage_rule(pieces: link_pieces_b)
            
            let flexerRule_a = get_linkage_rule(flexers: link_flexers_a)
            let flexerRule_b = get_linkage_rule(flexers: link_flexers_b)
            
            let chunkRule_a = get_linkage_rule(chunks: link_chunks_a)
            let chunkRule_b = get_linkage_rule(chunks: link_chunks_b)
            
            let nodeRule_a = get_linkage_rule(nodes: link_nodes_a)
            let nodeRule_b = get_linkage_rule(nodes: link_nodes_b)
            
            let sectionRule_a = get_linkage_rule(sections: link_sections_a)
            let sectionRule_b = get_linkage_rule(sections: link_sections_b)
            
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [pieceRule_a, pieceRule_b])
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [flexerRule_a, flexerRule_b])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [chunkRule_a, chunkRule_b])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [nodeRule_a, nodeRule_b])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [sectionRule_a, sectionRule_b])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                if !are_all_equal_to_largest(pieces: link_pieces_a) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(pieces: link_pieces_b) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(flexers: link_flexers_a) {
                    print("flexer linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(flexers: link_flexers_b) {
                    print("flexer linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(chunks: link_chunks_a) {
                    print("chunk linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(chunks: link_chunks_b) {
                    print("chunk linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                
                if !are_all_equal_to_largest(nodes: link_nodes_a) {
                    print("node linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(nodes: link_nodes_b) {
                    print("node linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                
                if !are_all_equal_to_largest(sections: link_sections_a) {
                    print("section linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
                
                if !are_all_equal_to_largest(sections: link_sections_b) {
                    print("section linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
    
    @Test func test_expand_more_rigorous_large_row_size_centered() {
        
        for _ in 0..<128 {
            let pages = get_random_pages_centered()
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            let count_pieces = Int.random(in: 0...6)
            let count_flexers = Int.random(in: 0...6)
            let count_chunks = Int.random(in: 0...6)
            let count_nodes = Int.random(in: 0...6)
            let count_sections = Int.random(in: 0...6)
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            var links_pieces = [[SkeletonPiece]]()
            for _ in 0..<count_pieces {
                links_pieces.append(getRandomElements(input: all_pieces, count: Int.random(in: 2...4)))
            }
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            var links_flexers = [[Flexer]]()
            for _ in 0..<count_flexers {
                links_flexers.append(getRandomElements(input: all_flexers, count: Int.random(in: 2...4)))
            }
            
            let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
            var links_chunks = [[any SkeletonChunkConforming]]()
            for _ in 0..<count_chunks {
                links_chunks.append(getRandomElements(input: all_chunks, count: Int.random(in: 2...4)))
            }
            
            let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
            var links_nodes = [[SkeletonNode]]()
            for _ in 0..<count_nodes {
                links_nodes.append(getRandomElements(input: all_nodes, count: Int.random(in: 2...4)))
            }
            
            let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
            var links_sections = [[SkeletonSection]]()
            for _ in 0..<count_sections {
                links_sections.append(getRandomElements(input: all_sections, count: Int.random(in: 2...4)))
            }
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRules = links_pieces.map { get_linkage_rule(pieces: $0) }
            let flexerRules = links_flexers.map { get_linkage_rule(flexers: $0) }
            let chunkRules = links_chunks.map { get_linkage_rule(chunks: $0) }
            let nodeRules = links_nodes.map { get_linkage_rule(nodes: $0) }
            let sectionRules = links_sections.map { get_linkage_rule(sections: $0) }
            
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: pieceRules)
            let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: flexerRules)
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: chunkRules)
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: nodeRules)
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: sectionRules)
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: flexers,
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                for links in links_pieces {
                    if !are_all_equal_to_largest(pieces: links) {
                        print("piece linkage rule did not work.")
                        #expect(Bool(false))
                        return
                    }
                }
                
                for links in links_flexers {
                    if !are_all_equal_to_largest(flexers: links) {
                        print("flexer linkage rule did not work.")
                        #expect(Bool(false))
                        return
                    }
                }
                
                for links in links_chunks {
                    if !are_all_equal_to_largest(chunks: links) {
                        print("chunk linkage rule did not work.")
                        #expect(Bool(false))
                        return
                    }
                }
                
                for links in links_nodes {
                    if !are_all_equal_to_largest(nodes: links) {
                        print("node linkage rule did not work.")
                        #expect(Bool(false))
                        return
                    }
                }
                
                for links in links_sections {
                    if !are_all_equal_to_largest(sections: links) {
                        print("section linkage rule did not work.")
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
}
