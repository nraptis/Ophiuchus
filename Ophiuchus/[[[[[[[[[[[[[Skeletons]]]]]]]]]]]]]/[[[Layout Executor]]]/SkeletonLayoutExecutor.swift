//
//  ThunderExecutor.swift
//  Ophiuchus
//
//  Created by Nick on 7/5/25.
//

import Foundation

public struct SkeletonLayoutExecutor {
    
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
        
        SmartLayoutExpanderMain.prepare(groupData: groupData,
                                        menuWidthWithSafeArea: menuWidthWithSafeArea,
                                        safeAreaLeft: safeAreaLeft,
                                        safeAreaRight: safeAreaRight)
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .required)
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .high)
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .medium)
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .low)
        SmartLayoutExpanderPass.pass(groupData: groupData, layoutPriority: .finally)
        
        SkeletonLayoutBruteForceExpander.positionContent(pages: pages,
                                                         menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                         safeAreaLeft: safeAreaLeft,
                                                         safeAreaRight: safeAreaRight)
        
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
