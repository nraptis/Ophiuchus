//
//  SkeletonLayoutBruteForceExpander.swift
//  Ophiuchus
//
//  Created by Nick on 7/6/25.
//

import Foundation

public struct SkeletonLayoutBruteForceExpander {
    
    private static let maxExpandIterations = 4096
    
    private static func mark_did_grow_false(pages: [SkeletonPage]) {
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    for node in section.skeletonNodes {
                        for chunk in node.chunks {
                            for flexer in chunk.flexers {
                                flexer.didGrowOnCurrentPass = false
                            }
                            chunk.didGrowOnCurrentPass = false
                        }
                        node.didGrowOnCurrentPass = false
                    }
                    section.didGrowOnCurrentPass = false
                }
            }
        }
    }
    
    static func place(pages: [SkeletonPage],
                      menuWidthWithSafeArea: Int,
                      safeAreaLeft: Int,
                      safeAreaRight: Int) {
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
    }
    
    static func expand_where_possible(pages: [SkeletonPage],
                                      layoutPriority: LayoutPriority) {
        let pieces = SkeletonLayoutGrouper.getPieceGroups(pages: pages, rules: [])
        let flexers = SkeletonLayoutGrouper.getFlexerGroups(pages: pages, rules: [])
        let chunks = SkeletonLayoutGrouper.getChunkGroups(pages: pages, rules: [])
        let nodes = SkeletonLayoutGrouper.getNodeGroups(pages: pages, rules: [])
        let sections = SkeletonLayoutGrouper.getSectionGroups(pages: pages, rules: [])
        SkeletonLayoutBruteForceExpander.expand_where_possible(pages: pages,
                                                               pieces: pieces,
                                                               flexers: flexers,
                                                               chunks: chunks,
                                                               nodes: nodes,
                                                               sections: sections,
                                                               layoutPriority: layoutPriority)
    }
    
    /*
     static func expand_where_possible(pages: [SkeletonPage],
     pieces: [ExploderGroup<SkeletonPiece>],
     flexers: [ExploderGroup<Flexer>],
     chunks: [ExploderGroup<SkeletonChunk>],
     nodes: [ExploderGroup<SkeletonNode>],
     sections: [ExploderGroup<SkeletonSection>],
     layoutPriority: LayoutPriority) {
     
     var all_flexers = [Flexer]()
     for page in pages {
     for row in page.rows {
     for section in row.sections {
     for node in section.skeletonNodes {
     for chunk in node.chunks {
     for flexer in chunk.flexers {
     all_flexers.append(flexer)
     }
     }
     }
     }
     }
     }
     
     expand_where_possible(pages: pages,
     all_flexers: all_flexers,
     pieces: pieces,
     chunks: chunks,
     nodes: nodes,
     sections: sections,
     layoutPriority: layoutPriority)
     }
     */
    
    static func expand_where_possible(pages: [SkeletonPage],
                                      pieces: [ExploderGroup<SkeletonPiece>],
                                      flexers: [ExploderGroup<Flexer>],
                                      chunks: [ExploderGroup<SkeletonChunk>],
                                      nodes: [ExploderGroup<SkeletonNode>],
                                      sections: [ExploderGroup<SkeletonSection>],
                                      layoutPriority: LayoutPriority) {
        
        for flexer_group in flexers {
            for flexer in flexer_group.linkedList {
                let desiredSize = flexer.getDesiredSize(layoutPriority: layoutPriority)
                flexer.target_size = desiredSize
            }
        }
        
        var reloop = true
        while reloop == true {
            reloop = false
            
            mark_did_grow_false(pages: pages)
            
            // Priority grow, smaller than desired size.
            
            for flexer_group in flexers {
                
                if flexer_group.linkedList.isEmpty {
                    fatalError("we should not have an empty flexer group.")
                }
                
                if flexer_group.linkedList.count == 1 {
                    // This is by far the most common and simple case.
                    let flexer = flexer_group.linkedList[0]
                    if flexer.canGrowByOne() {
                        flexer.growByOne_Unsafe_Bubble()
                    }
                } else {
                    
                    // If we are greater than group priority,
                    // let's naively expand each flexer.
                    if layoutPriority.gte(layoutPriority: flexer_group.layoutPriority) {
                        // This is higher priority than the
                        // "all equal size" rule. So, we will
                        // prioritize this action step plan.
                        for flexer in flexer_group.linkedList {
                            if flexer.canGrowByOne() {
                                flexer.growByOne_Unsafe_Bubble()
                            }
                        }
                    } else {
                        // Now we have a situation where
                        // With the given priority, we want
                        // all the flexers to be an equal size...
                        //
                        // So... Let's grow the smallest ones if possible.
                        flexer_group.compute_smallest()
                        if flexer_group.smallestList.count > 0 {
                            
                        } else {
                            // Here, they are ALL EQUAL size.
                            guard flexer_group.is_all_same_currentSize() else {
                                fatalError("The basic laws of logic broke down. They surely must all be the same size.")
                            }
                            
                            // NOW!
                            // We break it down by row. The rows each needs to be
                            // able to simultaneously grow all the elements....
                            //
                            // This is extremely hard to imagine
                            
                            
                        }
                        
                    }
                }
                
                
                // If
                //   1.) All the flexers did not grow yet.
                //   2.) All the flexers
                
                for flexer in flexer_group.linkedList {
                    if flexer.currentSize < flexer.target_size {
                        
                        if !flexer.didGrowOnCurrentPass {
                            
                            if flexer_group.is_largest(flexer) {
                                // We are the largest element,
                                // We will not grow until the rest of
                                // the group catches up...
                                
                            } else {
                                // We are *not* the largest element, we can grow
                                // by ourselves, no issues yet.
                                if flexer.canGrowByOne() {
                                    flexer.growByOne_Unsafe_Bubble()
                                    reloop = true
                                }
                            }
                            
                        }
                        
                        /*
                        // Can the flexer's whole group grow?
                        var allFlexersAreValid = true
                        for _flexer in flexer.group_unsafe.linkedList {
                            if _flexer.didGrowOnCurrentPass {
                                allFlexersAreValid = false
                                break
                            }
                            if !_flexer.canGrowByOne() {
                                allFlexersAreValid = false
                                break
                            }
                        }
                        
                        if flexer.canGrowByOne() {
                            flexer.growByOne_Unsafe_Bubble()
                            reloop = true
                        }
                        */
                    }
                }
            }
            
            
            for flexer_group in flexers {
                if flexer_group.layoutPriority.gte(layoutPriority: layoutPriority) {
                    flexer_group.compute_smallest()
                    if flexer_group.smallestList.count == 0 {
                        // In this case, we are all the same size.
                        if !flexer_group.is_all_same_currentSize() {
                            fatalError("A world without logic?!")
                            
                        }
                        
                        // Can they all grow?
                        var growAllFlexers = true
                        for _flexer in flexer_group.linkedList {
                            if _flexer.currentSize >= _flexer.target_size {
                                growAllFlexers = false
                                break
                            }
                            if _flexer.didGrowOnCurrentPass {
                                growAllFlexers = false
                                break
                            }
                            if !_flexer.canGrowByOne() {
                                growAllFlexers = false
                                break
                            }
                        }
                        // This is tricky...
                        // We can only grow them all
                        // if, for example, growing this
                        // one grows the section by x...
                        // you see my point...
                        if growAllFlexers {
                            
                            let flexer = flexer_group.linkedList.randomElement()!
                            if flexer.canGrowByOne() {
                                flexer.growByOne_Unsafe_Bubble()
                                reloop = true
                            }
                            
                        }
                        
                        
                    } else {
                        for flexer in flexer_group.smallestList {
                            if !flexer.didGrowOnCurrentPass {
                                if flexer.canGrowByOne() {
                                    flexer.growByOne_Unsafe_Bubble()
                                    reloop = true
                                }
                            }
                        }
                    }
                }
            }
            
            for piece_group in pieces {
                if piece_group.layoutPriority.gte(layoutPriority: layoutPriority) {
                    piece_group.compute_smallest()
                    for piece in piece_group.smallestList {
                        if piece.canGrowByOne() {
                            piece.growByOne_Unsafe_Bubble()
                            reloop = true
                        }
                    }
                }
            }
            /*
            for flexer_group in flexers {
                if flexer_group.layoutPriority.gte(layoutPriority: layoutPriority) {
                    flexer_group.compute_smallest()
                    for flexer in flexer_group.smallestList {
                        if flexer.row.canGrowByOne(section: flexer.section) {
                            flexer.growByOne_Unsafe_Bubble()
                            reloop = true
                        }
                    }
                }
            }
            */
            
            for chunk_group in chunks {
                if chunk_group.layoutPriority.gte(layoutPriority: layoutPriority) {
                    chunk_group.compute_smallest()
                    for chunk in chunk_group.smallestList {
                        if !chunk.didGrowOnCurrentPass {
                            if chunk.row.canGrowByOne(section: chunk.section) {
                                chunk.growByOne_Unsafe_Bubble()
                                reloop = true
                            }
                        }
                    }
                }
            }
            
            for node_group in nodes {
                if node_group.layoutPriority.gte(layoutPriority: layoutPriority) {
                    node_group.compute_smallest()
                    for node in node_group.smallestList {
                        if !node.didGrowOnCurrentPass {
                            if node.row.canGrowByOne(section: node.section) {
                                node.growChildrenByOne_Unsafe_Bubble()
                                reloop = true
                            }
                        }
                    }
                }
            }
            
            for section_group in sections {
                if section_group.layoutPriority.gte(layoutPriority: layoutPriority) {
                    section_group.compute_smallest()
                    for section in section_group.smallestList {
                        if !section.didGrowOnCurrentPass {
                            if section.row.canGrowByOne(section: section) {
                                section.growByOne_Unsafe_Bubble()
                                reloop = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func check(pages: [SkeletonPage],
                      pieces: [ExploderGroup<SkeletonPiece>],
                      flexers: [ExploderGroup<Flexer>],
                      chunks: [ExploderGroup<SkeletonChunk>],
                      nodes: [ExploderGroup<SkeletonNode>],
                      sections: [ExploderGroup<SkeletonSection>],
                      layoutPriority: LayoutPriority,
                      strict_centering: Bool,
                      menuWidthWithSafeArea: Int,
                      safeAreaLeft: Int,
                      safeAreaRight: Int) -> Bool {
        
        expand_where_possible(pages: pages,
                              pieces: pieces,
                              flexers: flexers,
                              chunks: chunks,
                              nodes: nodes,
                              sections: sections,
                              layoutPriority: layoutPriority)
        
        place(pages: pages,
              menuWidthWithSafeArea: menuWidthWithSafeArea,
              safeAreaLeft: safeAreaLeft,
              safeAreaRight: safeAreaRight)
        
        for flexer_group in flexers {
            for flexer in flexer_group.linkedList {
                let desiredSize = flexer.getDesiredSize(layoutPriority: layoutPriority)
                flexer.target_size = desiredSize
            }
        }
        
        for page in pages {
            for row in page.rows {
                if !row.validate(strict_centering: strict_centering,
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
