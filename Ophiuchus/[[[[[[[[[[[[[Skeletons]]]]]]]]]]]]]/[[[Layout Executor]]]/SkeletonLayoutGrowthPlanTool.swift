//
//  SkeletonLayoutGrowthPlanValidator.swift
//  Ophiuchus
//
//  Created by Nick on 8/2/25.
//

import Foundation

struct SkeletonLayoutGrowthPlanTool {
    
    static let amountListDefault = [Int](repeating: 1, count: 256)
    static let amountListDefaultWRONG = [Int](repeating: 2, count: 256)
    
    
    static var chunkListCount = 0
    static var chunkList = [SkeletonChunk](repeating: SkeletonChunk(id: -1,
                                                                    chunkIdentifier: .unknown,
                                                                    pieces: [],
                                                                    flexers: [],
                                                                    alignment: .left),
                                                         count: 256)
    static var chunkAmountList = [Int](repeating: 0, count: 256)
    
    static var groupedFlexerList = [[Flexer]](repeating: [Flexer](repeating: Flexer(id: -1,
                                                                                    flexerIdentifier: .unknown),
                                                                  count: 32),
                                              count: 256)
    static var groupedFlexerListCount = [Int](repeating: 0, count: 256)
    
    
    
    
    
    static var groupedPieceList = [[SkeletonPiece]](repeating: [SkeletonPiece](repeating: SkeletonPiece(id: -1,
                                                                                                        pieceIdentifier: .unknown,
                                                                                                        size: 0),
                                                                  count: 32),
                                              count: 256)
    static var groupedPieceListCount = [Int](repeating: 0, count: 256)
    
    
    
    
    
    
    static var nodeListCount = 0
    static var nodeList = [SkeletonNode](repeating: SkeletonNode(id: -1,
                                                                 chunks: [],
                                                                 alignment: .left)
                                         ,
                                         count: 256)
    static var nodeAmountList = [Int](repeating: 0, count: 256)
    
    
    static var groupedChunkList = [[SkeletonChunk]](repeating: [SkeletonChunk](repeating: SkeletonChunk(id: -1,
                                                                                                                               chunkIdentifier: .unknown,
                                                                                                                               pieces: [], flexers: [], alignment: .left),
                                                                                                           count: 256),
                                                                  count: 256)
    static var groupedChunkListCount = [Int](repeating: 0, count: 256)
    static var groupedChunkListAmount = [Int](repeating: 0, count: 256)
    
    
    
    
    static var sectionListCount = 0
    static var sectionList = [SkeletonSection](repeating: SkeletonSection(id: -1,
                                                                          layoutNodes: [],
                                                                          alignment: .left)
                                               ,
                                               count: 256)
    static var sectionAmountList = [Int](repeating: 0, count: 256)
    
    
    static var groupedNodeList = [[SkeletonNode]](repeating: [SkeletonNode](repeating:
                                                                                
                                                                                SkeletonNode(id: -1,
                                                                                             chunks: [],
                                                                                             alignment: .left)
                                                                            
                                                                            , count: 256),
                                                  count: 64)
    static var groupedNodeListCount = [Int](repeating: 0, count: 256)
    static var groupedNodeListAmount = [Int](repeating: 0, count: 256)
    
    
    
    static var rowListCount = 0
    static var rowList = [SkeletonRow](repeating: SkeletonRow(id: -1,
                                                              sections: [],
                                                              attemptedCenteredSection: nil)
                                       ,
                                       count: 32)
    
    static var groupedSectionList = [[SkeletonSection]](repeating: [SkeletonSection](repeating:
                                                                                        
                                                                                        SkeletonSection(id: -1,
                                                                                                        layoutNodes: [],
                                                                                                        alignment: .left)
                                                                                     
                                                                                     , count: 128),
                                                        count: 128)
    static var groupedSectionListCount = [Int](repeating: 0, count: 128)
    static var groupedSectionListAmount = [Int](repeating: 0, count: 128)
    
    static func getRowGrowthPlansForSections(sectionList: [SkeletonSection],
                                             sectionListCount: Int) -> [RowGrowthPlans] {
        return getRowGrowthPlansForSections(sectionList: sectionList,
                                            sectionListCount: sectionListCount,
                                            sectionAmountList: amountListDefault)
    }
    
