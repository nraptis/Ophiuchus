//
//  SortTestsFast.swift
//  OphiuchusTests
//
//  Created by Nick on 8/8/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct SortTests {
    
    func flexerGroupFromSize(_ size: Int) -> ExploderGroup<Flexer> {
        let result = ExploderGroup<Flexer>(linkedList: [], layoutPriority: .low)
        result.growSize = size
        return result
    }
    
    @MainActor @Test func test_sort_smalls_flexer() {

        
        for _ in 0..<250000 {
            
            let count = Int.random(in: 0...8)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -10...10))
            }
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetFlexerGroupList()
            for i in 0..<count {
                let group = flexerGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addFlexerGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortFlexerGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.flexerGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.flexerGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
        
        
    }
    
    @MainActor @Test func test_sort_meds_a_flexer() {

        
        for _ in 0..<120000 {
            
            let count = Int.random(in: 0..<120)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -8...8))
            }
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetFlexerGroupList()
            for i in 0..<count {
                let group = flexerGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addFlexerGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortFlexerGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.flexerGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.flexerGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
    }
    
    @MainActor @Test func test_sort_meds_b_flexer() {

        
        for _ in 0..<75000 {
            
            let count = Int.random(in: 0..<160)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -120...120))
            }
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetFlexerGroupList()
            for i in 0..<count {
                let group = flexerGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addFlexerGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortFlexerGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.flexerGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.flexerGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
    }
    
    
    
    
    func pieceGroupFromSize(_ size: Int) -> ExploderGroup<SkeletonPiece> {
        let result = ExploderGroup<SkeletonPiece>(linkedList: [], layoutPriority: .low)
        result.growSize = size
        return result
    }
    
    @MainActor @Test func test_sort_smalls_piece() {
        
        for _ in 0..<250000 {
            
            let count = Int.random(in: 0...8)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -10...10))
            }
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetPieceGroupList()
            for i in 0..<count {
                let group = pieceGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addPieceGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortPieceGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.pieceGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.pieceGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
        
        
    }
    
    @MainActor @Test func test_sort_meds_a_piece() {
        
        for _ in 0..<120000 {
            
            let count = Int.random(in: 0..<120)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -8...8))
            }
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetPieceGroupList()
            for i in 0..<count {
                let group = pieceGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addPieceGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortPieceGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.pieceGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.pieceGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
    }
    
    @MainActor @Test func test_sort_meds_b_piece() {
        
        
        for _ in 0..<75000 {
            
            let count = Int.random(in: 0..<160)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -120...120))
            }
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetPieceGroupList()
            for i in 0..<count {
                let group = pieceGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addPieceGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortPieceGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.pieceGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.pieceGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
    }
    
    
    
    func chunkGroupFromSize(_ size: Int) -> ExploderGroup<SkeletonChunk> {
        let result = ExploderGroup<SkeletonChunk>(linkedList: [], layoutPriority: .low)
        result.growSize = size
        return result
    }
    
    @MainActor @Test func test_sort_smalls_chunk() {
        
        
        for _ in 0..<250000 {
            
            let count = Int.random(in: 0...8)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -10...10))
            }
            
            
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetChunkGroupList()
            for i in 0..<count {
                let group = chunkGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addChunkGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortChunkGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.chunkGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.chunkGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
        
        
    }
    
    @MainActor @Test func test_sort_meds_a_chunk() {
        
        
        for _ in 0..<120000 {
            
            let count = Int.random(in: 0..<120)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -8...8))
            }
            
            
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetChunkGroupList()
            for i in 0..<count {
                let group = chunkGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addChunkGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortChunkGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.chunkGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.chunkGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
    }
    
    @MainActor @Test func test_sort_meds_b_chunk() {
        
        
        for _ in 0..<75000 {
            
            let count = Int.random(in: 0..<160)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -120...120))
            }
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetChunkGroupList()
            for i in 0..<count {
                let group = chunkGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addChunkGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortChunkGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.chunkGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.chunkGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
    }
    
    
    
    
    func nodeGroupFromSize(_ size: Int) -> ExploderGroup<SkeletonNode> {
        let result = ExploderGroup<SkeletonNode>(linkedList: [], layoutPriority: .low)
        result.growSize = size
        return result
    }
    
    @MainActor @Test func test_sort_smalls_node() {
        
        
        for _ in 0..<250000 {
            
            let count = Int.random(in: 0...8)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -10...10))
            }
            
            
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetNodeGroupList()
            for i in 0..<count {
                let group = nodeGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addNodeGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortNodeGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.nodeGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.nodeGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
        
        
    }
    
    @MainActor @Test func test_sort_meds_a_node() {
        
        
        for _ in 0..<120000 {
            
            let count = Int.random(in: 0..<120)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -8...8))
            }
            
            
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetNodeGroupList()
            for i in 0..<count {
                let group = nodeGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addNodeGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortNodeGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.nodeGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.nodeGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
    }
    
    @MainActor @Test func test_sort_meds_b_node() {
        
        
        for _ in 0..<75000 {
            
            let count = Int.random(in: 0..<160)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -120...120))
            }
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetNodeGroupList()
            for i in 0..<count {
                let group = nodeGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addNodeGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortNodeGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.nodeGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.nodeGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
    }
    
    
    
    
    
    func sectionGroupFromSize(_ size: Int) -> ExploderGroup<SkeletonSection> {
        let result = ExploderGroup<SkeletonSection>(linkedList: [], layoutPriority: .low)
        result.growSize = size
        return result
    }
    
    @MainActor @Test func test_sort_smalls_section() {
        
        
        for _ in 0..<250000 {
            
            let count = Int.random(in: 0...8)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -10...10))
            }
            
            
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetSectionGroupList()
            for i in 0..<count {
                let group = sectionGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addSectionGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortSectionGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.sectionGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.sectionGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
        
        
    }
    
    @MainActor @Test func test_sort_meds_a_section() {
        
        
        for _ in 0..<120000 {
            
            let count = Int.random(in: 0..<120)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -8...8))
            }
            
            
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetSectionGroupList()
            for i in 0..<count {
                let group = sectionGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addSectionGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortSectionGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.sectionGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.sectionGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
    }
    
    @MainActor @Test func test_sort_meds_b_section() {
        
        
        for _ in 0..<75000 {
            
            let count = Int.random(in: 0..<160)
            var sizes = [Int]()
            for _ in 0..<count {
                sizes.append(Int.random(in: -120...120))
            }
            
            FlexerSkeletonLayoutSortedGroupListFactory.resetSectionGroupList()
            for i in 0..<count {
                let group = sectionGroupFromSize(sizes[i])
                FlexerSkeletonLayoutSortedGroupListFactory.addSectionGroupUnique(group)
            }
            FlexerSkeletonLayoutSortedGroupListFactory.sortSectionGroups()
            
            sizes.sort()
            
            for i in 0..<count {
                if FlexerSkeletonLayoutSortedGroupListFactory.sectionGroupList[i].growSize != sizes[i] {
                    #expect(Bool(false))
                    print("list: \(sizes) failed")
                    
                    for j in 0..<count {
                        print("gl[\(j)] = \(FlexerSkeletonLayoutSortedGroupListFactory.sectionGroupList[j].growSize)")
                    }
                    
                    return
                }
            }
        }
    }
    
}
