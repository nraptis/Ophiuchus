//
//  SkeletonLayoutBruteForceExpander.swift
//  Ophiuchus
//
//  Created by Nick on 7/6/25.
//

import Foundation

public struct SkeletonLayoutBruteForceExpander {
    
    private static let maxExpandIterations = 4096

    static func positionContent(pages: [SkeletonPage],
                                menuWidthWithSafeArea: Int,
                                safeAreaLeft: Int,
                                safeAreaRight: Int) {
        for _page in pages {
            for _row in _page.rows {
                for _section in _row.sections {
                    _section.width = _section.currentSize
                    for _node in _section.nodes {
                        _node.width = _node.currentSize
                    }
                }
                
                _row.positionContentAfterSizeComputation(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                         safeAreaLeft: safeAreaLeft,
                                                         safeAreaRight: safeAreaRight)
            }
        }
    }
    
    
    
    static func expand_where_possible_calculate_matching_priorities(groupData: SkeletonLayoutGroupDataExploded,
                                                                    layoutPriority: LayoutPriority) {
        expand_where_possible_calculate_matching_priorities(pieceGroups: groupData.pieceGroups,
                              flexerGroups: groupData.flexerGroups,
                              nodeGroups: groupData.nodeGroups,
                              layoutPriority: layoutPriority)
    }
    
    static func expand_where_possible_calculate_matching_priorities(pieceGroups: [ExploderGroup<SkeletonPiece>],
                                                   flexerGroups: [ExploderGroup<Flexer>],
                                                   nodeGroups: [ExploderGroup<WiseLayoutNode>],
                                                   layoutPriority: LayoutPriority) {
        /*
        for pieceGroup in pieceGroups {
            pieceGroup.isActiveAtCurrentPriority = pieceGroup.matchesPriority(layoutPriority: layoutPriority)
        }
        for flexerGroup in flexerGroups {
            flexerGroup.isActiveAtCurrentPriority = flexerGroup.matchesPriority(layoutPriority: layoutPriority)
        }
        for nodeGroup in nodeGroups {
            nodeGroup.isActiveAtCurrentPriority = nodeGroup.matchesPriority(layoutPriority: layoutPriority)
        }
        */
    }
    
    static func expand_where_possible(pages: [SkeletonPage],
                                      groupData: SkeletonLayoutGroupDataExploded,
                                      layoutPriority: LayoutPriority) {
        expand_where_possible(pages: pages,
                              pieceGroups: groupData.pieceGroups,
                              flexerGroups: groupData.flexerGroups,
                              nodeGroups: groupData.nodeGroups,
                              layoutPriority: layoutPriority)
    }
    
    static func expand_where_possible_prepare_pass(groupData: SkeletonLayoutGroupDataExploded,
                                            layoutPriority: LayoutPriority) {
        expand_where_possible_prepare_pass(pieceGroups: groupData.pieceGroups,
                                                 flexerGroups: groupData.flexerGroups,
                                                 nodeGroups: groupData.nodeGroups,
                                                        layoutPriority: layoutPriority)
    }
    
