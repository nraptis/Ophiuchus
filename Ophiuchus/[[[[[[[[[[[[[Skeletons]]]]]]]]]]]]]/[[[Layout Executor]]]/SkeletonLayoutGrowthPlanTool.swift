//
//  SkeletonLayoutGrowthPlanValidator.swift
//  Ophiuchus
//
//  Created by Nick on 8/2/25.
//

import Foundation

struct SkeletonLayoutGrowthPlanTool {
    
    static var chunkListCount = 0
    static var chunkList = [any SkeletonChunkConforming](repeating: SkeletonChunkFixed(id: -1,
                                                                                       chunkIdentifier: .unknown,
                                                                                       piece: SkeletonPiece(id: -1,
                                                                                                            pieceIdentifier: .unknown,
                                                                                                            size: 0),
                                                                                       alignment: .left),
                                                         count: 32)
    static var groupedFlexerList = [[Flexer]](repeating: [Flexer](repeating: Flexer(id: -1,
                                                                                    flexerIdentifier: .unknown),
                                                                  count: 3),
                                              count: 32)
    static var groupedFlexerListCount = [Int](repeating: 0, count: 32)
    
    
    
    
    
    static var nodeListCount = 0
    static var nodeList = [SkeletonNode](repeating: SkeletonNode(id: -1,
                                                                 chunks: [],
                                                                 alignment: .left)
                                         ,
                                         count: 32)
    
    
    static var groupedChunkList = [[any SkeletonChunkConforming]](repeating: [any SkeletonChunkConforming](repeating:
                                                                                                            
                                                                                                            SkeletonChunkFixed(id: -1,
                                                                                                                               chunkIdentifier: .unknown,
                                                                                                                               piece: SkeletonPiece(id: -1,
                                                                                                                                                    pieceIdentifier: .unknown,
                                                                                                                                                    size: 0), alignment: .left),
                                                                                                           count: 5),
                                                                  count: 32)
    static var groupedChunkListCount = [Int](repeating: 0, count: 32)
    
    
    
    
    
    static var sectionListCount = 0
    static var sectionList = [SkeletonSection](repeating: SkeletonSection(id: -1,
                                                                          layoutNodes: [],
                                                                          alignment: .left)
                                               ,
                                               count: 32)
    
    
    static var groupedNodeList = [[SkeletonNode]](repeating: [SkeletonNode](repeating:
                                                                                
                                                                                SkeletonNode(id: -1,
                                                                                             chunks: [],
                                                                                             alignment: .left)
                                                                            
                                                                            , count: 10),
                                                  count: 32)
    static var groupedNodeListCount = [Int](repeating: 0, count: 32)
    
    
    
    static func getGrowthPlansForNodes(nodeList: [SkeletonNode], nodeListCount: Int) -> [GrowthPlansForRow] {
        SkeletonLayoutGrowthPlanTool.sectionListCount = 0
        for nodeIndex in 0..<nodeListCount {
            let node = nodeList[nodeIndex]
            let section = node.section!
            var sectionIndex = -1
            for checksectionIndex in 0..<SkeletonLayoutGrowthPlanTool.sectionListCount {
                if sectionList[checksectionIndex] === section {
                    sectionIndex = checksectionIndex
                    break
                }
            }
            if sectionIndex == -1 {
                sectionIndex = SkeletonLayoutGrowthPlanTool.sectionListCount
                sectionList[sectionIndex] = section
                groupedNodeListCount[sectionIndex] = 0
                SkeletonLayoutGrowthPlanTool.sectionListCount += 1
            }
            // Add the Node.
            groupedNodeList[sectionIndex][groupedNodeListCount[sectionIndex]] = node
            groupedNodeListCount[sectionIndex] = groupedNodeListCount[sectionIndex] + 1
        }
        
        var result = [GrowthPlansForRow]()
        
        // Bag them by section.
        
        return result
        
    }
    
    
    static var rowListCount = 0
    static var rowList = [SkeletonRow](repeating: SkeletonRow(sections: [], attemptedCenteredSection: nil)
                                       ,
                                       count: 32)
    
    
    static var groupedSectionList = [[SkeletonSection]](repeating: [SkeletonSection](repeating:
                                                                                        
                                                                                        SkeletonSection(id: -1,
                                                                                                        layoutNodes: [],
                                                                                                        alignment: .left)
                                                                                     
                                                                                     , count: 10),
                                                        count: 32)
    static var groupedSectionListCount = [Int](repeating: 0, count: 32)
    
    
    
