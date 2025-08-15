//
//  ListFactory_Groups.swift
//  Ophiuchus
//
//  Created by Nick on 8/11/25.
//

import Foundation

public struct ListFactory_Groups {
    
    
    private(set) static var flexerGroupList = [ExploderGroup<Flexer>]()
    private(set) static var flexerGroupListCount = 0
    private(set) static var flexerGroupListSize = 0
    
    static func flexerGroupListReset() {
        flexerGroupListCount = 0
    }
    
    static func flexerGroupListAdd(flexerGroup: ExploderGroup<Flexer>) {
        if flexerGroupListCount >= flexerGroupListSize {
            flexerGroupListSize = flexerGroupListCount + (flexerGroupListCount >> 1) + 1   // ~1.5x; bump to 2x if you want “explosive”
            flexerGroupList.reserveCapacity(flexerGroupListSize)
            while flexerGroupList.count < flexerGroupListSize {
                flexerGroupList.append(flexerGroup)
            }
        }
        flexerGroupList[flexerGroupListCount] = flexerGroup
        flexerGroupListCount += 1
    }
    
    static func flexerGroupListSwap() {
        flexerGroupListReset()
        for flexerIndex in 0..<tempFlexerGroupListCount {
            let flexerGroup = tempFlexerGroupList[flexerIndex]
            flexerGroupListAdd(flexerGroup: flexerGroup)
        }
        tempFlexerGroupListReset()
    }
    
    private(set) static var tempFlexerGroupList = [ExploderGroup<Flexer>]()
    private(set) static var tempFlexerGroupListCount = 0
    private(set) static var tempFlexerGroupListSize = 0
    
    static func tempFlexerGroupListReset() {
        tempFlexerGroupListCount = 0
    }
    
    static func tempFlexerGroupListAdd(flexerGroup: ExploderGroup<Flexer>) {
        if tempFlexerGroupListCount >= tempFlexerGroupListSize {
            tempFlexerGroupListSize = tempFlexerGroupListCount + (tempFlexerGroupListCount >> 1) + 1
            tempFlexerGroupList.reserveCapacity(tempFlexerGroupListSize)
            while tempFlexerGroupList.count < tempFlexerGroupListSize {
                tempFlexerGroupList.append(flexerGroup)
            }
        }
        tempFlexerGroupList[tempFlexerGroupListCount] = flexerGroup
        tempFlexerGroupListCount += 1
    }
    
    
    
    
    
    
    
    
    
    private(set) static var pieceGroupList = [ExploderGroup<SkeletonPiece>]()
    private(set) static var pieceGroupListCount = 0
    private(set) static var pieceGroupListSize = 0
    
    static func pieceGroupListReset() {
        pieceGroupListCount = 0
    }
    
    static func pieceGroupListAdd(pieceGroup: ExploderGroup<SkeletonPiece>) {
        if pieceGroupListCount >= pieceGroupListSize {
            pieceGroupListSize = pieceGroupListCount + (pieceGroupListCount >> 1) + 1   // ~1.5x; bump to 2x if you want “explosive”
            pieceGroupList.reserveCapacity(pieceGroupListSize)
            while pieceGroupList.count < pieceGroupListSize {
                pieceGroupList.append(pieceGroup)
            }
        }
        pieceGroupList[pieceGroupListCount] = pieceGroup
        pieceGroupListCount += 1
    }
    
    static func pieceGroupListSwap() {
        pieceGroupListReset()
        for pieceIndex in 0..<tempPieceGroupListCount {
            let pieceGroup = tempPieceGroupList[pieceIndex]
            pieceGroupListAdd(pieceGroup: pieceGroup)
        }
        tempPieceGroupListReset()
    }
    
    private(set) static var tempPieceGroupList = [ExploderGroup<SkeletonPiece>]()
    private(set) static var tempPieceGroupListCount = 0
    private(set) static var tempPieceGroupListSize = 0
    
    static func tempPieceGroupListReset() {
        tempPieceGroupListCount = 0
    }
    
