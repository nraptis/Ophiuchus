//
//  FlexerSkeletonLayoutSortedListFactory2.swift
//  Ophiuchus
//
//  Created by Nick on 8/9/25.
//

import Foundation

public struct ListFactory_Growth {
    
    
    /*
    private static var nodeTable = [Int: Int]()
    private(set) static var nodeList = [WiseLayoutNode]()
    private(set) static var nodeGroupedFlexersList = [[Flexer]]()
    private(set) static var nodeGroupedFlexersListCounts = [Int]()
    private(set) static var nodeGroupedFlexersListSizes = [Int]()
    private(set) static var nodeGroupedPiecesList = [[SkeletonPiece]]()
    private(set) static var nodeGroupedPiecesListCounts = [Int]()
    private(set) static var nodeGroupedPiecesListSizes = [Int]()
    private(set) static var nodeListCount = 0
    private(set) static var nodeListSize = 0

    static func resetNodeList() {
        for nodeIndex in 0..<nodeListCount {
            nodeGroupedPiecesListCounts[nodeIndex] = 0
        }
        for nodeIndex in 0..<nodeListSize {
            nodeGroupedFlexersListCounts[nodeIndex] = 0
        }
        nodeListCount = 0
        nodeTable.removeAll(keepingCapacity: true)
    }
    
    
    private static func intakeNodePiece(index: Int, piece: SkeletonPiece) {
        if nodeGroupedPiecesListCounts[index] >= nodeGroupedPiecesListSizes[index] {
            let newSize = (nodeGroupedPiecesListCounts[index] + nodeGroupedPiecesListCounts[index] / 2 + 1)
            while nodeGroupedPiecesList[index].count < newSize {
                nodeGroupedPiecesList[index].append(piece)
            }
            nodeGroupedPiecesListSizes[index] = newSize
        }
        
        nodeGroupedPiecesList[index][nodeGroupedPiecesListCounts[index]] = piece
        nodeGroupedPiecesListCounts[index] += 1
    }
    
    private static func intakeNodeFlexer(index: Int, flexer: Flexer) {
        if nodeGroupedFlexersListCounts[index] >= nodeGroupedFlexersListSizes[index] {
            let newSize = (nodeGroupedFlexersListCounts[index] + nodeGroupedFlexersListCounts[index] / 2 + 1)
            while nodeGroupedFlexersList[index].count < newSize {
                nodeGroupedFlexersList[index].append(flexer)
            }
            nodeGroupedFlexersListSizes[index] = newSize
        }
        
        nodeGroupedFlexersList[index][nodeGroupedFlexersListCounts[index]] = flexer
        nodeGroupedFlexersListCounts[index] += 1
    }

    static func intake(node: WiseLayoutNode, flexer: Flexer) {
        
        let id = node.id
        
        if let nodeIndex = nodeTable[id] {
            intakeNodeFlexer(index: nodeIndex, flexer: flexer)
            node.requestedGrowthFromChildren += 1
            return
        }
        
        let nodeIndex = nodeListCount
        nodeTable[id] = nodeListCount
        node.requestedGrowthFromChildren = 1
        
        if nodeListCount >= nodeListSize {
            nodeListSize = (nodeListCount + (nodeListCount / 2) + 1)
            while nodeList.count < nodeListSize {
                nodeList.append(node)
                nodeGroupedFlexersList.append([Flexer]())
                nodeGroupedFlexersListCounts.append(0)
                nodeGroupedFlexersListSizes.append(0)
                nodeGroupedPiecesList.append([SkeletonPiece]())
                nodeGroupedPiecesListCounts.append(0)
                nodeGroupedPiecesListSizes.append(0)
            }
        }
        
        nodeList[nodeListCount] = node
        nodeGroupedFlexersListCounts[nodeListCount] = 0
        nodeGroupedPiecesListCounts[nodeListCount] = 0
        nodeListCount += 1
        
        intakeNodeFlexer(index: nodeIndex, flexer: flexer)
    }
    
    static func intake(node: WiseLayoutNode, piece: SkeletonPiece) {
        
        let id = node.id
        
        if let nodeIndex = nodeTable[id] {
            intakeNodePiece(index: nodeIndex, piece: piece)
            node.requestedGrowthFromChildren += 1
            return
        }
        
        let nodeIndex = nodeListCount
        nodeTable[id] = nodeListCount
        node.requestedGrowthFromChildren = 1
        
        if nodeListCount >= nodeListSize {
            nodeListSize = (nodeListCount + (nodeListCount / 2) + 1)
            while nodeList.count < nodeListSize {
                nodeList.append(node)
                nodeGroupedFlexersList.append([Flexer]())
                nodeGroupedFlexersListCounts.append(0)
                nodeGroupedFlexersListSizes.append(0)
                nodeGroupedPiecesList.append([SkeletonPiece]())
                nodeGroupedPiecesListCounts.append(0)
                nodeGroupedPiecesListSizes.append(0)
            }
        }
        
        nodeList[nodeListCount] = node
        nodeGroupedFlexersListCounts[nodeListCount] = 0
        nodeGroupedPiecesListCounts[nodeListCount] = 0
        nodeListCount += 1
        
        intakeNodePiece(index: nodeIndex, piece: piece)
    }

    static func intake(node: WiseLayoutNode, growth: Int) {
        
        let id = node.id
        if nodeTable[id] != nil {
            node.requestedGrowthFromChildren += growth
            return
        }
        
        nodeTable[id] = nodeListCount
        node.requestedGrowthFromChildren = growth
        
        if nodeListCount >= nodeListSize {
            nodeListSize = (nodeListCount + (nodeListCount / 2) + 1)
            while nodeList.count < nodeListSize {
                nodeList.append(node)
                nodeGroupedFlexersList.append([Flexer]())
                nodeGroupedFlexersListCounts.append(0)
                nodeGroupedFlexersListSizes.append(0)
                nodeGroupedPiecesList.append([SkeletonPiece]())
                nodeGroupedPiecesListCounts.append(0)
                nodeGroupedPiecesListSizes.append(0)
            }
        }
        
        nodeList[nodeListCount] = node
        nodeGroupedFlexersListCounts[nodeListCount] = 0
        nodeGroupedPiecesListCounts[nodeListCount] = 0
        nodeListCount += 1
    }
    
    static func intake(node: WiseLayoutNode) {
        
        let id = node.id
        if nodeTable[id] != nil {
            node.requestedGrowthFromChildren += 1
            return
        }
        
        nodeTable[id] = nodeListCount
        node.requestedGrowthFromChildren = 1
        
        if nodeListCount >= nodeListSize {
            nodeListSize = (nodeListCount + (nodeListCount / 2) + 1)
            while nodeList.count < nodeListSize {
                nodeList.append(node)
                nodeGroupedFlexersList.append([Flexer]())
                nodeGroupedFlexersListCounts.append(0)
                nodeGroupedFlexersListSizes.append(0)
                nodeGroupedPiecesList.append([SkeletonPiece]())
                nodeGroupedPiecesListCounts.append(0)
                nodeGroupedPiecesListSizes.append(0)
            }
        }
        
        nodeList[nodeListCount] = node
        nodeGroupedFlexersListCounts[nodeListCount] = 0
        nodeGroupedPiecesListCounts[nodeListCount] = 0
        nodeListCount += 1
    }
    */

    
    
    
    
    
    
    
    
    
    
    