    static func getRowGrowthPlansForSections(sectionList: [SkeletonSection],
                                             sectionListCount: Int,
                                             sectionAmountList: [Int]) -> [RowGrowthPlans] {
        SkeletonLayoutGrowthPlanTool.rowListCount = 0
        for sectionIndex in 0..<sectionListCount {
            let section = sectionList[sectionIndex]
            section.growthPlanIndex = sectionIndex
            let row = section.row!
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
            groupedSectionList[rowIndex][groupedSectionListCount[rowIndex]] = section
            groupedSectionListCount[rowIndex] = groupedSectionListCount[rowIndex] + 1
        }
        
        var result = [RowGrowthPlans]()
        for rowIndex in 0..<rowListCount {
            let layoutRow = rowList[rowIndex]
            var growthPlans = [GrowthPlan]()
            for sectionIndex in 0..<groupedSectionListCount[rowIndex] {
                let layoutSection = groupedSectionList[rowIndex][sectionIndex]
                let amount = sectionAmountList[layoutSection.growthPlanIndex]
                let growthPlan = GrowthPlan(layoutRow: layoutRow,
                                            layoutSection: layoutSection,
                                            amount: amount)
                growthPlans.append(growthPlan)
                
            }
            let growthPlansForRow = RowGrowthPlans(row: layoutRow,
                                                   growthPlans: growthPlans)
            result.append(growthPlansForRow)
        }
        return result
    }
    
    static func getRowGrowthPlansForNodes(nodeList: [SkeletonNode],
                                          nodeListCount: Int) -> [RowGrowthPlans] {
        return getRowGrowthPlansForNodes(nodeList: nodeList,
                                         nodeListCount: nodeListCount,
                                         nodeAmountList: amountListDefault)
    }
    