    static func tempPieceGroupListAdd(pieceGroup: ExploderGroup<SkeletonPiece>) {
        if tempPieceGroupListCount >= tempPieceGroupListSize {
            tempPieceGroupListSize = tempPieceGroupListCount + (tempPieceGroupListCount >> 1) + 1
            tempPieceGroupList.reserveCapacity(tempPieceGroupListSize)
            while tempPieceGroupList.count < tempPieceGroupListSize {
                tempPieceGroupList.append(pieceGroup)
            }
        }
        tempPieceGroupList[tempPieceGroupListCount] = pieceGroup
        tempPieceGroupListCount += 1
    }
    
    
    
    
    
    
    
    
    private(set) static var nodeGroupList = [ExploderGroup<WiseLayoutNode>]()
    private(set) static var nodeGroupListCount = 0
    private(set) static var nodeGroupListSize = 0
    
    static func nodeGroupListReset() {
        nodeGroupListCount = 0
    }
    
    static func nodeGroupListAdd(nodeGroup: ExploderGroup<WiseLayoutNode>) {
        if nodeGroupListCount >= nodeGroupListSize {
            nodeGroupListSize = nodeGroupListCount + (nodeGroupListCount >> 1) + 1   // ~1.5x; bump to 2x if you want “explosive”
            nodeGroupList.reserveCapacity(nodeGroupListSize)
            while nodeGroupList.count < nodeGroupListSize {
                nodeGroupList.append(nodeGroup)
            }
        }
        nodeGroupList[nodeGroupListCount] = nodeGroup
        nodeGroupListCount += 1
    }
    
    static func nodeGroupListSwap() {
        nodeGroupListReset()
        for nodeIndex in 0..<tempNodeGroupListCount {
            let nodeGroup = tempNodeGroupList[nodeIndex]
            nodeGroupListAdd(nodeGroup: nodeGroup)
        }
        tempNodeGroupListReset()
    }
    
    private(set) static var tempNodeGroupList = [ExploderGroup<WiseLayoutNode>]()
    private(set) static var tempNodeGroupListCount = 0
    private(set) static var tempNodeGroupListSize = 0
    
    static func tempNodeGroupListReset() {
        tempNodeGroupListCount = 0
    }
    
    static func tempNodeGroupListAdd(nodeGroup: ExploderGroup<WiseLayoutNode>) {
        if tempNodeGroupListCount >= tempNodeGroupListSize {
            tempNodeGroupListSize = tempNodeGroupListCount + (tempNodeGroupListCount >> 1) + 1
            tempNodeGroupList.reserveCapacity(tempNodeGroupListSize)
            while tempNodeGroupList.count < tempNodeGroupListSize {
                tempNodeGroupList.append(nodeGroup)
            }
        }
        tempNodeGroupList[tempNodeGroupListCount] = nodeGroup
        tempNodeGroupListCount += 1
    }
    
    
    
    private(set) static var sectionList = [SkeletonSection]()
    private(set) static var sectionListCount = 0
    private(set) static var sectionListSize = 0

    static func sectionListReset() {
        sectionListCount = 0
    }

    static func sectionListAdd(section: SkeletonSection) {
        if sectionListCount >= sectionListSize {
            sectionListSize = sectionListCount + (sectionListCount >> 1) + 1   // ~1.5x; bump to 2x if you want “explosive”
            sectionList.reserveCapacity(sectionListSize)
            while sectionList.count < sectionListSize {
                sectionList.append(section)
            }
        }
        sectionList[sectionListCount] = section
        sectionListCount += 1
    }

    static func sectionListSwap() {
        sectionListReset()
        for sectionIndex in 0..<tempSectionListCount {
            let section = tempSectionList[sectionIndex]
            sectionListAdd(section: section)
        }
        tempSectionListReset()
    }

    private(set) static var tempSectionList = [SkeletonSection]()
    private(set) static var tempSectionListCount = 0
    private(set) static var tempSectionListSize = 0

    static func tempSectionListReset() {
        tempSectionListCount = 0
    }

    static func tempSectionListAdd(section: SkeletonSection) {
        if tempSectionListCount >= tempSectionListSize {
            tempSectionListSize = tempSectionListCount + (tempSectionListCount >> 1) + 1
            tempSectionList.reserveCapacity(tempSectionListSize)
            while tempSectionList.count < tempSectionListSize {
                tempSectionList.append(section)
            }
        }
        tempSectionList[tempSectionListCount] = section
        tempSectionListCount += 1
    }
    
}