    /*
    private static var sectionTable = [Int: Int]()
    private(set) static var sectionList = [SkeletonSection]()
    private(set) static var sectionGroupedNodesList = [[WiseLayoutNode]]()
    private(set) static var sectionGroupedNodesListCounts = [Int]()
    private(set) static var sectionGroupedNodesListSizes = [Int]()
    private(set) static var sectionListCount = 0
    private(set) static var sectionListSize = 0

    static func resetSectionList() {
        sectionListCount = 0
        sectionTable.removeAll(keepingCapacity: true)
    }

    private static func intakeSectionNode(index: Int, node: WiseLayoutNode) {
        if sectionGroupedNodesListCounts[index] >= sectionGroupedNodesListSizes[index] {
            let newSize = (sectionGroupedNodesListCounts[index] + sectionGroupedNodesListCounts[index] / 2 + 1)
            while sectionGroupedNodesList[index].count < newSize {
                sectionGroupedNodesList[index].append(node)
            }
            sectionGroupedNodesListSizes[index] = newSize
        }
        
        sectionGroupedNodesList[index][sectionGroupedNodesListCounts[index]] = node
        sectionGroupedNodesListCounts[index] += 1
    }
    
    static func intake(section: SkeletonSection, growth: Int) {
        
        let id = section.id
        if sectionTable[id] != nil {
            section.requestedGrowthFromChildren += growth
            return
        }
        
        sectionTable[id] = sectionListCount
        section.requestedGrowthFromChildren = growth
        
        if sectionListCount >= sectionListSize {
            sectionListSize = (sectionListCount + (sectionListCount / 2) + 1)
            while sectionList.count < sectionListSize {
                sectionList.append(section)
            }
        }
        
        sectionList[sectionListCount] = section
        sectionGroupedNodesListCounts[sectionListCount] = 0
        sectionListCount += 1
    }
    
    static func intake(section: SkeletonSection) {
        let id = section.id
        if sectionTable[id] != nil {
            return
        }
        sectionTable[id] = sectionListCount
        if sectionListCount >= sectionListSize {
            sectionListSize = (sectionListCount + (sectionListCount / 2) + 1)
            while sectionList.count < sectionListSize {
                sectionList.append(section)
            }
        }
        sectionList[sectionListCount] = section
        sectionListCount += 1
    }
    */

    
    
    
    