    static func getRowGrowthPlansForNodes(nodeList: [SkeletonNode],
                                          nodeListCount: Int,
                                          nodeAmountList: [Int]) -> [RowGrowthPlans] {
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
                sectionAmountList[sectionIndex] = 0
                sectionList[sectionIndex] = section
                groupedNodeListCount[sectionIndex] = 0
                SkeletonLayoutGrowthPlanTool.sectionListCount += 1
            }
            // Add the Node.
            sectionAmountList[sectionIndex] += nodeAmountList[nodeIndex]
            groupedNodeList[sectionIndex][groupedNodeListCount[sectionIndex]] = node
            groupedNodeListCount[sectionIndex] = groupedNodeListCount[sectionIndex] + 1
        }
        
        for sectionIndex in 0..<SkeletonLayoutGrowthPlanTool.sectionListCount {
            let section = sectionList[sectionIndex]
            var amount = sectionAmountList[sectionIndex]
            let underflow = (section.currentSize - section.childrenSize)
            amount -= underflow
            if amount < 0 { amount = 0 }
            sectionAmountList[sectionIndex] = amount
        }
        
        let result = getRowGrowthPlansForSections(sectionList: sectionList,
                                                  sectionListCount: sectionListCount,
                                                  sectionAmountList: sectionAmountList)
        return result
        
        //return []
    }
    
    static func getRowGrowthPlansForChunks(chunkList: [SkeletonChunk],
                                           chunkListCount: Int) -> [RowGrowthPlans] {
        return getRowGrowthPlansForChunks(chunkList: chunkList,
                                          chunkListCount: chunkListCount,
                                          elementAmountList: amountListDefault)
    }
    
    static func getRowGrowthPlansForChunks(chunkList: [SkeletonChunk],
                                           chunkListCount: Int,
                                           elementAmountList: [Int]) -> [RowGrowthPlans] {
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
                nodeAmountList[nodeIndex] = 0
                nodeList[nodeIndex] = node
                groupedChunkListCount[nodeIndex] = 0
                SkeletonLayoutGrowthPlanTool.nodeListCount += 1
            }
            // Add the Chunk.
            nodeAmountList[nodeIndex] += elementAmountList[chunkIndex]
            groupedChunkList[nodeIndex][groupedChunkListCount[nodeIndex]] = chunk
            groupedChunkListCount[nodeIndex] = groupedChunkListCount[nodeIndex] + 1
        }
        for nodeIndex in 0..<SkeletonLayoutGrowthPlanTool.nodeListCount {
            let node = nodeList[nodeIndex]
            var amount = nodeAmountList[nodeIndex]
            let underflow = (node.currentSize - node.childrenSize)
            amount -= underflow
            if amount < 0 { amount = 0 }
            nodeAmountList[nodeIndex] = amount
        }
        
        let result = getRowGrowthPlansForNodes(nodeList: nodeList,
                                               nodeListCount: nodeListCount,
                                               nodeAmountList: nodeAmountList)
        return result
    }
    
    static func getRowGrowthPlansForFlexers(flexerGroup: ExploderGroup<Flexer>) -> [RowGrowthPlans] {
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
                chunkAmountList[chunkIndex] = 0
                chunkList[chunkIndex] = chunk
                groupedFlexerListCount[chunkIndex] = 0
                SkeletonLayoutGrowthPlanTool.chunkListCount += 1
            }
            groupedFlexerList[chunkIndex][groupedFlexerListCount[chunkIndex]] = flexer
            groupedFlexerListCount[chunkIndex] = groupedFlexerListCount[chunkIndex] + 1
            chunkAmountList[chunkIndex] += 1
        }
        for chunkIndex in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
            let chunk = chunkList[chunkIndex]
            var amount = chunkAmountList[chunkIndex]
            let underflow = (chunk.currentSize - chunk.childrenSize)
            amount -= underflow
            if amount < 0 { amount = 0 }
            chunkAmountList[chunkIndex] = amount
        }
        let result = getRowGrowthPlansForChunks(chunkList: chunkList,
                                                chunkListCount: chunkListCount,
                                                elementAmountList: chunkAmountList)
        return result
    }
    
    static func getRowGrowthPlansForPieces(pieceGroup: ExploderGroup<SkeletonPiece>) -> [RowGrowthPlans] {
        SkeletonLayoutGrowthPlanTool.chunkListCount = 0
        for piece in pieceGroup.linkedList {
            let chunk = piece.chunk!
            var chunkIndex = -1
            for checkChunkIndex in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
                if chunkList[checkChunkIndex] === chunk {
                    chunkIndex = checkChunkIndex
                    break
                }
            }
            if chunkIndex == -1 {
                chunkIndex = SkeletonLayoutGrowthPlanTool.chunkListCount
                chunkAmountList[chunkIndex] = 0
                chunkList[chunkIndex] = chunk
                groupedPieceListCount[chunkIndex] = 0
                SkeletonLayoutGrowthPlanTool.chunkListCount += 1
            }
            groupedPieceList[chunkIndex][groupedPieceListCount[chunkIndex]] = piece
            groupedPieceListCount[chunkIndex] = groupedPieceListCount[chunkIndex] + 1
            chunkAmountList[chunkIndex] += 1
        }
        for chunkIndex in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
            let chunk = chunkList[chunkIndex]
            var amount = chunkAmountList[chunkIndex]
            let underflow = (chunk.currentSize - chunk.childrenSize)
            amount -= underflow
            if amount < 0 { amount = 0 }
            chunkAmountList[chunkIndex] = amount
        }
        let result = getRowGrowthPlansForChunks(chunkList: chunkList,
                                                chunkListCount: chunkListCount,
                                                elementAmountList: chunkAmountList)
        return result
    }
    
    static func allGrowthPlansCanSimultaneouslyExecute(growthPlansForRows: [RowGrowthPlans],
                                                       menuWidthWithSafeArea: Int,
                                                       safeAreaLeft: Int,
                                                       safeAreaRight: Int) -> Bool {
        
        if true {
            var validationSet = [SkeletonRow]()
            for growthPlansForRow in growthPlansForRows {
                var exists = false
                for _check in validationSet {
                    if _check === growthPlansForRow.row {
                        fatalError("This should not happen, we have 2 growth plans with same row...")
                    }
                }
                validationSet.append(growthPlansForRow.row)
            }
            // End of validation chunk.
        }
        
        for growthPlansForRow in growthPlansForRows {
            let growthPlans = growthPlansForRow.growthPlans
            if !growthPlansForRow.row.canAcceptAllGrowthPlansSimultaneously(growthPlans: growthPlans,
                                                                                  menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                                                  safeAreaLeft: safeAreaLeft,
                                                                                  safeAreaRight: safeAreaRight) {
                return false
            }
        }
        return true
    }
    
}
