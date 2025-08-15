//
//  BruteForceExpanderTests_CenteringBasics.swift
//  OphiuchusTests
//
//  Created by Nick on 7/9/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct BruteForceExpanderTests_CenteringBasics {
    
    func get_random_row() -> SkeletonRow {
        let section_count = Int.random(in: 1...4)
        var sections: [SkeletonSection] = []
        for _ in 0..<section_count {
            var nodes = [WiseLayoutNode]()
            let node_count = Int.random(in: 1...4)
            for _ in 0..<node_count {
                let chunk_count = Int.random(in: 1...4)
                var chunks = [SkeletonChunk]()
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
        let row = GenerateRows.generate_Row(sections: sections, centeredSection: sections.randomElement())
        return row
    }
    
    @Test func test_center_hello_world() {
        
        for _ in 0..<2048 {
            
            let chunk_left_1 = GenerateChunks.generate_hero_long_10_flexer()
            let chunk_left_2 = GenerateChunks.generate_hero_long_10_flexer()
            
            let chunk_center_1 = GenerateChunks.generate_hero_long_10_flexer()
            let chunk_center_2 = GenerateChunks.generate_hero_long_10_flexer()
            
            let chunk_right_1 = GenerateChunks.generate_hero_long_10_flexer()
            let chunk_right_2 = GenerateChunks.generate_hero_long_10_flexer()
            
            let node_left_1 = GenerateNodes.generate_node(chunks: [chunk_left_1])
            let node_left_2 = GenerateNodes.generate_node(chunks: [chunk_left_2])
            
            let node_center_1 = GenerateNodes.generate_node(chunks: [chunk_center_1])
            let node_center_2 = GenerateNodes.generate_node(chunks: [chunk_center_2])
            
            let node_right_1 = GenerateNodes.generate_node(chunks: [chunk_right_1])
            let node_right_2 = GenerateNodes.generate_node(chunks: [chunk_right_2])
            
            let section_left = GenerateSections.generate_section(nodes: [node_left_1, node_left_2])
            
            let section_center = GenerateSections.generate_section(nodes: [node_center_1, node_center_2])
            
            let section_right_1 = GenerateSections.generate_section(node: node_right_1)
            let section_right_2 = GenerateSections.generate_section(node: node_right_2)
            
            let sections = [section_left, section_center, section_right_1, section_right_2]
            
            let row = GenerateRows.generate_Row(sections: sections, centeredSection: section_center)
            
            let page = SkeletonPage(row: row)
            let pages = [page]
            
            let menuWidthWithSafeArea = 10_000
            let safeAreaLeft = Int.random(in: 0...75)
            let safeAreaRight = Int.random(in: 0...75)
            
            SkeletonLayoutExecutor.layout(pages: pages,
                                          menuWidthWithSafeArea: menuWidthWithSafeArea,
                                          safeAreaLeft: safeAreaLeft,
                                          safeAreaRight: safeAreaRight)
            let the_expected_x_of_section_center = (safeAreaLeft + (menuWidthWithSafeArea - safeAreaLeft - safeAreaRight) / 2 - section_center.width / 2)
            if !(the_expected_x_of_section_center == section_center.x) {
                print("The center section was not centered...")
                #expect(Bool(false))
                return
            }
            
        }
        
    }
    
    @Test func test_center_no_overlap() {
        
        for _ in 0..<4096 {
            
            let chunk_left_1 = GenerateChunks.generate_hero_long_10_flexer()
            let chunk_left_2 = GenerateChunks.generate_hero_long_10_flexer()
            
            let chunk_center_1 = GenerateChunks.generate_hero_long_10_flexer()
            let chunk_center_2 = GenerateChunks.generate_hero_long_10_flexer()
            
            let chunk_right_1 = GenerateChunks.generate_hero_long_10_flexer()
            let chunk_right_2 = GenerateChunks.generate_hero_long_10_flexer()
            
            let node_left_1 = GenerateNodes.generate_node(chunks: [chunk_left_1])
            let node_left_2 = GenerateNodes.generate_node(chunks: [chunk_left_2])
            
            let node_center_1 = GenerateNodes.generate_node(chunks: [chunk_center_1])
            let node_center_2 = GenerateNodes.generate_node(chunks: [chunk_center_2])
            
            let node_right_1 = GenerateNodes.generate_node(chunks: [chunk_right_1])
            let node_right_2 = GenerateNodes.generate_node(chunks: [chunk_right_2])
            
            let section_left = GenerateSections.generate_section(nodes: [node_left_1, node_left_2])
            
            let section_center = GenerateSections.generate_section(nodes: [node_center_1, node_center_2])
            
            let section_right_1 = GenerateSections.generate_section(node: node_right_1)
            let section_right_2 = GenerateSections.generate_section(node: node_right_2)
            
            let sections = [section_left, section_center, section_right_1, section_right_2]
            
            let row = GenerateRows.generate_Row(sections: sections, centeredSection: section_center)
            
            let page = SkeletonPage(row: row)
            let pages = [page]
            
            let menuWidthWithSafeArea = Int.random(in: 0...4096)
            let safeAreaLeft = Int.random(in: 0...75)
            let safeAreaRight = Int.random(in: 0...75)
            
            SkeletonLayoutExecutor.layout(pages: pages,
                                          menuWidthWithSafeArea: menuWidthWithSafeArea,
                                          safeAreaLeft: safeAreaLeft,
                                          safeAreaRight: safeAreaRight)
            
            if row.sectionsOverlap_test() {
                print("These sections should not overlap")
                #expect(Bool(false))
                return
            }
        }
        
    }
    
    @Test func test_center_no_overlap_more_variance() {
        for _ in 0..<4096 {
            let row = get_random_row()
            
            let page = SkeletonPage(row: row)
            let pages = [page]
            
            let menuWidthWithSafeArea = Int.random(in: 0...4096)
            let safeAreaLeft = Int.random(in: 0...75)
            let safeAreaRight = Int.random(in: 0...75)
            
            SkeletonLayoutExecutor.layout(pages: pages,
                                          menuWidthWithSafeArea: menuWidthWithSafeArea,
                                          safeAreaLeft: safeAreaLeft,
                                          safeAreaRight: safeAreaRight)
            
            if row.sectionsOverlap_test() {
                print("These sections should not overlap")
                #expect(Bool(false))
                return
            }
        }
        
    }
    
    @Test func test_center_valid_base() {
        
        for _ in 0..<4096 {
            
            let chunk_left_1 = GenerateChunks.generate_hero_long_10_flexer()
            let chunk_left_2 = GenerateChunks.generate_hero_long_10_flexer()
            
            let chunk_center_1 = GenerateChunks.generate_hero_long_10_flexer()
            let chunk_center_2 = GenerateChunks.generate_hero_long_10_flexer()
            
            let chunk_right_1 = GenerateChunks.generate_hero_long_10_flexer()
            let chunk_right_2 = GenerateChunks.generate_hero_long_10_flexer()
            
            let node_left_1 = GenerateNodes.generate_node(chunks: [chunk_left_1])
            let node_left_2 = GenerateNodes.generate_node(chunks: [chunk_left_2])
            
            let node_center_1 = GenerateNodes.generate_node(chunks: [chunk_center_1])
            let node_center_2 = GenerateNodes.generate_node(chunks: [chunk_center_2])
            
            let node_right_1 = GenerateNodes.generate_node(chunks: [chunk_right_1])
            let node_right_2 = GenerateNodes.generate_node(chunks: [chunk_right_2])
            
            let section_left = GenerateSections.generate_section(nodes: [node_left_1, node_left_2])
            
            let section_center = GenerateSections.generate_section(nodes: [node_center_1, node_center_2])
            
            let section_right_1 = GenerateSections.generate_section(node: node_right_1)
            let section_right_2 = GenerateSections.generate_section(node: node_right_2)
            
            let sections = [section_left, section_center, section_right_1, section_right_2]
            
            let row = GenerateRows.generate_Row(sections: sections, centeredSection: section_center)
            
            let page = SkeletonPage(row: row)
            let pages = [page]
            
            let menuWidthWithSafeArea = Int.random(in: 0...4096)
            let safeAreaLeft = Int.random(in: 0...75)
            let safeAreaRight = Int.random(in: 0...75)
            
            SkeletonLayoutExecutor.layout(pages: pages,
                                          menuWidthWithSafeArea: menuWidthWithSafeArea,
                                          safeAreaLeft: safeAreaLeft,
                                          safeAreaRight: safeAreaRight)
            
            if !row.sectionsLayoutValid_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                             safeAreaLeft: safeAreaLeft,
                                             safeAreaRight: safeAreaRight) {
                print("These sections should be valid...")
                #expect(Bool(false))
                return
            }
        }
        
    }
    
    @Test func test_center_valid_more_variance() {
        
        for _ in 0..<4096 {
            
            let row = get_random_row()
            
            let page = SkeletonPage(row: row)
            let pages = [page]
            
            let menuWidthWithSafeArea = Int.random(in: 0...4096)
            let safeAreaLeft = Int.random(in: 0...75)
            let safeAreaRight = Int.random(in: 0...75)
            
            SkeletonLayoutExecutor.layout(pages: pages,
                                          menuWidthWithSafeArea: menuWidthWithSafeArea,
                                          safeAreaLeft: safeAreaLeft,
                                          safeAreaRight: safeAreaRight)
            
            if !row.sectionsLayoutValid_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                             safeAreaLeft: safeAreaLeft,
                                             safeAreaRight: safeAreaRight) {
                print("These sections should be valid...")
                #expect(Bool(false))
                return
            }
        }
        
    }
    
    func get_random_pages_centered() -> [SkeletonPage] {
        var pages = [SkeletonPage]()
        let page_count = Int.random(in: 1...2)
        for _ in 0..<page_count {
            let row_count = Int.random(in: 1...2)
            var rows = [SkeletonRow]()
            for _ in 0..<row_count {
                let section_count = Int.random(in: 1...4)
                var sections: [SkeletonSection] = []
                for _ in 0..<section_count {
                    var nodes = [WiseLayoutNode]()
                    let node_count = Int.random(in: 1...4)
                    for _ in 0..<node_count {
                        let chunk_count = Int.random(in: 1...4)
                        var chunks = [SkeletonChunk]()
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
                let row = GenerateRows.generate_Row(sections: sections, centeredSection: sections.randomElement())
                rows.append(row)
            }
            let page = SkeletonPage(rows: rows)
            pages.append(page)
        }
        return pages
    }
    
    func get_random_pages() -> [SkeletonPage] {
        var pages = [SkeletonPage]()
        let page_count = Int.random(in: 1...2)
        for _ in 0..<page_count {
            let row_count = Int.random(in: 1...2)
            var rows = [SkeletonRow]()
            for _ in 0..<row_count {
                let section_count = Int.random(in: 1...4)
                var sections: [SkeletonSection] = []
                for _ in 0..<section_count {
                    var nodes = [WiseLayoutNode]()
                    let node_count = Int.random(in: 1...4)
                    for _ in 0..<node_count {
                        let chunk_count = Int.random(in: 1...4)
                        var chunks = [SkeletonChunk]()
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
                let row = GenerateRows.generate_Row(sections: sections)
                
                rows.append(row)
            }
            let page = SkeletonPage(rows: rows)
            pages.append(page)
        }
        return pages
    }
    
    func get_linkage_rule(pieces: [SkeletonPiece]) -> SkeletonLinkageRule_Pieces {
        return SkeletonLinkageRule_Pieces(pieces: pieces, layoutPriority: .required)
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
    
    func are_all_equal_to_largest(chunks: [SkeletonChunk]) -> Bool {
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
    
    @Test func test_centering_with_many_rules_large_sizes() {
        
        for _ in 0..<4096 {
            
            let pages: [SkeletonPage]
            if Bool.random() {
                pages = get_random_pages_centered()
            } else {
                pages = get_random_pages()
            }
            
            let menuWidthWithSafeArea = Int.random(in: 50_000...200_000)
            let safeAreaLeft = Int.random(in: 0...256)
            let safeAreaRight = Int.random(in: 0...256)
            
            let count_pieces = Int.random(in: 0...3)
            let count_flexers = Int.random(in: 0...3)
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            var links_pieces = [[SkeletonPiece]]()
            for _ in 0..<count_pieces {
                links_pieces.append(getRandomElements(input: all_pieces, count: Int.random(in: 1...5)))
            }
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            var links_flexers = [[Flexer]]()
            for _ in 0..<count_flexers {
                links_flexers.append(getRandomElements(input: all_flexers, count: Int.random(in: 1...5)))
            }
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRules = links_pieces.map { get_linkage_rule(pieces: $0) }
            let flexerRules = links_flexers.map { get_linkage_rule(flexers: $0) }
            
            SkeletonLayoutExecutor.layout(pages: pages,
                                          pieceRules: pieceRules,
                                          flexerRules: flexerRules,
                                          menuWidthWithSafeArea: menuWidthWithSafeArea,
                                          safeAreaLeft: safeAreaLeft,
                                          safeAreaRight: safeAreaRight)
            
            for links in links_flexers {
                if !are_all_equal_to_largest(flexers: links) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
            
            for links in links_pieces {
                if !are_all_equal_to_largest(pieces: links) {
                    print("piece linkage rule did not work.")
                    #expect(Bool(false))
                    return
                }
            }
            
            for page in pages {
                for row in page.rows {
                    if !row.sectionsLayoutValid_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                     safeAreaLeft: safeAreaLeft,
                                                     safeAreaRight: safeAreaRight) {
                        print("These sections should be valid...")
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    @Test func test_centering_with_many_rules_normal_sizes_cannot_enforce_all_rules() {
        
        for _ in 0..<4096 {
            
            let pages: [SkeletonPage]
            if Bool.random() {
                pages = get_random_pages_centered()
            } else {
                pages = get_random_pages()
            }
            
            let menuWidthWithSafeArea = Int.random(in: 0...2400)
            let safeAreaLeft = Int.random(in: 0...256)
            let safeAreaRight = Int.random(in: 0...256)
            
            let count_pieces = Int.random(in: 0...3)
            let count_flexers = Int.random(in: 0...3)
            let count_chunks = Int.random(in: 0...3)
            let count_nodes = Int.random(in: 0...3)
            let count_sections = Int.random(in: 0...3)
            
            let all_pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
            var links_pieces = [[SkeletonPiece]]()
            for _ in 0..<count_pieces {
                links_pieces.append(getRandomElements(input: all_pieces, count: Int.random(in: 1...5)))
            }
            
            let all_flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
            var links_flexers = [[Flexer]]()
            for _ in 0..<count_flexers {
                links_flexers.append(getRandomElements(input: all_flexers, count: Int.random(in: 1...5)))
            }
            
            let all_chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
            let all_nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
            let all_sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
            
            SkeletonLayoutExecutor.prepare_and_snap_minimum(pages: pages,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            
            let pieceRules = links_pieces.map { get_linkage_rule(pieces: $0) }
            let flexerRules = links_flexers.map { get_linkage_rule(flexers: $0) }
            SkeletonLayoutExecutor.layout(pages: pages,
                                          pieceRules: pieceRules,
                                          flexerRules: flexerRules,
                                          menuWidthWithSafeArea: menuWidthWithSafeArea,
                                          safeAreaLeft: safeAreaLeft,
                                          safeAreaRight: safeAreaRight)
            
            
            for page in pages {
                for row in page.rows {
                    if !row.sectionsLayoutValid_test(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                     safeAreaLeft: safeAreaLeft,
                                                     safeAreaRight: safeAreaRight) {
                        print("These sections should be valid...")
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
}