    static func expand_where_possible_prepare_pass(pieceGroups: [ExploderGroup<SkeletonPiece>],
                                                   flexerGroups: [ExploderGroup<Flexer>],
                                                   nodeGroups: [ExploderGroup<WiseLayoutNode>],
                                                   layoutPriority: LayoutPriority) {
        
        /*
        for pieceGroup in pieceGroups {
            pieceGroup.isActiveAtCurrentPriority = pieceGroup.matchesPriority(layoutPriority: layoutPriority)
            pieceGroup.isAllEqualAtCurrentPriority = false
            pieceGroup.isLockedAtCurrentPriority = false
        }
        
        for flexerGroup in flexerGroups {
            flexerGroup.isActiveAtCurrentPriority = flexerGroup.matchesPriority(layoutPriority: layoutPriority)
            flexerGroup.isAllEqualAtCurrentPriority = false
            flexerGroup.isLockedAtCurrentPriority = false
            for flexer in flexerGroup.linkedList {
                flexer.targetSizeCurrentPriority = flexer.getTargetSize(layoutPriority: layoutPriority)
            }
        }
        
        for nodeGroup in nodeGroups {
            nodeGroup.isAllEqualAtCurrentPriority = false
            nodeGroup.isActiveAtCurrentPriority = nodeGroup.matchesPriority(layoutPriority: layoutPriority)
            nodeGroup.isLockedAtCurrentPriority = false
        }
    }
    
    // This can expand any node by 1,
    // This can expand any section by (number of nodes)
    static func expand_where_possible_pulse_step_a(nodeGroups: [ExploderGroup<WiseLayoutNode>]) -> Bool {
        
        */
        
        /*
        ListFactory_Growth.resetSectionList()
        for nodeGroup in nodeGroups {
            
            for node in nodeGroup.linkedList {
                node.proposedGrowthAmount = 0
            }
            
            if (nodeGroup.isActiveAtCurrentPriority == false) { continue }
            if (nodeGroup.isLockedAtEveryPriority == true) { continue }
            if (nodeGroup.isAllEqualAtCurrentPriority == true) { continue }
            if nodeGroup.computeSmallestIfNotAllEqual() {
                
                for node in nodeGroup.smallestList {
                    let section = node.section!
                    let proposedGrowthAmount = (nodeGroup.secondSmallestValue - node.currentSize)
                    ListFactory_Growth.intake(section: section,
                                                     node: node,
                                                     growth: proposedGrowthAmount)
                    node.proposedGrowthAmount = proposedGrowthAmount
                    
                }
            } else {
                nodeGroup.isAllEqualAtCurrentPriority = true
            }
        }
        
        if ListFactory_Growth.sectionListCount > 0 {
            
            print("We will grow some nodes just to match group sizes...")
            
            ListFactory_Growth.resetRowList()
            for sectionIndex in 0..<ListFactory_Growth.sectionListCount {
                
                let section = ListFactory_Growth.sectionList[sectionIndex]
                section.proposedGrowthAmount = section.requestedGrowthFromChildren
                let row = section.row!
                ListFactory_Growth.intake(row: row,
                                                 section: section)
            }
            
            var result = false
            for rowIndex in 0..<ListFactory_Growth.rowListCount {
                let row = ListFactory_Growth.rowList[rowIndex]
                let sectionListCount = ListFactory_Growth.rowGroupedSectionsListCounts[rowIndex]
                if row.canGrowAllSectionsByProposedGrowthAmount(sections: ListFactory_Growth.rowGroupedSectionsList[rowIndex],
                                                                sectionCount: sectionListCount) {
                    row.growAllSectionsByProposedGrowthAmount_Unsafe(sections: ListFactory_Growth.rowGroupedSectionsList[rowIndex],
                                                                     sectionCount: sectionListCount)
                    for sectionIndex in 0..<sectionListCount {
                        let section = ListFactory_Growth.rowGroupedSectionsList[rowIndex][sectionIndex]
                        section.growAllNodesByProposedGrowthAmount_Unsafe()
                    }
                    
                    result = true
                } else {
                    for sectionIndex in 0..<sectionListCount {
                        let section = ListFactory_Growth.rowGroupedSectionsList[rowIndex][sectionIndex]
                        if row.canGrowOneSectionByOne(section: section) {
                            row.growOneSectionByOne_Unsafe(section: section)
                            section.growOneNodeByOne_Unsafe()
                            result = true
                        } else {
                            // No more of this
                            for node in section.nodes {
                                node.group.isLockedAtEveryPriority = true
                            }
                        }
                    }
                }
            }
            return result
            
        } else {
            return false
        }
        */
        
    }
    
    static func expand_where_possible_pulse_step_b(flexerGroups: [ExploderGroup<Flexer>],
                                                   nodeGroups: [ExploderGroup<WiseLayoutNode>]) -> Bool {
        
        /*
        ListFactory_Growth.resetNodeList()
        
        for flexerGroup in flexerGroups {
            
            for flexer in flexerGroup.linkedList {
                flexer.proposedGrowthAmount = 0
            }
            
            if (flexerGroup.isActiveAtCurrentPriority == false) { continue }
            if (flexerGroup.isLockedAtEveryPriority == true) { continue }
            if (flexerGroup.isAllEqualAtCurrentPriority == true) { continue }
            
            if flexerGroup.computeSmallestIfNotAllEqual() {
                
                for flexer in flexerGroup.smallestList {
                    let node = flexer.node!
                    let proposedGrowthAmount = (flexerGroup.secondSmallestValue - node.currentSize)
                    ListFactory_Growth.intake(node: node,
                                                     flexer: flexer,
                                                     growth: proposedGrowthAmount)
                    node.proposedGrowthAmount = proposedGrowthAmount
                }
            } else {
                if flexerGroup.areAllAbleToGrowAtCurrentPriority() {
                    
                } else {
                    flexerGroup.isLockedAtCurrentPriority = true
                }
            }
        }
        
        if ListFactory_Growth.sectionListCount > 0 {
            
            print("We will grow some nodes just to match group sizes...")
            
            ListFactory_Growth.resetRowList()
            for sectionIndex in 0..<ListFactory_Growth.sectionListCount {
                
                let section = ListFactory_Growth.sectionList[sectionIndex]
                section.proposedGrowthAmount = section.requestedGrowthFromChildren
                let row = section.row!
                ListFactory_Growth.intake(row: row,
                                                 section: section)
            }
            
            var result = false
            for rowIndex in 0..<ListFactory_Growth.rowListCount {
                let row = ListFactory_Growth.rowList[rowIndex]
                let sectionListCount = ListFactory_Growth.rowGroupedSectionsListCounts[rowIndex]
                if row.canGrowAllSectionsByProposedGrowthAmount(sections: ListFactory_Growth.rowGroupedSectionsList[rowIndex],
                                                                sectionCount: sectionListCount) {
                    row.growAllSectionsByProposedGrowthAmount_Unsafe(sections: ListFactory_Growth.rowGroupedSectionsList[rowIndex],
                                                                     sectionCount: sectionListCount)
                    for sectionIndex in 0..<sectionListCount {
                        let section = ListFactory_Growth.rowGroupedSectionsList[rowIndex][sectionIndex]
                        section.growAllNodesByProposedGrowthAmount_Unsafe()
                    }
                    
                    result = true
                } else {
                    for sectionIndex in 0..<sectionListCount {
                        let section = ListFactory_Growth.rowGroupedSectionsList[rowIndex][sectionIndex]
                        if row.canGrowOneSectionByOne(section: section) {
                            row.growOneSectionByOne_Unsafe(section: section)
                            section.growOneNodeByOne_Unsafe()
                            result = true
                        } else {
                            // No more of this
                            for node in section.nodes {
                                node.group.isLockedAtEveryPriority = true
                            }
                        }
                    }
                }
            }
            return result
            
        } else {
            return false
        }
        */
        
        return false
    }

    
    static func expand_where_possible_pulse(groupData: SkeletonLayoutGroupDataExploded) -> Bool {
        let result = expand_where_possible_pulse(pieceGroups: groupData.pieceGroups,
                                                 flexerGroups: groupData.flexerGroups,
                                                 nodeGroups: groupData.nodeGroups)
        return result
    }
    