    static func getGrowthPlansForSections(sectionList: [SkeletonSection], sectionListCount: Int) -> [GrowthPlansForRow] {
        SkeletonLayoutGrowthPlanTool.rowListCount = 0
        for SectionIndex in 0..<sectionListCount {
            let Section = sectionList[SectionIndex]
            let row = Section.row!
            var rowIndex = -1
            for checkrowIndex in 0..<SkeletonLayoutGrowthPlanTool.rowListCount {
                if rowList[checkrowIndex] === row {
                    rowIndex = checkrowIndex
                    break
                }
            }
            if rowIndex == -1 {
                rowIndex = SkeletonLayoutGrowthPlanTool.rowListCount
                rowList[rowIndex] = row
                groupedSectionListCount[rowIndex] = 0
                SkeletonLayoutGrowthPlanTool.rowListCount += 1
            }
            // Add the Section.
            groupedSectionList[rowIndex][groupedSectionListCount[rowIndex]] = Section
            groupedSectionListCount[rowIndex] = groupedSectionListCount[rowIndex] + 1
        }
        
        var result = [GrowthPlansForRow]()
        
        // Bag them by row.
        
        return result
        
    }
    
    static func getGrowthPlansForChunks(chunkList: [any SkeletonChunkConforming], chunkListCount: Int) -> [GrowthPlansForRow] {
        SkeletonLayoutGrowthPlanTool.nodeListCount = 0
        for chunkIndex in 0..<chunkListCount {
            let chunk = chunkList[chunkIndex]
            let node = chunk.node!
            var nodeIndex = -1
            for checknodeIndex in 0..<SkeletonLayoutGrowthPlanTool.nodeListCount {
                if nodeList[checknodeIndex] === node {
                    nodeIndex = checknodeIndex
                    break
                }
            }
            if nodeIndex == -1 {
                nodeIndex = SkeletonLayoutGrowthPlanTool.nodeListCount
                nodeList[nodeIndex] = node
                groupedChunkListCount[nodeIndex] = 0
                SkeletonLayoutGrowthPlanTool.nodeListCount += 1
            }
            // Add the Chunk.
            groupedChunkList[nodeIndex][groupedChunkListCount[nodeIndex]] = chunk
            groupedChunkListCount[nodeIndex] = groupedChunkListCount[nodeIndex] + 1
        }
        
        var result = [GrowthPlansForRow]()
        
        // Bag them by section.
        
        return result
        
    }
    
    static func getGrowthPlansForFlexers(flexerGroup: ExploderGroup<Flexer>) -> [GrowthPlansForRow] {
        
        // First bag by chunk.
        
        SkeletonLayoutGrowthPlanTool.chunkListCount = 0
        for flexer in flexerGroup.linkedList {
            let chunk = flexer.chunk!
            var chunkIndex = -1
            for checkChunkIndex in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
                if chunkList[checkChunkIndex] === chunk {
                    chunkIndex = checkChunkIndex
                    break
                }
            }
            if chunkIndex == -1 {
                chunkIndex = SkeletonLayoutGrowthPlanTool.chunkListCount
                chunkList[chunkIndex] = chunk
                groupedFlexerListCount[chunkIndex] = 0
                SkeletonLayoutGrowthPlanTool.chunkListCount += 1
            }
            // Add the flexer.
            groupedFlexerList[chunkIndex][groupedFlexerListCount[chunkIndex]] = flexer
            groupedFlexerListCount[chunkIndex] = groupedFlexerListCount[chunkIndex] + 1
        }
        
        
        
        var result = [GrowthPlansForRow]()
        
        // Bag them by section.
        
        return result
    }
    
    static func allGrowthPlansCanSimultaneouslyExecute(growthPlansForRows: [GrowthPlansForRow],
                                                       menuWidthWithSafeArea: Int,
                                                       safeAreaLeft: Int,
                                                       safeAreaRight: Int) -> Bool {
        
        if true {
            var validationSet = [SkeletonRow]()
            for growthPlansForRow in growthPlansForRows {
                var exists = false
                for _check in validationSet {
                    if _check === growthPlansForRow.layoutRow {
                        fatalError("This should not happen, we have 2 growth plans with same row...")
                    }
                }
                validationSet.append(growthPlansForRow.layoutRow)
            }
            // End of validation chunk.
        }
        
        for growthPlansForRow in growthPlansForRows {
            let growthPlans = growthPlansForRow.growthPlans
            if !growthPlansForRow.layoutRow.canAcceptAllGrowthPlansSimultaneously(growthPlans: growthPlans,
                                                                                  menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                                  safeAreaLeft: safeAreaLeft,
                                                                                  safeAreaRight: safeAreaRight) {
                return false
            }
        }
        return true
    }
    
}
