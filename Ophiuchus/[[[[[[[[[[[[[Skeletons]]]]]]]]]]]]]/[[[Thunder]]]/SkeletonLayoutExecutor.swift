//
//  ThunderExecutor.swift
//  Ophiuchus
//
//  Created by Nick on 7/5/25.
//

import Foundation

public struct SkeletonLayoutExecutor {
    
    // Row[ Section[ Chunk[] Chunk[Piece]] Section[ Chunk[Piece, Piece], Chunk[Piece]]]
    public static func prepare_and_snap_minimum(pages: [SkeletonPage],
                                                menuWidthWithSafeArea: Int,
                                                safeAreaLeft: Int,
                                                safeAreaRight: Int) {
        
        for page in pages {
            page.prepare(menuWidthWithSafeArea: menuWidthWithSafeArea,
                         safeAreaLeft: safeAreaLeft,
                         safeAreaRight: safeAreaRight)
        }
        
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    for node in section.skeletonNodes {
                        for chunk in node.chunks {
                            for piece in chunk.pieces {
                                piece.current_size = piece.original_size
                            }
                            for flexer in chunk.flexers {
                                flexer.current_size = 0
                            }
                        }
                    }
                }
            }
        }
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    var section_sum = 0
                    for node in section.skeletonNodes {
                        var node_sum = 0
                        for chunk in node.chunks {
                            var chunk_sum = 0
                            for piece in chunk.pieces {
                                chunk_sum += piece.current_size
                            }
                            chunk.current_size = chunk_sum
                            chunk.children_size = chunk_sum
                            node_sum += chunk_sum
                        }
                        node.current_size = node_sum
                        node.children_size = node_sum
                        section_sum += node_sum
                    }
                    section.current_size = section_sum
                    section.children_size = section_sum
                }
            }
        }
        for page in pages {
            for row in page.rows {
                row.snap_minimum_after_children_ready(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                      safeAreaLeft: safeAreaLeft,
                                                      safeAreaRight: safeAreaRight)
            }
        }
    }
    
    static func getAllSections(pages: [SkeletonPage]) -> [SkeletonSection] {
        var result = [SkeletonSection]()
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    result.append(section)
                }
            }
        }
        return result
    }
    
    static func getAllNodes(pages: [SkeletonPage]) -> [SkeletonNode] {
        var result = [SkeletonNode]()
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    for node in section.skeletonNodes {
                        result.append(node)
                    }
                }
            }
        }
        return result
    }
    
    static func getAllChunks(pages: [SkeletonPage]) -> [any SkeletonChunkConforming] {
        var result = [any SkeletonChunkConforming]()
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    for node in section.skeletonNodes {
                        for chunk in node.chunks {
                            result.append(chunk)
                        }
                    }
                }
            }
        }
        return result
    }
    
    static func getAllPieces(pages: [SkeletonPage]) -> [SkeletonPiece] {
        var result = [SkeletonPiece]()
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    for node in section.skeletonNodes {
                        for chunk in node.chunks {
                            for piece in chunk.pieces {
                                result.append(piece)
                            }
                        }
                    }
                }
            }
        }
        return result
    }
    
    static func getAllFlexers(pages: [SkeletonPage]) -> [Flexer] {
        var result = [Flexer]()
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    for node in section.skeletonNodes {
                        for chunk in node.chunks {
                            for flexer in chunk.flexers {
                                result.append(flexer)
                            }
                        }
                    }
                }
            }
        }
        return result
    }
    
    public static func getPieceGroups_Unsafe(pages: [SkeletonPage],
                                             rules: [SkeletonLinkageRule_Pieces]) -> [ExploderGroup<SkeletonPiece>] {
        let pieces = getAllPieces(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = Exploder.explode(nodes: pieces, links: links)
        
        for group in result {
            for piece in group.linkedList {
                piece.group_unsafe = group
            }
        }
        
        return result
    }
    
    public static func getFlexerGroups_Unsafe(pages: [SkeletonPage],
                                              rules: [SkeletonLinkageRule_Flexers]) -> [ExploderGroup<Flexer>] {
        let flexers = getAllFlexers(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = Exploder.explode(nodes: flexers, links: links)
        
        for group in result {
            for flexer in group.linkedList {
                flexer.group_unsafe = group
            }
        }
        
        return result
    }
    
    public static func getChunkGroups_Unsafe(pages: [SkeletonPage],
                                             rules: [SkeletonLinkageRule_Chunks]) -> [ExploderGroupChunks] {
        let chunks = getAllChunks(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = ExploderChunks.explode(nodes: chunks, links: links)
        
        for group in result {
            for node in group.linkedList {
                node.group_unsafe = group
            }
        }
        
        return result
    }
    
    public static func getNodeGroups_Unsafe(pages: [SkeletonPage],
                                            rules: [SkeletonLinkageRule_Nodes]) -> [ExploderGroup<SkeletonNode>] {
        let nodes = getAllNodes(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = Exploder.explode(nodes: nodes, links: links)
        
        for group in result {
            for node in group.linkedList {
                node.group_unsafe = group
            }
        }
        
        return result
    }
    
    public static func getSectionGroups_Unsafe(pages: [SkeletonPage],
                                               rules: [SkeletonLinkageRule_Sections]) -> [ExploderGroup<SkeletonSection>] {
        let sections = getAllSections(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = Exploder.explode(nodes: sections, links: links)
        
        for group in result {
            for section in group.linkedList {
                section.group_unsafe = group
            }
        }
        
        return result
    }
    
    public static func layout(pages: [SkeletonPage],
                              menuWidthWithSafeArea: Int,
                              safeAreaLeft: Int,
                              safeAreaRight: Int) {
        layout(pages: pages,
               rules_Pieces: [],
               rules_Flexers: [],
               rules_Chunks: [],
               rules_Nodes: [],
               rules_Sections: [],
               menuWidthWithSafeArea: menuWidthWithSafeArea,
               safeAreaLeft: safeAreaLeft,
               safeAreaRight: safeAreaRight)
    }
    
    // Row[ Section[ Chunk[] Chunk[Piece]] Section[ Chunk[Piece, Piece], Chunk[Piece]]]
    public static func layout(pages: [SkeletonPage],
                              rules_Pieces: [SkeletonLinkageRule_Pieces],
                              rules_Flexers: [SkeletonLinkageRule_Flexers],
                              rules_Chunks: [SkeletonLinkageRule_Chunks],
                              rules_Nodes: [SkeletonLinkageRule_Nodes],
                              rules_Sections: [SkeletonLinkageRule_Sections],
                              menuWidthWithSafeArea: Int,
                              safeAreaLeft: Int,
                              safeAreaRight: Int) {
        
        prepare_and_snap_minimum(pages: pages,
                                 menuWidthWithSafeArea: menuWidthWithSafeArea,
                                 safeAreaLeft: safeAreaLeft,
                                 safeAreaRight: safeAreaRight)
        
        // Now what we need is the concept of a layout pass.
        
        let pieces = SkeletonLayoutExecutor.getPieceGroups_Unsafe(pages: pages, rules: rules_Pieces)
        let flexers = SkeletonLayoutExecutor.getFlexerGroups_Unsafe(pages: pages, rules: rules_Flexers)
        let chunks = SkeletonLayoutExecutor.getChunkGroups_Unsafe(pages: pages, rules: rules_Chunks)
        let nodes = SkeletonLayoutExecutor.getNodeGroups_Unsafe(pages: pages, rules: rules_Nodes)
        let sections = SkeletonLayoutExecutor.getSectionGroups_Unsafe(pages: pages, rules: rules_Sections)
        
        let layoutPriorities = [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally]
        
        for layoutPriority in layoutPriorities {
            SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                   pieces: pieces,
                                                                   flexers: flexers,
                                                                   chunks: chunks,
                                                                   nodes: nodes,
                                                                   sections: sections,
                                                                   layoutPriority: layoutPriority)
        }
        
        // ( Section A   (Chunk A   (Piece A) ) )
        
        // Piece rule may link 1 piece to another.
        // This rule means they are equal width.
        // This is a HARD LINK.
        
        // When pieces are not in the same sec
        
        SkeletonLayoutBruteForceExpander.place(pages: pages,
                                               menuWidthWithSafeArea: menuWidthWithSafeArea,
                                               safeAreaLeft: safeAreaLeft,
                                               safeAreaRight: safeAreaRight)
        
        /*
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    section.width = section.current_size
                    for node in section.skeletonNodes {
                        node.width = node.current_size
                        for chunk in node.chunks {
                            chunk.width = chunk.current_size
                        }
                    }
                }
            }
        }
        
        for page in pages {
            for row in page.rows {
                row.position_content_after_size_computation(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
            }
        }
        */
    }
    
    // For the font scaling...
    public static func check(pages: [SkeletonPage],
                             rules_Pieces: [SkeletonLinkageRule_Pieces],
                             rules_Flexers: [SkeletonLinkageRule_Flexers],
                             rules_Chunks: [SkeletonLinkageRule_Chunks],
                             rules_Nodes: [SkeletonLinkageRule_Nodes],
                             rules_Sections: [SkeletonLinkageRule_Sections],
                             layoutPriority: LayoutPriority,
                             strict_centering: Bool,
                             menuWidthWithSafeArea: Int,
                             safeAreaLeft: Int,
                             safeAreaRight: Int) -> Bool {
        
        prepare_and_snap_minimum(pages: pages,
                                 menuWidthWithSafeArea: menuWidthWithSafeArea,
                                 safeAreaLeft: safeAreaLeft,
                                 safeAreaRight: safeAreaRight)
        
        // Now what we need is the concept of a layout pass.
        
        let pieces = SkeletonLayoutExecutor.getPieceGroups_Unsafe(pages: pages, rules: rules_Pieces)
        let flexers = SkeletonLayoutExecutor.getFlexerGroups_Unsafe(pages: pages, rules: rules_Flexers)
        let chunks = SkeletonLayoutExecutor.getChunkGroups_Unsafe(pages: pages, rules: rules_Chunks)
        let nodes = SkeletonLayoutExecutor.getNodeGroups_Unsafe(pages: pages, rules: rules_Nodes)
        let sections = SkeletonLayoutExecutor.getSectionGroups_Unsafe(pages: pages, rules: rules_Sections)
        let result = SkeletonLayoutBruteForceExpander.check(pages: pages,
                                                            pieces: pieces,
                                                            flexers: flexers,
                                                            chunks: chunks,
                                                            nodes: nodes,
                                                            sections: sections,
                                                            layoutPriority: layoutPriority,
                                                            strict_centering: strict_centering,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
        return result
    }
    
}
