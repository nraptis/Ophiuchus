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
                                piece.currentSize = piece.original_size
                            }
                            for flexer in chunk.flexers {
                                flexer.currentSize = 0
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
                                chunk_sum += piece.currentSize
                            }
                            chunk.currentSize = chunk_sum
                            chunk.children_size = chunk_sum
                            node_sum += chunk_sum
                        }
                        node.currentSize = node_sum
                        node.childrenSize = node_sum
                        section_sum += node_sum
                    }
                    section.currentSize = section_sum
                    section.childrenSize = section_sum
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
    
    public static func layout(pages: [SkeletonPage],
                              menuWidthWithSafeArea: Int,
                              safeAreaLeft: Int,
                              safeAreaRight: Int) {
        layout(pages: pages,
               pieceRules: [],
               flexerRules: [],
               chunkRules: [],
               nodeRules: [],
               sectionRules: [],
               menuWidthWithSafeArea: menuWidthWithSafeArea,
               safeAreaLeft: safeAreaLeft,
               safeAreaRight: safeAreaRight)
    }
    
    // Row[ Section[ Chunk[] Chunk[Piece]] Section[ Chunk[Piece, Piece], Chunk[Piece]]]
    public static func layout(pages: [SkeletonPage],
                              pieceRules: [SkeletonLinkageRule_Pieces],
                              flexerRules: [SkeletonLinkageRule_Flexers],
                              chunkRules: [SkeletonLinkageRule_Chunks],
                              nodeRules: [SkeletonLinkageRule_Nodes],
                              sectionRules: [SkeletonLinkageRule_Sections],
                              menuWidthWithSafeArea: Int,
                              safeAreaLeft: Int,
                              safeAreaRight: Int) {
        
        prepare_and_snap_minimum(pages: pages,
                                 menuWidthWithSafeArea: menuWidthWithSafeArea,
                                 safeAreaLeft: safeAreaLeft,
                                 safeAreaRight: safeAreaRight)
        
        // Now what we need is the concept of a layout pass.
        
        let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: pieceRules)
        let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: flexerRules)
        let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: chunkRules)
        let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: nodeRules)
        let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: sectionRules)
        
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
                    section.width = section.currentSize
                    for node in section.skeletonNodes {
                        node.width = node.currentSize
                        for chunk in node.chunks {
                            chunk.width = chunk.currentSize
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
                             pieceRules: [SkeletonLinkageRule_Pieces],
                             flexerRules: [SkeletonLinkageRule_Flexers],
                             chunkRules: [SkeletonLinkageRule_Chunks],
                             nodeRules: [SkeletonLinkageRule_Nodes],
                             sectionRules: [SkeletonLinkageRule_Sections],
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
        
        let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: pieceRules)
        let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: flexerRules)
        let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: chunkRules)
        let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: nodeRules)
        let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: sectionRules)
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
