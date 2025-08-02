//
//  BruteForceExpanderTests_HelloWorld.swift
//  OphiuchusTests
//
//  Created by Nick on 7/6/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct BruteForceExpanderTests_HelloWorld {
    
    @Test func test_possible_piece_expand_minimal() {
        
        let chunk_a = GenerateChunks.generate_fixed(size: 10)
        let chunk_b = GenerateChunks.generate_fixed(size: 20)
        
        let piece_a = chunk_a.pieces[0]
        let piece_b = chunk_b.pieces[0]
        
        let node_a = GenerateNodes.generate_node(chunk: chunk_a)
        let node_b = GenerateNodes.generate_node(chunk: chunk_b)
        
        let section_a = GenerateSections.generate_section(node: node_a)
        let section_b = GenerateSections.generate_section(node: node_b)
        
        let row_a = GenerateRows.generate_Row(section: section_a)
        let row_b = GenerateRows.generate_Row(section: section_b)
        
        let page_a = SkeletonPage(row: row_a)
        let page_b = SkeletonPage(row: row_b)
        
        let pages = [page_a, page_b]
        
        let rule = SkeletonLinkageRule_Pieces(pieces: [piece_a, piece_b], layoutPriority: .required)
        
        let piece_groups = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [rule])
        let chunk_groups = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
        let node_groups = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
        let section_groups = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
        
        let menuWidthWithSafeArea = 800
        let safeAreaLeft = 16
        let safeAreaRight = 36
        
        for node_group in node_groups {
            print("Node Group Was \(node_group.linkedList.map {  $0.id} )")
        }
        
        SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                        menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                        safeAreaLeft: safeAreaLeft,
                                                        safeAreaRight: safeAreaRight)
        SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                               pieces: piece_groups,
                                                               flexers: [],
                                                               chunks: chunk_groups,
                                                               nodes: node_groups,
                                                               sections: section_groups,
                                                               layoutPriority: .required)
        
        
        if !(piece_a.currentSize == 20) {
            print("In this simple test, both should end up with a width of 20.")
            print("piece_a had a size of \(piece_a.currentSize)")
            #expect(Bool(false))
            return
        }
        
        if !(piece_b.currentSize == 20) {
            print("In this simple test, both should end up with a width of 20.")
            print("piece_b had a size of \(piece_b.currentSize)")
            
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_impossible_piece_expand_minimal() {
        
        let alignment = GenerateAlignment.generate_alignment()
        
        let piece_b_1 = GeneratePieces.generate_piece(size: 5)
        let piece_b_2 = GeneratePieces.generate_piece(size: 5)
        
        let chunk_a = GenerateChunks.generate_fixed(size: 20)
        let chunk_b = SkeletonChunkHeroLong(id: 0,
                                            chunkIdentifier: .unknown,
                                            left: Flexer(id: 0, flexerIdentifier: .unknown),
                                            icon: piece_b_1,
                                            spacing: Flexer(id: 1, flexerIdentifier: .unknown),
                                            label: piece_b_2,
                                            right: Flexer(id: 2, flexerIdentifier: .unknown),
                                            alignment: alignment)
        
        let piece_a = chunk_a.pieces[0]
        
        let node_a = GenerateNodes.generate_node(chunk: chunk_a)
        let node_b = GenerateNodes.generate_node(chunk: chunk_b)
        
        let section_a = GenerateSections.generate_section(node: node_a)
        let section_b = GenerateSections.generate_section(node: node_b)
        
        let row_a = GenerateRows.generate_Row(section: section_a)
        let row_b = GenerateRows.generate_Row(section: section_b)
        
        let page_a = SkeletonPage(row: row_a)
        let page_b = SkeletonPage(row: row_b)
        
        let pages = [page_a, page_b]
        
        let piece_rule = SkeletonLinkageRule_Pieces(pieces: [piece_a, piece_b_1, piece_b_2], layoutPriority: .required)
        let chunk_rule = SkeletonLinkageRule_Chunks(chunks: [chunk_a, chunk_b], layoutPriority: .required)
        
        let piece_groups = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [piece_rule])
        let chunk_groups = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [chunk_rule])
        let node_groups = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
        let section_groups = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
        
        let menuWidthWithSafeArea = 20000
        let safeAreaLeft = 32
        let safeAreaRight = 32
        
        SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                        menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                        safeAreaLeft: safeAreaLeft,
                                                        safeAreaRight: safeAreaRight)
        if !(node_a.skeletonNodes[0].currentSize == 20) {
            print("Node a should be size 20.")
            #expect(Bool(false))
            return
        }
        
        if !(node_b.skeletonNodes[0].currentSize == 10) {
            print("Node a should be size 20.")
            #expect(Bool(false))
            return
        }
        
        SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                               pieces: piece_groups,
                                                               flexers: [],
                                                               chunks: chunk_groups,
                                                               nodes: node_groups,
                                                               sections: section_groups,
                                                               layoutPriority: .required)
        
        if !(piece_b_1.currentSize == piece_a.currentSize) {
            print("piece_b_1 and piece_a are \(piece_b_1.currentSize) and \(piece_a.currentSize).")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_some_random_ones_no_rules() {
        for _ in 0..<1024 {
            var pages = [SkeletonPage]()
            let page_count = Int.random(in: 1...3)
            for _ in 0..<page_count {
                let row_count = Int.random(in: 1...3)
                var rows = [SkeletonRow]()
                for _ in 0..<row_count {
                    let section_count = Int.random(in: 1...3)
                    var sections: [SkeletonSection] = []
                    for _ in 0..<section_count {
                        var nodes = [WiseLayoutNode]()
                        let node_count = Int.random(in: 1...3)
                        for _ in 0..<node_count {
                            let chunk_count = Int.random(in: 1...3)
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
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            for page in pages {
                for row in page.rows {
                    row.temp_size_required = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                  safeAreaLeft: safeAreaLeft,
                                                                  safeAreaRight: safeAreaRight,
                                                                  layoutPriority: .required)
                    row.temp_size_high = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                              safeAreaLeft: safeAreaLeft,
                                                              safeAreaRight: safeAreaRight,
                                                              layoutPriority: .high)
                    row.temp_size_medium = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                safeAreaLeft: safeAreaLeft,
                                                                safeAreaRight: safeAreaRight,
                                                                layoutPriority: .medium)
                    row.temp_size_low = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                             safeAreaLeft: safeAreaLeft,
                                                             safeAreaRight: safeAreaRight,
                                                             layoutPriority: .low)
                    row.temp_size_finally = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                 safeAreaLeft: safeAreaLeft,
                                                                 safeAreaRight: safeAreaRight,
                                                                 layoutPriority: .finally)
                }
            }
            
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: [],
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                for page in pages {
                    for row in page.rows {
                        
                        let expected_size: Int
                        switch layoutPriority {
                        case .required:
                            expected_size = row.temp_size_required
                        case .high:
                            expected_size = row.temp_size_high
                        case .medium:
                            expected_size = row.temp_size_medium
                        case .low:
                            expected_size = row.temp_size_low
                        case .finally:
                            expected_size = row.temp_size_finally
                        }
                        
                        if row.children_size != expected_size {
                            print("At \(layoutPriority), expected size to be \(expected_size), but it was \(row.children_size), layoutPriority was \(layoutPriority)")
                            #expect(Bool(false))
                            return
                            
                        }
                    }
                }
            }
        }
    }
    
    @Test func test_some_random_ones_no_rules_short_hand() {
        
        for _ in 0..<1024 {
            
            var pages = [SkeletonPage]()
            let page_count = Int.random(in: 0...4)
            for _ in 0..<page_count {
                let row_count = Int.random(in: 0...6)
                var rows = [SkeletonRow]()
                for _ in 0..<row_count {
                    let section_count = Int.random(in: 0...4)
                    
                    var sections: [SkeletonSection] = []
                    for _ in 0..<section_count {
                        var nodes = [WiseLayoutNode]()
                        let node_count = Int.random(in: 0...4)
                        for _ in 0..<node_count {
                            let chunk_count = Int.random(in: 0...4)
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
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            for page in pages {
                for row in page.rows {
                    row.temp_size_required = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                  safeAreaLeft: safeAreaLeft,
                                                                  safeAreaRight: safeAreaRight,
                                                                  layoutPriority: .required)
                    row.temp_size_high = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                              safeAreaLeft: safeAreaLeft,
                                                              safeAreaRight: safeAreaRight,
                                                              layoutPriority: .high)
                    row.temp_size_medium = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                safeAreaLeft: safeAreaLeft,
                                                                safeAreaRight: safeAreaRight,
                                                                layoutPriority: .medium)
                    row.temp_size_low = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                             safeAreaLeft: safeAreaLeft,
                                                             safeAreaRight: safeAreaRight,
                                                             layoutPriority: .low)
                    row.temp_size_finally = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                 safeAreaLeft: safeAreaLeft,
                                                                 safeAreaRight: safeAreaRight,
                                                                 layoutPriority: .finally)
                }
            }
            
            for layoutPriority in LayoutPriority.allCases {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       layoutPriority: layoutPriority)
                
                for page in pages {
                    for row in page.rows {
                        
                        let expected_size: Int
                        switch layoutPriority {
                        case .required:
                            expected_size = row.temp_size_required
                        case .high:
                            expected_size = row.temp_size_high
                        case .medium:
                            expected_size = row.temp_size_medium
                        case .low:
                            expected_size = row.temp_size_low
                        case .finally:
                            expected_size = row.temp_size_finally
                        }
                        
                        if row.children_size != expected_size {
                            print("At \(layoutPriority), expected size to be \(expected_size), but it was \(row.children_size), layoutPriority was \(layoutPriority)")
                            #expect(Bool(false))
                            return
                            
                        }
                        
                    }
                }
            }
        }
    }
    
    @Test func test_some_random_ones_no_rules_variable_sizes() {
        for _ in 0..<1024 {
            var pages = [SkeletonPage]()
            let page_count = Int.random(in: 1...3)
            for _ in 0..<page_count {
                let row_count = Int.random(in: 1...3)
                var rows = [SkeletonRow]()
                for _ in 0..<row_count {
                    let section_count = Int.random(in: 1...4)
                    var sections: [SkeletonSection] = []
                    for _ in 0..<section_count {
                        var nodes = [WiseLayoutNode]()
                        let node_count = Int.random(in: 1...6)
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
            
            let menuWidthWithSafeArea = Int.random(in: 0...40000)
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            for page in pages {
                for row in page.rows {
                    row.temp_size_required = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                  safeAreaLeft: safeAreaLeft,
                                                                  safeAreaRight: safeAreaRight,
                                                                  layoutPriority: .required)
                    row.temp_size_high = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                              safeAreaLeft: safeAreaLeft,
                                                              safeAreaRight: safeAreaRight,
                                                              layoutPriority: .high)
                    row.temp_size_medium = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                safeAreaLeft: safeAreaLeft,
                                                                safeAreaRight: safeAreaRight,
                                                                layoutPriority: .medium)
                    row.temp_size_low = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                             safeAreaLeft: safeAreaLeft,
                                                             safeAreaRight: safeAreaRight,
                                                             layoutPriority: .low)
                    row.temp_size_finally = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                 safeAreaLeft: safeAreaLeft,
                                                                 safeAreaRight: safeAreaRight,
                                                                 layoutPriority: .finally)
                }
            }
            
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: [],
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                for page in pages {
                    for row in page.rows {
                        
                        let expected_size: Int
                        switch layoutPriority {
                        case .required:
                            expected_size = row.temp_size_required
                        case .high:
                            expected_size = row.temp_size_high
                        case .medium:
                            expected_size = row.temp_size_medium
                        case .low:
                            expected_size = row.temp_size_low
                        case .finally:
                            expected_size = row.temp_size_finally
                        }
                        
                        var children_size = row.children_size
                        if children_size > expected_size {
                            children_size = expected_size
                        }
                        
                        if children_size != expected_size {
                            print("row.children_size was \(row.children_size)")
                            print("expected_size was \(expected_size)")
                            
                            print("At \(layoutPriority), expected size to be \(expected_size), but it was \(row.children_size)")
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
    }
    
    @Test func test_some_random_ones_no_rules_variable_sizes_short_hand() {
        for _ in 0..<1024 {
            var pages = [SkeletonPage]()
            let page_count = Int.random(in: 0...2)
            for _ in 0..<page_count {
                let row_count = Int.random(in: 0...2)
                var rows = [SkeletonRow]()
                for _ in 0..<row_count {
                    let section_count = Int.random(in: 0...2)
                    var sections: [SkeletonSection] = []
                    for _ in 0..<section_count {
                        var nodes = [WiseLayoutNode]()
                        let node_count = Int.random(in: 0...2)
                        for _ in 0..<node_count {
                            let chunk_count = Int.random(in: 0...2)
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
            
            let menuWidthWithSafeArea = Int.random(in: 0...40000)
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            for page in pages {
                for row in page.rows {
                    row.temp_size_required = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                  safeAreaLeft: safeAreaLeft,
                                                                  safeAreaRight: safeAreaRight,
                                                                  layoutPriority: .required)
                    row.temp_size_high = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                              safeAreaLeft: safeAreaLeft,
                                                              safeAreaRight: safeAreaRight,
                                                              layoutPriority: .high)
                    row.temp_size_medium = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                safeAreaLeft: safeAreaLeft,
                                                                safeAreaRight: safeAreaRight,
                                                                layoutPriority: .medium)
                    row.temp_size_low = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                             safeAreaLeft: safeAreaLeft,
                                                             safeAreaRight: safeAreaRight,
                                                             layoutPriority: .low)
                    row.temp_size_finally = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                 safeAreaLeft: safeAreaLeft,
                                                                 safeAreaRight: safeAreaRight,
                                                                 layoutPriority: .finally)
                }
            }
            
            for layoutPriority in LayoutPriority.allCases {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       layoutPriority: layoutPriority)
                
                for page in pages {
                    for row in page.rows {
                        
                        let expected_size: Int
                        switch layoutPriority {
                        case .required:
                            expected_size = row.temp_size_required
                        case .high:
                            expected_size = row.temp_size_high
                        case .medium:
                            expected_size = row.temp_size_medium
                        case .low:
                            expected_size = row.temp_size_low
                        case .finally:
                            expected_size = row.temp_size_finally
                        }
                        
                        var children_size = row.children_size
                        if children_size > expected_size {
                            children_size = expected_size
                        }
                        
                        if children_size != expected_size {
                            print("row.children_size was \(row.children_size)")
                            print("expected_size was \(expected_size)")
                            
                            print("At \(layoutPriority), expected size to be \(expected_size), but it was \(row.children_size)")
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
    }
    
    @Test func test_some_random_ones_no_rules_centered() {
        for _ in 0..<1024 {
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
                    
                    let row = SkeletonRow(sections: sections, attemptedCenteredSection: sections.randomElement())
                    rows.append(row)
                }
                let page = SkeletonPage(rows: rows)
                pages.append(page)
            }
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            for page in pages {
                for row in page.rows {
                    row.temp_size_required = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                  safeAreaLeft: safeAreaLeft,
                                                                  safeAreaRight: safeAreaRight,
                                                                  layoutPriority: .required)
                    row.temp_size_high = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                              safeAreaLeft: safeAreaLeft,
                                                              safeAreaRight: safeAreaRight,
                                                              layoutPriority: .high)
                    row.temp_size_medium = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                safeAreaLeft: safeAreaLeft,
                                                                safeAreaRight: safeAreaRight,
                                                                layoutPriority: .medium)
                    row.temp_size_low = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                             safeAreaLeft: safeAreaLeft,
                                                             safeAreaRight: safeAreaRight,
                                                             layoutPriority: .low)
                    row.temp_size_finally = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                 safeAreaLeft: safeAreaLeft,
                                                                 safeAreaRight: safeAreaRight,
                                                                 layoutPriority: .finally)
                }
            }
            
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: [],
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                for page in pages {
                    for row in page.rows {
                        
                        let expected_size: Int
                        switch layoutPriority {
                        case .required:
                            expected_size = row.temp_size_required
                        case .high:
                            expected_size = row.temp_size_high
                        case .medium:
                            expected_size = row.temp_size_medium
                        case .low:
                            expected_size = row.temp_size_low
                        case .finally:
                            expected_size = row.temp_size_finally
                        }
                        
                        if row.children_size != expected_size {
                            print("At \(layoutPriority), expected size to be \(expected_size), but it was \(row.children_size), layoutPriority was \(layoutPriority)")
                            #expect(Bool(false))
                            return
                            
                        }
                    }
                }
            }
        }
    }
    
    @Test func test_some_random_ones_no_rules_short_hand_centered() {
        
        for _ in 0..<1024 {
            
            var pages = [SkeletonPage]()
            let page_count = Int.random(in: 0...4)
            for _ in 0..<page_count {
                let row_count = Int.random(in: 0...6)
                var rows = [SkeletonRow]()
                for _ in 0..<row_count {
                    let section_count = Int.random(in: 0...4)
                    
                    var sections: [SkeletonSection] = []
                    for _ in 0..<section_count {
                        var nodes = [WiseLayoutNode]()
                        let node_count = Int.random(in: 0...4)
                        for _ in 0..<node_count {
                            let chunk_count = Int.random(in: 0...4)
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
            
            let menuWidthWithSafeArea = 100_000_000
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            for page in pages {
                for row in page.rows {
                    row.temp_size_required = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                  safeAreaLeft: safeAreaLeft,
                                                                  safeAreaRight: safeAreaRight,
                                                                  layoutPriority: .required)
                    row.temp_size_high = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                              safeAreaLeft: safeAreaLeft,
                                                              safeAreaRight: safeAreaRight,
                                                              layoutPriority: .high)
                    row.temp_size_medium = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                safeAreaLeft: safeAreaLeft,
                                                                safeAreaRight: safeAreaRight,
                                                                layoutPriority: .medium)
                    row.temp_size_low = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                             safeAreaLeft: safeAreaLeft,
                                                             safeAreaRight: safeAreaRight,
                                                             layoutPriority: .low)
                    row.temp_size_finally = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                 safeAreaLeft: safeAreaLeft,
                                                                 safeAreaRight: safeAreaRight,
                                                                 layoutPriority: .finally)
                }
            }
            
            for layoutPriority in LayoutPriority.allCases {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       layoutPriority: layoutPriority)
                
                for page in pages {
                    for row in page.rows {
                        
                        let expected_size: Int
                        switch layoutPriority {
                        case .required:
                            expected_size = row.temp_size_required
                        case .high:
                            expected_size = row.temp_size_high
                        case .medium:
                            expected_size = row.temp_size_medium
                        case .low:
                            expected_size = row.temp_size_low
                        case .finally:
                            expected_size = row.temp_size_finally
                        }
                        
                        if row.children_size != expected_size {
                            print("At \(layoutPriority), expected size to be \(expected_size), but it was \(row.children_size), layoutPriority was \(layoutPriority)")
                            #expect(Bool(false))
                            return
                            
                        }
                        
                    }
                }
            }
        }
    }
    
    // Note: This test is a little short-sighted.
    //       It's been modified to always keep the row
    //       sizes larger. "computeSize_test" does not
    //       consider centering; it was orignally crafted
    //       before centering existed...
    @Test func test_some_random_ones_no_rules_variable_sizes_centered() {
        for _ in 0..<1024 {
            var pages = [SkeletonPage]()
            let page_count = Int.random(in: 1...3)
            for _ in 0..<page_count {
                let row_count = Int.random(in: 1...3)
                var rows = [SkeletonRow]()
                for _ in 0..<row_count {
                    let section_count = Int.random(in: 1...4)
                    var sections: [SkeletonSection] = []
                    for _ in 0..<section_count {
                        var nodes = [WiseLayoutNode]()
                        let node_count = Int.random(in: 1...6)
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
                    let row = SkeletonRow(sections: sections, attemptedCenteredSection: sections.randomElement())
                    rows.append(row)
                }
                let page = SkeletonPage(rows: rows)
                pages.append(page)
            }
            
            let menuWidthWithSafeArea = Int.random(in: 20000...40000)
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            for page in pages {
                for row in page.rows {
                    row.temp_size_required = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                  safeAreaLeft: safeAreaLeft,
                                                                  safeAreaRight: safeAreaRight,
                                                                  layoutPriority: .required)
                    row.temp_size_high = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                              safeAreaLeft: safeAreaLeft,
                                                              safeAreaRight: safeAreaRight,
                                                              layoutPriority: .high)
                    row.temp_size_medium = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                safeAreaLeft: safeAreaLeft,
                                                                safeAreaRight: safeAreaRight,
                                                                layoutPriority: .medium)
                    row.temp_size_low = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                             safeAreaLeft: safeAreaLeft,
                                                             safeAreaRight: safeAreaRight,
                                                             layoutPriority: .low)
                    row.temp_size_finally = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                 safeAreaLeft: safeAreaLeft,
                                                                 safeAreaRight: safeAreaRight,
                                                                 layoutPriority: .finally)
                }
            }
            
            let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
            let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
            let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
            let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
            
            for layoutPriority in [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally] {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       pieces: pieces,
                                                                       flexers: [],
                                                                       chunks: chunks,
                                                                       nodes: nodes,
                                                                       sections: sections,
                                                                       layoutPriority: layoutPriority)
                
                for page in pages {
                    for row in page.rows {
                        
                        let expected_size: Int
                        switch layoutPriority {
                        case .required:
                            expected_size = row.temp_size_required
                        case .high:
                            expected_size = row.temp_size_high
                        case .medium:
                            expected_size = row.temp_size_medium
                        case .low:
                            expected_size = row.temp_size_low
                        case .finally:
                            expected_size = row.temp_size_finally
                        }
                        
                        var children_size = row.children_size
                        if children_size > expected_size {
                            children_size = expected_size
                        }
                        
                        if children_size != expected_size {
                            print("row.children_size was \(row.children_size)")
                            print("expected_size was \(expected_size)")
                            print("At \(layoutPriority), expected size to be \(expected_size), but it was \(row.children_size)")
                            print("row.temp_size_required = \(row.temp_size_required)")
                            print("row.temp_size_high = \(row.temp_size_high)")
                            print("row.temp_size_medium = \(row.temp_size_medium)")
                            print("row.temp_size_low = \(row.temp_size_low)")
                            print("row.temp_size_finally = \(row.temp_size_finally)")
                            
                            print("row.remaining_size = \(row.remaining_size)")
                            print("row.left_size = \(row.left_size)")
                            print("row.center_size = \(row.center_size)")
                            print("row.right_size = \(row.right_size)")
                            
                            
                            #expect(Bool(false))
                            
                            
                            
                            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                            safeAreaLeft: safeAreaLeft,
                                                                            safeAreaRight: safeAreaRight)
                            SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                                   pieces: pieces,
                                                                                   flexers: [],
                                                                                   chunks: chunks,
                                                                                   nodes: nodes,
                                                                                   sections: sections,
                                                                                   layoutPriority: layoutPriority)
                            
                            
                            return
                        }
                    }
                }
            }
        }
    }
    
    @Test func test_some_random_ones_no_rules_variable_sizes_short_hand_centered() {
        for _ in 0..<1024 {
            var pages = [SkeletonPage]()
            let page_count = Int.random(in: 0...2)
            for _ in 0..<page_count {
                let row_count = Int.random(in: 0...2)
                var rows = [SkeletonRow]()
                for _ in 0..<row_count {
                    let section_count = Int.random(in: 0...2)
                    var sections: [SkeletonSection] = []
                    for _ in 0..<section_count {
                        var nodes = [WiseLayoutNode]()
                        let node_count = Int.random(in: 0...2)
                        for _ in 0..<node_count {
                            let chunk_count = Int.random(in: 0...2)
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
            
            let menuWidthWithSafeArea = Int.random(in: 20000...40000)
            let safeAreaLeft = 0
            let safeAreaRight = 0
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            for page in pages {
                for row in page.rows {
                    row.temp_size_required = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                  safeAreaLeft: safeAreaLeft,
                                                                  safeAreaRight: safeAreaRight,
                                                                  layoutPriority: .required)
                    row.temp_size_high = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                              safeAreaLeft: safeAreaLeft,
                                                              safeAreaRight: safeAreaRight,
                                                              layoutPriority: .high)
                    row.temp_size_medium = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                safeAreaLeft: safeAreaLeft,
                                                                safeAreaRight: safeAreaRight,
                                                                layoutPriority: .medium)
                    row.temp_size_low = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                             safeAreaLeft: safeAreaLeft,
                                                             safeAreaRight: safeAreaRight,
                                                             layoutPriority: .low)
                    row.temp_size_finally = row.computeSize_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                 safeAreaLeft: safeAreaLeft,
                                                                 safeAreaRight: safeAreaRight,
                                                                 layoutPriority: .finally)
                }
            }
            
            for layoutPriority in LayoutPriority.allCases {
                
                SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                       layoutPriority: layoutPriority)
                
                for page in pages {
                    for row in page.rows {
                        
                        let expected_size: Int
                        switch layoutPriority {
                        case .required:
                            expected_size = row.temp_size_required
                        case .high:
                            expected_size = row.temp_size_high
                        case .medium:
                            expected_size = row.temp_size_medium
                        case .low:
                            expected_size = row.temp_size_low
                        case .finally:
                            expected_size = row.temp_size_finally
                        }
                        
                        var children_size = row.children_size
                        if children_size > expected_size {
                            children_size = expected_size
                        }
                        
                        if children_size != expected_size {
                            print("row.children_size was \(row.children_size)")
                            print("expected_size was \(expected_size)")
                            
                            print("At \(layoutPriority), expected size to be \(expected_size), but it was \(row.children_size)")
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
    }
}
