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
    private(set) static var flexerGroupTargetCapacity = 0
    
    static func flexerGroupListReset() {
        flexerGroupList.removeAll(keepingCapacity: true)
        flexerGroupListCount = 0
        // keep flexerGroupTargetCapacity so we reuse capacity next pass
    }
    
    static func flexerGroupListAdd(flexerGroup: ExploderGroup<Flexer>) {
        if flexerGroupList.count >= flexerGroupTargetCapacity {
            let n = flexerGroupList.count
            flexerGroupTargetCapacity = n + (n >> 1) + 1   // ~1.5x; bump to 2x if you want “explosive”
            flexerGroupList.reserveCapacity(flexerGroupTargetCapacity)
        }
        flexerGroupList.append(flexerGroup)
        flexerGroupListCount = flexerGroupList.count
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
    private(set) static var tempFlexerGroupTargetCapacity = 0
    
    static func tempFlexerGroupListReset() {
        tempFlexerGroupList.removeAll(keepingCapacity: true)
        tempFlexerGroupListCount = 0
    }
    
    static func tempFlexerGroupListAdd(tempFlexerGroup: ExploderGroup<Flexer>) {
        if tempFlexerGroupList.count >= tempFlexerGroupTargetCapacity {
            let n = tempFlexerGroupList.count
            tempFlexerGroupTargetCapacity = n + (n >> 1) + 1
            tempFlexerGroupList.reserveCapacity(tempFlexerGroupTargetCapacity)
        }
        tempFlexerGroupList.append(tempFlexerGroup)
        tempFlexerGroupListCount = tempFlexerGroupList.count
    }
    
    
    
    
    
    
    private(set) static var pieceGroupList = [ExploderGroup<SkeletonPiece>]()
    private(set) static var pieceGroupListCount = 0
    private(set) static var pieceGroupTargetCapacity = 0
    
    static func pieceGroupListReset() {
        pieceGroupList.removeAll(keepingCapacity: true)
        pieceGroupListCount = 0
        // keep pieceGroupTargetCapacity so we reuse capacity next pass
    }
    
    static func pieceGroupListAdd(pieceGroup: ExploderGroup<SkeletonPiece>) {
        if pieceGroupList.count >= pieceGroupTargetCapacity {
            let n = pieceGroupList.count
            pieceGroupTargetCapacity = n + (n >> 1) + 1   // ~1.5x; bump to 2x if you want “explosive”
            pieceGroupList.reserveCapacity(pieceGroupTargetCapacity)
        }
        pieceGroupList.append(pieceGroup)
        pieceGroupListCount = pieceGroupList.count
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
    private(set) static var tempPieceGroupTargetCapacity = 0
    
    static func tempPieceGroupListReset() {
        tempPieceGroupList.removeAll(keepingCapacity: true)
        tempPieceGroupListCount = 0
    }
    
    static func tempPieceGroupListAdd(pieceGroup: ExploderGroup<SkeletonPiece>) {
        if tempPieceGroupList.count >= tempPieceGroupTargetCapacity {
            let n = tempPieceGroupList.count
            tempPieceGroupTargetCapacity = n + (n >> 1) + 1
            tempPieceGroupList.reserveCapacity(tempPieceGroupTargetCapacity)
        }
        tempPieceGroupList.append(pieceGroup)
        tempPieceGroupListCount = tempPieceGroupList.count
    }
    
    
    
    
    
    
    
    
    private(set) static var nodeGroupList = [ExploderGroup<WiseLayoutNode>]()
    private(set) static var nodeGroupListCount = 0
    private(set) static var nodeGroupTargetCapacity = 0
    
    static func nodeGroupListReset() {
        nodeGroupList.removeAll(keepingCapacity: true)
        nodeGroupListCount = 0
        // keep nodeGroupTargetCapacity so we reuse capacity next pass
    }
    
    static func nodeGroupListAdd(nodeGroup: ExploderGroup<WiseLayoutNode>) {
        if nodeGroupList.count >= nodeGroupTargetCapacity {
            let n = nodeGroupList.count
            nodeGroupTargetCapacity = n + (n >> 1) + 1   // ~1.5x; bump to 2x if you want “explosive”
            nodeGroupList.reserveCapacity(nodeGroupTargetCapacity)
        }
        nodeGroupList.append(nodeGroup)
        nodeGroupListCount = nodeGroupList.count
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
    private(set) static var tempNodeGroupTargetCapacity = 0
    
    static func tempNodeGroupListReset() {
        tempNodeGroupList.removeAll(keepingCapacity: true)
        tempNodeGroupListCount = 0
    }
    
    static func tempNodeGroupListAdd(tempNodeGroup: ExploderGroup<WiseLayoutNode>) {
        if tempNodeGroupList.count >= tempNodeGroupTargetCapacity {
            let n = tempNodeGroupList.count
            tempNodeGroupTargetCapacity = n + (n >> 1) + 1
            tempNodeGroupList.reserveCapacity(tempNodeGroupTargetCapacity)
        }
        tempNodeGroupList.append(tempNodeGroup)
        tempNodeGroupListCount = tempNodeGroupList.count
    }
    
    
    
    private(set) static var sectionList = [SkeletonSection]()
    private(set) static var sectionListCount = 0
    private(set) static var sectionTargetCapacity = 0
    
    static func sectionListReset() {
        sectionList.removeAll(keepingCapacity: true)
        sectionListCount = 0
        // keep sectionTargetCapacity so we reuse capacity next pass
    }
    
    static func sectionListAdd(section: SkeletonSection) {
        if sectionList.count >= sectionTargetCapacity {
            let n = sectionList.count
            sectionTargetCapacity = n + (n >> 1) + 1   // ~1.5x; bump to 2x if you want “explosive”
            sectionList.reserveCapacity(sectionTargetCapacity)
        }
        sectionList.append(section)
        sectionListCount = sectionList.count
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
    private(set) static var tempSectionTargetCapacity = 0
    
    static func tempSectionListReset() {
        tempSectionList.removeAll(keepingCapacity: true)
        tempSectionListCount = 0
    }
    
    static func tempSectionListAdd(tempSection: SkeletonSection) {
        if tempSectionList.count >= tempSectionTargetCapacity {
            let n = tempSectionList.count
            tempSectionTargetCapacity = n + (n >> 1) + 1
            tempSectionList.reserveCapacity(tempSectionTargetCapacity)
        }
        tempSectionList.append(tempSection)
        tempSectionListCount = tempSectionList.count
    }
    
    
}