    private static var rowTable = [Int: Int]()
    private(set) static var rowList = [SkeletonRow]()
    private(set) static var rowGroupedSectionsList = [[SkeletonSection]]()
    private(set) static var rowGroupedSectionsListCounts = [Int]()
    private(set) static var rowGroupedSectionsListSizes = [Int]()
    private(set) static var rowGroupedSectionsMap = [Set<Int>]()

    private(set) static var rowListCount = 0
    private(set) static var rowListSize = 0

    static func resetRowList() {
        rowListCount = 0
        rowTable.removeAll(keepingCapacity: true)
    }

    private static func intakeRowSection(index: Int, section: SkeletonSection) {
        
        let id = section.id
        if rowGroupedSectionsMap[index].contains(id) {
            return
        }
        rowGroupedSectionsMap[index].insert(id)
        
        if rowGroupedSectionsListCounts[index] >= rowGroupedSectionsListSizes[index] {
            let newSize = (rowGroupedSectionsListCounts[index] + rowGroupedSectionsListCounts[index] / 2 + 1)
            while rowGroupedSectionsList[index].count < newSize {
                rowGroupedSectionsList[index].append(section)
            }
            rowGroupedSectionsListSizes[index] = newSize
        }
        
        rowGroupedSectionsList[index][rowGroupedSectionsListCounts[index]] = section
        rowGroupedSectionsListCounts[index] += 1
    }

    static func intake(row: SkeletonRow, section: SkeletonSection) {
        
        let id = row.id
        
        if let rowIndex = rowTable[id] {
            intakeRowSection(index: rowIndex, section: section)
            return
        }
        
        let rowIndex = rowListCount
        rowTable[id] = rowListCount
        
        if rowListCount >= rowListSize {
            rowListSize = (rowListCount + (rowListCount / 2) + 1)
            while rowList.count < rowListSize {
                rowList.append(row)
                rowGroupedSectionsList.append([SkeletonSection]())
                rowGroupedSectionsListCounts.append(0)
                rowGroupedSectionsListSizes.append(0)
                rowGroupedSectionsMap.append(Set<Int>())
            }
        }
        
        rowList[rowListCount] = row
        rowGroupedSectionsListCounts[rowListCount] = 0
        rowGroupedSectionsMap[rowListCount].removeAll(keepingCapacity: true)
        rowListCount += 1
        intakeRowSection(index: rowIndex, section: section)
    }

    /*
    static func intake(row: SkeletonRow) {
        
        let id = row.id
        if rowTable[id] != nil {
            return
        }
        
        rowTable[id] = rowListCount
        if rowListCount >= rowListSize {
            rowListSize = (rowListCount + (rowListCount / 2) + 1)
            while rowList.count < rowListSize {
                rowList.append(row)
                rowGroupedSectionsList.append([SkeletonSection]())
                rowGroupedSectionsListCounts.append(0)
                rowGroupedSectionsListSizes.append(0)
                rowGroupedSectionsMap.append(Set<Int>())
            }
        }
        
        rowList[rowListCount] = row
        rowGroupedSectionsListCounts[rowListCount] = 0
        rowGroupedSectionsMap[rowListCount].removeAll(keepingCapacity: true)
        rowListCount += 1
    }
    */
    
    
    
    
    
}
