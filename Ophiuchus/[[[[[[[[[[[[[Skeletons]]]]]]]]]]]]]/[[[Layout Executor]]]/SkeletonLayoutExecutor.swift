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
        
        for _page in pages {
            for _row in _page.rows {
                for _section in _row.sections {
                    for _node in _section.nodes {
                        for _piece in _node.pieces {
                            _piece.currentSize = _piece.originalSize
                        }
                        for _flexer in _node.flexers {
                            _flexer.currentSize = 0
                        }
                    }
                }
            }
        }
        for _page in pages {
            for _row in _page.rows {
                for _section in _row.sections {
                    var sectionSum = 0
                    for _node in _section.nodes {
                        var nodeSum = 0
                        for piece in _node.pieces {
                            nodeSum += piece.currentSize
                        }
                        _node.currentSize = nodeSum
                        _node.childrenSize = nodeSum
                        sectionSum += nodeSum
                    }
                    _section.currentSize = sectionSum
                }
            }
        }
        
        for _page in pages {
            for _row in _page.rows {
                _row.snap_minimum_after_children_ready(menuWidthWithSafeArea: menuWidthWithSafeArea,
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
               nodeRules: [],
               menuWidthWithSafeArea: menuWidthWithSafeArea,
               safeAreaLeft: safeAreaLeft,
               safeAreaRight: safeAreaRight)
    }
    
    // Row[ Section[ Chunk[] Chunk[Piece]] Section[ Chunk[Piece, Piece], Chunk[Piece]]]
    public static func layout(pages: [SkeletonPage],
                              pieceRules: [SkeletonLinkageRule_Pieces],
                              flexerRules: [SkeletonLinkageRule_Flexers],
                              nodeRules: [SkeletonLinkageRule_Nodes],
                              menuWidthWithSafeArea: Int,
                              safeAreaLeft: Int,
                              safeAreaRight: Int) {
        
        let book = SkeletonBook(pages: pages,
                                      nodeRules: nodeRules,
                                      flexerRules: flexerRules,
                                      pieceRules: pieceRules)
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        
        prepare_and_snap_minimum(pages: pages,
                                 menuWidthWithSafeArea: menuWidthWithSafeArea,
                                 safeAreaLeft: safeAreaLeft,
                                 safeAreaRight: safeAreaRight)
        
        let layoutPriorities = [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally]
        
        for layoutPriority in layoutPriorities {
            SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                                   groupData: groupData,
                                                                   layoutPriority: layoutPriority)
        }
        
        // ( Section A   (Chunk A   (Piece A) ) )
        
        // Piece rule may link 1 piece to another.
        // This rule means they are equal width.
        // This is a HARD LINK.
        
        // When pieces are not in the same sec
        
        SkeletonLayoutBruteForceExpander.positionContent(pages: pages,
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
         row.positionContentAfterSizeComputation(menuWidthWithSafeArea: menuWidthWithSafeArea,
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
                             nodeRules: [SkeletonLinkageRule_Nodes],
                             layoutPriority: LayoutPriority,
                             isStrictCenteringRequired: Bool,
                             menuWidthWithSafeArea: Int,
                             safeAreaLeft: Int,
                             safeAreaRight: Int) -> Bool {
        
        let book = SkeletonBook(pages: pages,
                                      nodeRules: nodeRules,
                                      flexerRules: flexerRules,
                                      pieceRules: pieceRules)
        prepare_and_snap_minimum(pages: pages,
                                 menuWidthWithSafeArea: menuWidthWithSafeArea,
                                 safeAreaLeft: safeAreaLeft,
                                 safeAreaRight: safeAreaRight)
        
        let groupData = SkeletonLayoutGrouper.getAll(book: book)
        let result = SkeletonLayoutBruteForceExpander.check(pages: pages,
                                                            groupData: groupData,
                                                            layoutPriority: layoutPriority,
                                                            isStrictCenteringRequired: isStrictCenteringRequired,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight)
        return result
    }
}
