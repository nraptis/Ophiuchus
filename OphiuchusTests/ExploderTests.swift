//
//  ExploderTests_Combinatorics.swift
//  OphiuchusTests
//
//  Created by Nick on 7/4/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct ExploderTests {
    
    @Test func test_sections_partitions_five_links() {
        for _ in 0..<8092 {
            
            let a = SkeletonSection(id: 0, layoutNodes: [], alignment: .left)
            let b = SkeletonSection(id: 1, layoutNodes: [], alignment: .left)
            let c = SkeletonSection(id: 2, layoutNodes: [], alignment: .left)
            let d = SkeletonSection(id: 3, layoutNodes: [], alignment: .left)
            let e = SkeletonSection(id: 4, layoutNodes: [], alignment: .left)
            
            var original_list = [a, b, c, d, e]
            original_list.shuffle()
            
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                var rules = [SkeletonLinkageRule_Sections]()
                var all_sections = [SkeletonSection]()
                for sections in partition {
                    let rule = SkeletonLinkageRule_Sections(sections: sections, layoutPriority: .required)
                    rules.append(rule)
                    all_sections.append(contentsOf: sections)
                }
                let row = SkeletonRow(sections: all_sections, attemptedCenteredSection: nil)
                let page = SkeletonPage(rows: [row])
                let result = SkeletonLayoutExecutor.getSectionGroups_Unsafe(pages: [page],
                                                                            rules: rules)
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                for group in result {
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for sections in partition {
                        let section_ids = Set(sections.map { $0.id })
                        if section_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
                
                for group in result {
                    for section in group.linkedList {
                        if section.group_unsafe !== group {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
                
                for section in all_sections {
                    if section.group_unsafe === nil {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    @Test func test_pieces_partitions_five_links() {
        for _ in 0..<8092 {
            let a = GeneratePieces.generate_piece(size: 10)
            let b = GeneratePieces.generate_piece(size: 10)
            let c = GeneratePieces.generate_piece(size: 10)
            let d = GeneratePieces.generate_piece(size: 10)
            let e = GeneratePieces.generate_piece(size: 10)
            var original_list = [a, b, c, d, e]
            original_list.shuffle()
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                var rules = [SkeletonLinkageRule_Pieces]()
                for pieces in partition {
                    let rule = SkeletonLinkageRule_Pieces(pieces: pieces, layoutPriority: .required)
                    rules.append(rule)
                }
                var chunks = [SkeletonChunkFixed]()
                for pieces in partition {
                    var chunk_id = 0
                    for piece in pieces {
                        let chunk = SkeletonChunkFixed(id: chunk_id,
                                                       chunkIdentifier: .unknown,
                                                       piece: piece, alignment: .center)
                        chunk_id += 1
                        chunks.append(chunk)
                    }
                }
                let node = GenerateNodes.generate_node(chunks: chunks)
                let section = SkeletonSection(id: 0, layoutNodes: [node], alignment: .left)
                section.adopt_test()
                let row = SkeletonRow(sections: [section], attemptedCenteredSection: nil)
                let page = SkeletonPage(rows: [row])
                let result = SkeletonLayoutExecutor.getPieceGroups_Unsafe(pages: [page],
                                                                          rules: rules)
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                for group in result {
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for pieces in partition {
                        let piece_ids = Set(pieces.map { $0.id })
                        if piece_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
                
                for group in result {
                    for piece in group.linkedList {
                        if piece.group_unsafe !== group {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
                
                for chunk in chunks {
                    for piece in chunk.pieces {
                        
                        if piece.group_unsafe === nil {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
    }
    
    @Test func test_flexers_partitions_five_links_redundant() {
        
        for _ in 0..<8092 {
            let a = GenerateFlexers.generate_10_random_climb()
            let b = GenerateFlexers.generate_10_random_climb()
            let c = GenerateFlexers.generate_10_random_climb()
            let d = GenerateFlexers.generate_10_random_climb()
            let e = GenerateFlexers.generate_10_random_climb()
            var original_list = [a, b, c, d, e]
            original_list.shuffle()
            
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                
                var links = [ExploderLink]()
                for flexers in partition {
                    let rule = SkeletonLinkageRule_Flexers(flexers: flexers, layoutPriority: .required)
                    let sublinks = rule.getLinks_Redundant()
                    links.append(contentsOf: sublinks)
                }
                
                let result = Exploder.explode(nodes: original_list, links: links)
                
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                
                for group in result {
                    
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for flexers in partition {
                        let flexer_ids = Set(flexers.map { $0.id })
                        if flexer_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    @Test func test_chunks_partitions_five_links_redundant() {
        
        for _ in 0..<8092 {
            let a = GenerateChunks.generate_fixed()
            let b = GenerateChunks.generate_fixed()
            let c = GenerateChunks.generate_fixed()
            let d = GenerateChunks.generate_fixed()
            let e = GenerateChunks.generate_fixed()
            var original_list = [a, b, c, d, e]
            original_list.shuffle()
            
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                
                var links = [ExploderLink]()
                for chunks in partition {
                    let rule = SkeletonLinkageRule_Chunks(chunks: chunks, layoutPriority: .required)
                    let sublinks = rule.getLinks_Redundant()
                    links.append(contentsOf: sublinks)
                }
                
                let result = Exploder.explode(nodes: original_list, links: links)
                
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                
                for group in result {
                    
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for chunks in partition {
                        let chunk_ids = Set(chunks.map { $0.id })
                        if chunk_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    
    @Test func test_chunks_partitions_five_links_minimal() {
        
        for _ in 0..<8092 {
            let a = GenerateChunks.generate_fixed()
            let b = GenerateChunks.generate_fixed()
            let c = GenerateChunks.generate_fixed()
            let d = GenerateChunks.generate_fixed()
            let e = GenerateChunks.generate_fixed()
            var original_list = [a, b, c, d, e]
            original_list.shuffle()
            
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                
                var links = [ExploderLink]()
                for chunks in partition {
                    let rule = SkeletonLinkageRule_Chunks(chunks: chunks, layoutPriority: .required)
                    let sublinks = rule.getLinks()
                    links.append(contentsOf: sublinks)
                }
                
                let result = Exploder.explode(nodes: original_list, links: links)
                
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                
                for group in result {
                    
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for chunks in partition {
                        let chunk_ids = Set(chunks.map { $0.id })
                        if chunk_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    
    @Test func test_pieces_partitions_five_links_redundant() {
        
        for _ in 0..<8092 {
            let a = GeneratePieces.generate_piece(size: 10)
            let b = GeneratePieces.generate_piece(size: 10)
            let c = GeneratePieces.generate_piece(size: 10)
            let d = GeneratePieces.generate_piece(size: 10)
            let e = GeneratePieces.generate_piece(size: 10)
            var original_list = [a, b, c, d, e]
            original_list.shuffle()
            
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                
                var links = [ExploderLink]()
                for pieces in partition {
                    let rule = SkeletonLinkageRule_Pieces(pieces: pieces, layoutPriority: .required)
                    let sublinks = rule.getLinks_Redundant()
                    links.append(contentsOf: sublinks)
                }
                
                let result = Exploder.explode(nodes: original_list, links: links)
                
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                
                for group in result {
                    
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for pieces in partition {
                        let piece_ids = Set(pieces.map { $0.id })
                        if piece_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    
    @Test func test_pieces_partitions_five_links_minimal() {
        
        for _ in 0..<8092 {
            let a = GeneratePieces.generate_piece(size: 10)
            let b = GeneratePieces.generate_piece(size: 10)
            let c = GeneratePieces.generate_piece(size: 10)
            let d = GeneratePieces.generate_piece(size: 10)
            let e = GeneratePieces.generate_piece(size: 10)
            var original_list = [a, b, c, d, e]
            
            original_list.shuffle()
            
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                
                var links = [ExploderLink]()
                for pieces in partition {
                    let rule = SkeletonLinkageRule_Pieces(pieces: pieces, layoutPriority: .required)
                    let sublinks = rule.getLinks()
                    links.append(contentsOf: sublinks)
                }
                
                let result = Exploder.explode(nodes: original_list, links: links)
                
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                
                for group in result {
                    
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for pieces in partition {
                        let piece_ids = Set(pieces.map { $0.id })
                        if piece_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    @Test func test_sections_partitions_five_links_redundant() {
        
        for _ in 0..<8092 {
            let a = SkeletonSection(id: 0, layoutNodes: [], alignment: .left)
            let b = SkeletonSection(id: 1, layoutNodes: [], alignment: .left)
            let c = SkeletonSection(id: 2, layoutNodes: [], alignment: .left)
            let d = SkeletonSection(id: 3, layoutNodes: [], alignment: .left)
            let e = SkeletonSection(id: 4, layoutNodes: [], alignment: .left)
            var original_list = [a, b, c, d, e]
            original_list.shuffle()
            
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                
                var links = [ExploderLink]()
                for sections in partition {
                    let rule = SkeletonLinkageRule_Sections(sections: sections, layoutPriority: .required)
                    let sublinks = rule.getLinks_Redundant()
                    links.append(contentsOf: sublinks)
                }
                
                let result = Exploder.explode(nodes: original_list, links: links)
                
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                
                for group in result {
                    
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for sections in partition {
                        let section_ids = Set(sections.map { $0.id })
                        if section_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    
    @Test func test_sections_partitions_five_links_minimal() {
        
        for _ in 0..<8092 {
            let a = SkeletonSection(id: 0, layoutNodes: [], alignment: .left)
            let b = SkeletonSection(id: 1, layoutNodes: [], alignment: .left)
            let c = SkeletonSection(id: 2, layoutNodes: [], alignment: .left)
            let d = SkeletonSection(id: 3, layoutNodes: [], alignment: .left)
            let e = SkeletonSection(id: 4, layoutNodes: [], alignment: .left)
            var original_list = [a, b, c, d, e]
            original_list.shuffle()
            
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                
                var links = [ExploderLink]()
                for sections in partition {
                    let rule = SkeletonLinkageRule_Sections(sections: sections, layoutPriority: .required)
                    let sublinks = rule.getLinks()
                    links.append(contentsOf: sublinks)
                }
                
                let result = Exploder.explode(nodes: original_list, links: links)
                
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                
                for group in result {
                    
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for sections in partition {
                        let section_ids = Set(sections.map { $0.id })
                        if section_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    @Test func test_chunks_partitions_five_links() {
        for _ in 0..<8092 {
            let a = GenerateChunks.generate_fixed()
            let b = GenerateChunks.generate_fixed()
            let c = GenerateChunks.generate_fixed()
            let d = GenerateChunks.generate_fixed()
            let e = GenerateChunks.generate_fixed()
            var original_list = [a, b, c, d, e]
            original_list.shuffle()
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                var rules = [SkeletonLinkageRule_Chunks]()
                var all_chunks = [any SkeletonChunkConforming]()
                for chunks in partition {
                    let rule = SkeletonLinkageRule_Chunks(chunks: chunks, layoutPriority: .required)
                    rules.append(rule)
                    all_chunks.append(contentsOf: chunks)
                }
                let node = GenerateNodes.generate_node(chunks: all_chunks)
                let section = SkeletonSection(id: 0, layoutNodes: [node], alignment: .left)
                section.adopt_test()
                let row = SkeletonRow(sections: [section], attemptedCenteredSection: nil)
                let page = SkeletonPage(rows: [row])
                let result = SkeletonLayoutExecutor.getChunkGroups_Unsafe(pages: [page],
                                                                          rules: rules)
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                for group in result {
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for chunks in partition {
                        let chunk_ids = Set(chunks.map { $0.id })
                        if chunk_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
                
                for group in result {
                    for chunk in group.linkedList {
                        if chunk.group_unsafe !== group {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
                
                for chunk in all_chunks {
                    if chunk.group_unsafe === nil {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    
   
    
    
    
    
    @Test func test_chunks_partitions_redundant() {
        
        var checked = 0
        for _ in 0..<2048 {
            
            for count in 1...8 {
                
                var original_list = [SkeletonChunkFixed]()
                for id in 0..<count {
                    let piece = SkeletonPiece(id: id, pieceIdentifier: .unknown, size: 10)
                    let chunk = SkeletonChunkFixed(id: id, chunkIdentifier: .unknown, piece: piece, alignment: .center)
                    original_list.append(chunk)
                }
                
                original_list.shuffle()
                
                let partitions = getAllPartitions(original_list)
                for partition in partitions {
                    
                    var links = [ExploderLink]()
                    for chunks in partition {
                        let rule = SkeletonLinkageRule_Chunks(chunks: chunks, layoutPriority: .required)
                        let sublinks = rule.getLinks_Redundant()
                        links.append(contentsOf: sublinks)
                    }
                    
                    links.shuffle()
                    
                    let result = Exploder.explode(nodes: original_list, links: links)
                    
                    if !(result.count == partition.count) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for group in result {
                        
                        let group_ids = Set(group.linkedList.map(\.id))
                        var isFound = false
                        for chunks in partition {
                            let chunk_ids = Set(chunks.map { $0.id })
                            if chunk_ids == group_ids {
                                isFound = true
                            }
                            checked += 1
                        }
                        if !isFound {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
        print("Done! Checked \(checked) Matches!!! (test_chunks_partitions_redundant)")
    }
    
    @Test func test_chunks_partitions_minimal() {
        
        var checked = 0
        for _ in 0..<2048 {
            
            for count in 1...8 {
                
                var original_list = [SkeletonChunkFixed]()
                for id in 0..<count {
                    let piece = SkeletonPiece(id: id, pieceIdentifier: .unknown, size: 10)
                    let chunk = SkeletonChunkFixed(id: id, chunkIdentifier: .unknown, piece: piece, alignment: .center)
                    original_list.append(chunk)
                }
                
                original_list.shuffle()
                
                let partitions = getAllPartitions(original_list)
                for partition in partitions {
                    
                    var links = [ExploderLink]()
                    for chunks in partition {
                        let rule = SkeletonLinkageRule_Chunks(chunks: chunks, layoutPriority: .required)
                        let sublinks = rule.getLinks()
                        links.append(contentsOf: sublinks)
                    }
                    
                    links.shuffle()
                    
                    let result = Exploder.explode(nodes: original_list, links: links)
                    
                    if !(result.count == partition.count) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for group in result {
                        
                        let group_ids = Set(group.linkedList.map(\.id))
                        var isFound = false
                        for chunks in partition {
                            let chunk_ids = Set(chunks.map { $0.id })
                            if chunk_ids == group_ids {
                                isFound = true
                            }
                            checked += 1
                        }
                        if !isFound {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
        print("Done! Checked \(checked) Matches!!! (test_chunks_partitions_minimal)")
    }
    
    @Test func test_pieces_partitions_redundant() {
        var checked = 0
        for _ in 0..<2048 {
            for count in 1...8 {
                var original_list = [SkeletonPiece]()
                for id in 0..<count {
                    let piece = SkeletonPiece(id: id, pieceIdentifier: .unknown, size: 10)
                    original_list.append(piece)
                }
                
                original_list.shuffle()
                
                let partitions = getAllPartitions(original_list)
                for partition in partitions {
                    
                    var links = [ExploderLink]()
                    for pieces in partition {
                        let rule = SkeletonLinkageRule_Pieces(pieces: pieces, layoutPriority: .required)
                        let sublinks = rule.getLinks_Redundant()
                        links.append(contentsOf: sublinks)
                    }
                    
                    links.shuffle()
                    
                    let result = Exploder.explode(nodes: original_list, links: links)
                    
                    if !(result.count == partition.count) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for group in result {
                        
                        let group_ids = Set(group.linkedList.map(\.id))
                        var isFound = false
                        for pieces in partition {
                            let piece_ids = Set(pieces.map { $0.id })
                            if piece_ids == group_ids {
                                isFound = true
                            }
                            checked += 1
                        }
                        if !isFound {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
        print("Done! Checked \(checked) Matches!!! (test_pieces_partitions_redundant)")
    }
    
    
    @Test func test_pieces_partitions_minimal() {
        
        var checked = 0
        for _ in 0..<2048 {
            for count in 1...8 {
                var original_list = [SkeletonPiece]()
                for id in 0..<count {
                    let piece = SkeletonPiece(id: id, pieceIdentifier: .unknown, size: 10)
                    original_list.append(piece)
                }
                
                original_list.shuffle()
                
                let partitions = getAllPartitions(original_list)
                for partition in partitions {
                    
                    var links = [ExploderLink]()
                    for pieces in partition {
                        let rule = SkeletonLinkageRule_Pieces(pieces: pieces, layoutPriority: .required)
                        let sublinks = rule.getLinks()
                        links.append(contentsOf: sublinks)
                    }
                    
                    links.shuffle()
                    
                    let result = Exploder.explode(nodes: original_list, links: links)
                    
                    if !(result.count == partition.count) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for group in result {
                        
                        let group_ids = Set(group.linkedList.map(\.id))
                        var isFound = false
                        for pieces in partition {
                            let piece_ids = Set(pieces.map { $0.id })
                            if piece_ids == group_ids {
                                isFound = true
                            }
                            checked += 1
                        }
                        if !isFound {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
        print("Done! Checked \(checked) Matches!!! (test_pieces_partitions_minimal)")
    }
    
    @Test func test_sections_partitions_redundant() {
        
        var checked = 0
        for _ in 0..<2048 {
            for count in 1...8 {
                var original_list = [SkeletonSection]()
                for id in 0..<count {
                    let section = SkeletonSection(id: id, layoutNodes: [], alignment: .left)
                    original_list.append(section)
                }
                
                original_list.shuffle()
                
                let partitions = getAllPartitions(original_list)
                for partition in partitions {
                    
                    var links = [ExploderLink]()
                    for sections in partition {
                        let rule = SkeletonLinkageRule_Sections(sections: sections, layoutPriority: .required)
                        let sublinks = rule.getLinks_Redundant()
                        links.append(contentsOf: sublinks)
                    }
                    
                    links.shuffle()
                    
                    let result = Exploder.explode(nodes: original_list, links: links)
                    
                    if !(result.count == partition.count) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for group in result {
                        
                        let group_ids = Set(group.linkedList.map(\.id))
                        var isFound = false
                        for sections in partition {
                            let section_ids = Set(sections.map { $0.id })
                            if section_ids == group_ids {
                                isFound = true
                            }
                            checked += 1
                        }
                        if !isFound {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
        print("Done! Checked \(checked) Matches!!! (test_sections_partitions_redundant)")
    }
    
    @Test func test_sections_partitions_minimal() {
        
        var checked = 0
        for _ in 0..<2048 {
            for count in 1...8 {
                var original_list = [SkeletonSection]()
                for id in 0..<count {
                    let section = SkeletonSection(id: id, layoutNodes: [], alignment: .left)
                    original_list.append(section)
                }
                
                original_list.shuffle()
                
                let partitions = getAllPartitions(original_list)
                for partition in partitions {
                    
                    var links = [ExploderLink]()
                    for sections in partition {
                        let rule = SkeletonLinkageRule_Sections(sections: sections, layoutPriority: .required)
                        let sublinks = rule.getLinks()
                        links.append(contentsOf: sublinks)
                    }
                    
                    links.shuffle()
                    
                    let result = Exploder.explode(nodes: original_list, links: links)
                    
                    if !(result.count == partition.count) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for group in result {
                        
                        let group_ids = Set(group.linkedList.map(\.id))
                        var isFound = false
                        for sections in partition {
                            let section_ids = Set(sections.map { $0.id })
                            if section_ids == group_ids {
                                isFound = true
                            }
                            checked += 1
                        }
                        if !isFound {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
        print("Done! Checked \(checked) Matches!!! (test_sections_partitions_minimal)")
    }
    
    @Test func test_chunks_partitions() {
        var checked = 0
        for _ in 0..<2048 {
            for count in 1...8 {
                var original_list = [SkeletonChunkFixed]()
                for id in 0..<count {
                    let piece = SkeletonPiece(id: id, pieceIdentifier: .unknown, size: 10)
                    let chunk = SkeletonChunkFixed(id: id, chunkIdentifier: .unknown, piece: piece, alignment: .center)
                    original_list.append(chunk)
                }
                
                original_list.shuffle()
                
                let partitions = getAllPartitions(original_list)
                for partition in partitions {
                    
                    var rules = [SkeletonLinkageRule_Chunks]()
                    var all_chunks = [any SkeletonChunkConforming]()
                    for chunks in partition {
                        let rule = SkeletonLinkageRule_Chunks(chunks: chunks, layoutPriority: .required)
                        rules.append(rule)
                        all_chunks.append(contentsOf: chunks)
                    }
                    let node = GenerateNodes.generate_node(chunks: all_chunks)
                    let section = SkeletonSection(id: 0, layoutNodes: [node], alignment: .left)
                    section.adopt_test()
                    let row = SkeletonRow(sections: [section], attemptedCenteredSection: nil)
                    let page = SkeletonPage(rows: [row])
                    let result = SkeletonLayoutExecutor.getChunkGroups_Unsafe(pages: [page],
                                                                              rules: rules)
                    
                    if !(result.count == partition.count) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for group in result {
                        let group_ids = Set(group.linkedList.map(\.id))
                        var isFound = false
                        for chunks in partition {
                            let chunk_ids = Set(chunks.map { $0.id })
                            if chunk_ids == group_ids {
                                isFound = true
                            }
                            checked += 1
                        }
                        if !isFound {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
        print("Done! Checked \(checked) Matches!!! (test_chunks_partitions)")
    }
    
    @Test func test_pieces_partitions() {
        var checked = 0
        for _ in 0..<2048 {
            for count in 1...8 {
                var original_list = [SkeletonPiece]()
                for id in 0..<count {
                    let piece = SkeletonPiece(id: id, pieceIdentifier: .unknown, size: 10)
                    original_list.append(piece)
                }
                
                original_list.shuffle()
                
                let partitions = getAllPartitions(original_list)
                for partition in partitions {
                    
                    var rules = [SkeletonLinkageRule_Pieces]()
                    for pieces in partition {
                        let rule = SkeletonLinkageRule_Pieces(pieces: pieces, layoutPriority: .required)
                        rules.append(rule)
                    }
                    var chunks = [SkeletonChunkFixed]()
                    for pieces in partition {
                        var chunk_id = 0
                        for piece in pieces {
                            let chunk = SkeletonChunkFixed(id: chunk_id, chunkIdentifier: .unknown, piece: piece, alignment: .center)
                            chunk_id += 1
                            chunks.append(chunk)
                        }
                    }
                    let node = GenerateNodes.generate_node(chunks: chunks)
                    let section = SkeletonSection(id: 0, layoutNodes: [node], alignment: .left)
                    section.adopt_test()
                    let row = SkeletonRow(sections: [section], attemptedCenteredSection: nil)
                    let page = SkeletonPage(rows: [row])
                    let result = SkeletonLayoutExecutor.getPieceGroups_Unsafe(pages: [page],
                                                                              rules: rules)
                    
                    if !(result.count == partition.count) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for group in result {
                        let group_ids = Set(group.linkedList.map(\.id))
                        var isFound = false
                        for pieces in partition {
                            let piece_ids = Set(pieces.map { $0.id })
                            if piece_ids == group_ids {
                                isFound = true
                            }
                            checked += 1
                        }
                        if !isFound {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
        print("Done! Checked \(checked) Matches!!! (test_pieces_partitions)")
    }
    
    @Test func test_sections_partitions() {
        
        var checked = 0
        for _ in 0..<2048 {
            for count in 1...8 {
                var original_list = [SkeletonSection]()
                for id in 0..<count {
                    let section = SkeletonSection(id: id, layoutNodes: [], alignment: .left)
                    original_list.append(section)
                }
                
                original_list.shuffle()
                
                let partitions = getAllPartitions(original_list)
                for partition in partitions {
                    
                    var rules = [SkeletonLinkageRule_Sections]()
                    var all_sections = [SkeletonSection]()
                    for sections in partition {
                        let rule = SkeletonLinkageRule_Sections(sections: sections, layoutPriority: .required)
                        rules.append(rule)
                        all_sections.append(contentsOf: sections)
                    }
                    let row = SkeletonRow(sections: all_sections, attemptedCenteredSection: nil)
                    let page = SkeletonPage(rows: [row])
                    let result = SkeletonLayoutExecutor.getSectionGroups_Unsafe(pages: [page],
                                                                                rules: rules)
                    
                    if !(result.count == partition.count) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for group in result {
                        let group_ids = Set(group.linkedList.map(\.id))
                        var isFound = false
                        for sections in partition {
                            let section_ids = Set(sections.map { $0.id })
                            if section_ids == group_ids {
                                isFound = true
                            }
                            checked += 1
                        }
                        if !isFound {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
        print("Done! Checked \(checked) Matches!!! (test_sections_partitions)")
    }
     
    @Test func test_flexers_partitions() {
        var checked = 0
        for _ in 0..<2048 {
            for count in 1...8 {
                var original_list = [Flexer]()
                for id in 0..<count {
                    let flexer = GenerateFlexers.generate_10_random_climb()
                    original_list.append(flexer)
                }
                
                original_list.shuffle()
                
                let partitions = getAllPartitions(original_list)
                for partition in partitions {
                    
                    var rules = [SkeletonLinkageRule_Flexers]()
                    for flexers in partition {
                        let rule = SkeletonLinkageRule_Flexers(flexers: flexers, layoutPriority: .required)
                        rules.append(rule)
                    }
                    var chunks = [SkeletonChunkFlexer]()
                    for flexers in partition {
                        var chunk_id = 0
                        for flexer in flexers {
                            let chunk = SkeletonChunkFlexer(id: chunk_id, chunkIdentifier: .unknown, flexer: flexer, alignment: .center)
                            chunk_id += 1
                            chunks.append(chunk)
                        }
                    }
                    let node = GenerateNodes.generate_node(chunks: chunks)
                    let section = SkeletonSection(id: 0, layoutNodes: [node], alignment: .left)
                    section.adopt_test()
                    let row = SkeletonRow(sections: [section], attemptedCenteredSection: nil)
                    let page = SkeletonPage(rows: [row])
                    let result = SkeletonLayoutExecutor.getFlexerGroups_Unsafe(pages: [page],
                                                                               rules: rules)
                    
                    if !(result.count == partition.count) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for group in result {
                        let group_ids = Set(group.linkedList.map(\.id))
                        var isFound = false
                        for flexers in partition {
                            let flexer_ids = Set(flexers.map { $0.id })
                            if flexer_ids == group_ids {
                                isFound = true
                            }
                            checked += 1
                        }
                        if !isFound {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
        print("Done! Checked \(checked) Matches!!! (test_flexers_partitions)")
    }
    
    @Test func test_flexers_partitions_minimal() {
        
        var checked = 0
        for _ in 0..<2048 {
            for count in 1...8 {
                var original_list = [Flexer]()
                for _ in 0..<count {
                    let flexer = GenerateFlexers.generate_10_random_climb()
                    original_list.append(flexer)
                }
                
                original_list.shuffle()
                
                let partitions = getAllPartitions(original_list)
                for partition in partitions {
                    
                    var links = [ExploderLink]()
                    for flexers in partition {
                        let rule = SkeletonLinkageRule_Flexers(flexers: flexers, layoutPriority: .required)
                        let sublinks = rule.getLinks()
                        links.append(contentsOf: sublinks)
                    }
                    
                    links.shuffle()
                    
                    let result = Exploder.explode(nodes: original_list, links: links)
                    
                    if !(result.count == partition.count) {
                        #expect(Bool(false))
                        return
                    }
                    
                    for group in result {
                        
                        let group_ids = Set(group.linkedList.map(\.id))
                        var isFound = false
                        for flexers in partition {
                            let flexer_ids = Set(flexers.map { $0.id })
                            if flexer_ids == group_ids {
                                isFound = true
                            }
                            checked += 1
                        }
                        if !isFound {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
        print("Done! Checked \(checked) Matches!!! (test_flexers_partitions_minimal)")
    }
    
    @Test func test_flexers_partitions_five_links() {
        for _ in 0..<8092 {
            let a = GenerateFlexers.generate_10_random_climb()
            let b = GenerateFlexers.generate_10_random_climb()
            let c = GenerateFlexers.generate_10_random_climb()
            let d = GenerateFlexers.generate_10_random_climb()
            let e = GenerateFlexers.generate_10_random_climb()
            var original_list = [a, b, c, d, e]
            original_list.shuffle()
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                var rules = [SkeletonLinkageRule_Flexers]()
                for flexers in partition {
                    let rule = SkeletonLinkageRule_Flexers(flexers: flexers, layoutPriority: .required)
                    rules.append(rule)
                }
                var chunks = [SkeletonChunkFlexer]()
                for flexers in partition {
                    var chunk_id = 0
                    for flexer in flexers {
                        let chunk = SkeletonChunkFlexer(id: chunk_id,
                                                        chunkIdentifier: .unknown,
                                                        flexer: flexer, alignment: .center)
                        chunk_id += 1
                        chunks.append(chunk)
                    }
                }
                let node = GenerateNodes.generate_node(chunks: chunks)
                let section = SkeletonSection(id: 0, layoutNodes: [node], alignment: .left)
                section.adopt_test()
                let row = SkeletonRow(sections: [section], attemptedCenteredSection: nil)
                let page = SkeletonPage(rows: [row])
                let result = SkeletonLayoutExecutor.getFlexerGroups_Unsafe(pages: [page],
                                                                           rules: rules)
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                for group in result {
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for flexers in partition {
                        let flexer_ids = Set(flexers.map { $0.id })
                        if flexer_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
                
                for group in result {
                    for flexer in group.linkedList {
                        if flexer.group_unsafe !== group {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
                
                for chunk in chunks {
                    for flexer in chunk.flexers {
                        
                        if flexer.group_unsafe === nil {
                            #expect(Bool(false))
                            return
                        }
                    }
                }
            }
        }
    }
    
    @Test func test_flexers_partitions_five_links_minimal() {
        
        for _ in 0..<8092 {
            let a = GenerateFlexers.generate_10_random_climb()
            let b = GenerateFlexers.generate_10_random_climb()
            let c = GenerateFlexers.generate_10_random_climb()
            let d = GenerateFlexers.generate_10_random_climb()
            let e = GenerateFlexers.generate_10_random_climb()
            var original_list = [a, b, c, d, e]
            
            original_list.shuffle()
            
            let partitions = getAllPartitions(original_list)
            for partition in partitions {
                
                var links = [ExploderLink]()
                for flexers in partition {
                    let rule = SkeletonLinkageRule_Flexers(flexers: flexers, layoutPriority: .required)
                    let sublinks = rule.getLinks()
                    links.append(contentsOf: sublinks)
                }
                
                let result = Exploder.explode(nodes: original_list, links: links)
                
                if !(result.count == partition.count) {
                    #expect(Bool(false))
                    return
                }
                
                for group in result {
                    
                    let group_ids = Set(group.linkedList.map(\.id))
                    var isFound = false
                    for flexers in partition {
                        let flexer_ids = Set(flexers.map { $0.id })
                        if flexer_ids == group_ids {
                            isFound = true
                        }
                    }
                    if !isFound {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    
    
    
}