    static func expand_where_possible_pulse(pieceGroups: [ExploderGroup<SkeletonPiece>],
                                            flexerGroups: [ExploderGroup<Flexer>],
                                            nodeGroups: [ExploderGroup<WiseLayoutNode>]) -> Bool {
        
        var result = true
        
        /*
        if expand_where_possible_pulse_step_a(nodeGroups: nodeGroups) {
            result = true
        }
        */
        
        return result
    }
    
    
    static func expand_where_possible(pages: [SkeletonPage],
                                      pieceGroups: [ExploderGroup<SkeletonPiece>],
                                      flexerGroups: [ExploderGroup<Flexer>],
                                      nodeGroups: [ExploderGroup<WiseLayoutNode>],
                                      layoutPriority: LayoutPriority) {
        
        for flexerGroup in flexerGroups {
            for flexer in flexerGroup.linkedList {
                flexer.targetSizeCurrentPriority = flexer.getTargetSize(layoutPriority: layoutPriority)
            }
        }

        
        /*
         for flexerGroup in flexerGroups {
         var largestSize = 0
         for flexer in flexerGroup.linkedList {
         flexer.targetSize = flexer.getTargetSize(layoutPriority: layoutPriority)
         if flexer.currentSize > largestSize {
         largestSize = flexer.currentSize
         }
         }
         if flexerGroup.matchesPriority(layoutPriority: layoutPriority) {
         for flexer in flexerGroup.linkedList {
         if flexer.targetSize < largestSize {
         flexer.targetSize = largestSize
         }
         }
         }
         }
         */
        
        var reloop = true
        while reloop == true {
            
            
            reloop = false

            
            
            
        }
    }
    
    static func check(pages: [SkeletonPage],
                      groupData: SkeletonLayoutGroupDataExploded,
                      layoutPriority: LayoutPriority,
                      isStrictCenteringRequired: Bool,
                      menuWidthWithSafeArea: Int,
                      safeAreaLeft: Int,
                      safeAreaRight: Int) -> Bool {
        let result = check(pages: pages,
                           pieceGroups: groupData.pieceGroups,
                           flexerGroups: groupData.flexerGroups,
                           nodeGroups: groupData.nodeGroups,
                           layoutPriority: layoutPriority,
                           isStrictCenteringRequired: isStrictCenteringRequired,
                           menuWidthWithSafeArea: menuWidthWithSafeArea,
                           safeAreaLeft: safeAreaLeft,
                           safeAreaRight: safeAreaRight)
        return result
    }
    
    static func check(pages: [SkeletonPage],
                      pieceGroups: [ExploderGroup<SkeletonPiece>],
                      flexerGroups: [ExploderGroup<Flexer>],
                      nodeGroups: [ExploderGroup<WiseLayoutNode>],
                      layoutPriority: LayoutPriority,
                      isStrictCenteringRequired: Bool,
                      menuWidthWithSafeArea: Int,
                      safeAreaLeft: Int,
                      safeAreaRight: Int) -> Bool {
        
        expand_where_possible(pages: pages,
                              pieceGroups: pieceGroups,
                              flexerGroups: flexerGroups,
                              nodeGroups: nodeGroups,
                              layoutPriority: layoutPriority)
        
        positionContent(pages: pages,
                        menuWidthWithSafeArea: menuWidthWithSafeArea,
                        safeAreaLeft: safeAreaLeft,
                        safeAreaRight: safeAreaRight)
        
        for _page in pages {
            for _row in _page.rows {
                if !_row.validate(isStrictCenteringRequired: isStrictCenteringRequired,
                                  menuWidthWithSafeArea: menuWidthWithSafeArea,
                                  safeAreaLeft: safeAreaLeft,
                                  safeAreaRight: safeAreaRight) {
                    return false
                }
            }
        }
        
        return true
    }
    
}
