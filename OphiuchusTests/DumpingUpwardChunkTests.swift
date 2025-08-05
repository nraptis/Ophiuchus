//
//  DumpingUpwardNodeTests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/2/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct DumpingUpwardChunkTests {
    
    @MainActor @Test func test_group_chunk_1_node_1_chunk() {
        
        let chunk_a = GenerateChunks.generate_fixed(size: 10)
        let node_a = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
        
        let section = GenerateSections.generate_section(skeleton_node: node_a)
        let row = GenerateRows.generate_Row(section: section)
        
        let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: [chunk_a], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                 chunkListCount: chunkGroup.linkedList.count,
                                                                 elementAmountList: SkeletonLayoutGrowthPlanTool.chunkAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.nodeListCount == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.nodeList[0] === node_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[0][0] === chunk_a else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_chunk_1_node_2_chunk() {
        let chunk_a = GenerateChunks.generate_fixed(size: 10)
        let chunk_b = GenerateChunks.generate_fixed(size: 10)
        let node_a = GenerateNodes.generate_skeleton_node(chunks: [chunk_a, chunk_b])
        let section = GenerateSections.generate_section(skeleton_nodes: [node_a])
        let row = GenerateRows.generate_Row(section: section)
        let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: [chunk_a, chunk_b], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                 chunkListCount: chunkGroup.linkedList.count,
                                                                 elementAmountList: SkeletonLayoutGrowthPlanTool.chunkAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.nodeListCount == 1 else {
            #expect(Bool(false))
            return
        }
        
        guard SkeletonLayoutGrowthPlanTool.nodeList[0] === node_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkListCount[0] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[0][0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[0][1] === chunk_b else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_chunk_1_node_3_chunk() {
        let chunk_a = GenerateChunks.generate_fixed(size: 10)
        let chunk_b = GenerateChunks.generate_fixed(size: 10)
        let chunk_c = GenerateChunks.generate_fixed(size: 10)
        
        let node_a = GenerateNodes.generate_skeleton_node(chunks: [chunk_a, chunk_b, chunk_c])
        let section = GenerateSections.generate_section(skeleton_nodes: [node_a])
        let row = GenerateRows.generate_Row(section: section)
        let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: [chunk_a, chunk_b, chunk_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                 chunkListCount: chunkGroup.linkedList.count,
                                                                 elementAmountList: SkeletonLayoutGrowthPlanTool.chunkAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.nodeListCount == 1 else {
            #expect(Bool(false))
            return
        }
        
        guard SkeletonLayoutGrowthPlanTool.nodeList[0] === node_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkListCount[0] == 3 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[0][0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[0][1] === chunk_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[0][2] === chunk_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_chunk_2_node_2_chunk() {
        
        let chunk_a = GenerateChunks.generate_fixed(size: 10)
        let node_a = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
        
        let chunk_b = GenerateChunks.generate_fixed(size: 10)
        let node_b = GenerateNodes.generate_skeleton_node(chunk: chunk_b)
        
        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b])
        let row = GenerateRows.generate_Row(section: section)
        let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: [chunk_a, chunk_b], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                 chunkListCount: chunkGroup.linkedList.count,
                                                                 elementAmountList: SkeletonLayoutGrowthPlanTool.chunkAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.nodeListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.nodeList[0] === node_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.nodeList[1] === node_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkListCount[1] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[0][0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[1][0] === chunk_b else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_chunk_2_node_3_chunk_a() {
        
        let chunk_a = GenerateChunks.generate_fixed(size: 10)
        let chunk_b = GenerateChunks.generate_fixed(size: 10)
        let node_a = GenerateNodes.generate_skeleton_node(chunks: [chunk_a, chunk_b])
        
        let chunk_c = GenerateChunks.generate_fixed(size: 10)
        let node_b = GenerateNodes.generate_skeleton_node(chunk: chunk_c)
        
        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b])
        let row = GenerateRows.generate_Row(section: section)
        let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: [chunk_a, chunk_b, chunk_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                 chunkListCount: chunkGroup.linkedList.count,
                                                                 elementAmountList: SkeletonLayoutGrowthPlanTool.chunkAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.nodeListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.nodeList[0] === node_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.nodeList[1] === node_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkListCount[0] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkListCount[1] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[0][0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[0][1] === chunk_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[1][0] === chunk_c else {
            #expect(Bool(false))
            return
        }
    }
    
    
    @MainActor @Test func test_group_chunk_2_node_3_chunk_b() {
        
        let chunk_a = GenerateChunks.generate_fixed(size: 10)
        let node_a = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
        
        let chunk_b = GenerateChunks.generate_fixed(size: 10)
        let chunk_c = GenerateChunks.generate_fixed(size: 10)
        let node_b = GenerateNodes.generate_skeleton_node(chunks: [chunk_b, chunk_c])
        
        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b])
        let row = GenerateRows.generate_Row(section: section)
        let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: [chunk_a, chunk_b, chunk_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                 chunkListCount: chunkGroup.linkedList.count,
                                                                 elementAmountList: SkeletonLayoutGrowthPlanTool.chunkAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.nodeListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.nodeList[0] === node_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.nodeList[1] === node_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkListCount[1] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[0][0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[1][0] === chunk_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedChunkList[1][1] === chunk_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_several_small_groups_512() {
        
        for _ in 0..<512 {
            
            let nodeCount = Int.random(in: 0...4)
            var node_list = [SkeletonNode]()
            var chunk_list = [SkeletonChunk]()
            
            for _ in 0..<nodeCount {
                let chunkCount = Int.random(in: 0...4)
                for _ in 0..<chunkCount {
                    let which = Int.random(in: 0...3)
                    if which == 0 {
                        let chunk_a = GenerateChunks.generate_fixed(size: 10)
                        let node = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
                        chunk_list.append(chunk_a)
                        node_list.append(node)
                    } else if which == 1 {
                        let chunk_a = GenerateChunks.generate_fixed(size: 10)
                        let chunk_b = GenerateChunks.generate_fixed(size: 10)
                        let node = GenerateNodes.generate_skeleton_node(chunks: [chunk_a, chunk_b])
                        chunk_list.append(chunk_a)
                        chunk_list.append(chunk_b)
                        node_list.append(node)
                    } else if which == 2 {
                        let chunk_a = GenerateChunks.generate_fixed(size: 10)
                        let chunk_b = GenerateChunks.generate_fixed(size: 10)
                        let chunk_c = GenerateChunks.generate_fixed(size: 10)
                        let node = GenerateNodes.generate_skeleton_node(chunks: [chunk_a, chunk_b, chunk_c])
                        chunk_list.append(chunk_a)
                        chunk_list.append(chunk_b)
                        chunk_list.append(chunk_c)
                        node_list.append(node)
                    } else {
                        let chunk_a = GenerateChunks.generate_fixed(size: 10)
                        let chunk_b = GenerateChunks.generate_fixed(size: 10)
                        let chunk_c = GenerateChunks.generate_fixed(size: 10)
                        let chunk_d = GenerateChunks.generate_fixed(size: 10)
                        let node = GenerateNodes.generate_skeleton_node(chunks: [chunk_a, chunk_b, chunk_c, chunk_d])
                        chunk_list.append(chunk_a)
                        chunk_list.append(chunk_b)
                        chunk_list.append(chunk_c)
                        chunk_list.append(chunk_d)
                        
                        node_list.append(node)
                    }
                }
            }
            
            let section = GenerateSections.generate_section(skeleton_nodes: node_list)
            let row = GenerateRows.generate_Row(section: section)
            let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: chunk_list, layoutPriority: .required)
            _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                     chunkListCount: chunkGroup.linkedList.count,
                                                                     elementAmountList: SkeletonLayoutGrowthPlanTool.chunkAmountList)
            
            guard SkeletonLayoutGrowthPlanTool.nodeListCount == node_list.count else {
                #expect(Bool(false))
                return
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.nodeListCount {
                guard SkeletonLayoutGrowthPlanTool.nodeList[index] === node_list[index] else {
                    #expect(Bool(false))
                    return
                }
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.nodeListCount {
                guard SkeletonLayoutGrowthPlanTool.groupedChunkListCount[index] == node_list[index].chunks.count else {
                    #expect(Bool(false))
                    return
                }
                
                for chunk_index in 0..<SkeletonLayoutGrowthPlanTool.groupedChunkListCount[index] {
                    let chunk_1 = SkeletonLayoutGrowthPlanTool.groupedChunkList[index][chunk_index]
                    let chunk_2 = node_list[index].chunks[chunk_index]
                    guard chunk_1 === chunk_2 else {
                        #expect(Bool(false))
                        return
                    }
                    
                }
            }
        }
    }
    
    @MainActor @Test func test_group_several_medium_groups_4096() {
        
        var invalid_tests = 0
        var valid_tests = 0
        
        for _ in 0..<4096 {
            
            let nodeCount = Int.random(in: 0...8)
            var node_list = [SkeletonNode]()
            var chunk_list = [SkeletonChunk]()
            
            for _ in 0..<nodeCount {
                let chunkCount = Int.random(in: 0...8)
                
                valid_tests += 1
                
                for _ in 0..<chunkCount {
                    let which = Int.random(in: 0...3)
                    if which == 0 {
                        let chunk_a = GenerateChunks.generate_fixed(size: 10)
                        let node = GenerateNodes.generate_skeleton_node(chunk: chunk_a)
                        chunk_list.append(chunk_a)
                        node_list.append(node)
                    } else if which == 1 {
                        let chunk_a = GenerateChunks.generate_fixed(size: 10)
                        let chunk_b = GenerateChunks.generate_fixed(size: 10)
                        let node = GenerateNodes.generate_skeleton_node(chunks: [chunk_a, chunk_b])
                        chunk_list.append(chunk_a)
                        chunk_list.append(chunk_b)
                        node_list.append(node)
                    } else if which == 2 {
                        let chunk_a = GenerateChunks.generate_fixed(size: 10)
                        let chunk_b = GenerateChunks.generate_fixed(size: 10)
                        let chunk_c = GenerateChunks.generate_fixed(size: 10)
                        let node = GenerateNodes.generate_skeleton_node(chunks: [chunk_a, chunk_b, chunk_c])
                        chunk_list.append(chunk_a)
                        chunk_list.append(chunk_b)
                        chunk_list.append(chunk_c)
                        node_list.append(node)
                    } else {
                        let chunk_a = GenerateChunks.generate_fixed(size: 10)
                        let chunk_b = GenerateChunks.generate_fixed(size: 10)
                        let chunk_c = GenerateChunks.generate_fixed(size: 10)
                        let chunk_d = GenerateChunks.generate_fixed(size: 10)
                        let node = GenerateNodes.generate_skeleton_node(chunks: [chunk_a, chunk_b, chunk_c, chunk_d])
                        chunk_list.append(chunk_a)
                        chunk_list.append(chunk_b)
                        chunk_list.append(chunk_c)
                        chunk_list.append(chunk_d)
                        node_list.append(node)
                    }
                }
            }
            
            let section = GenerateSections.generate_section(skeleton_nodes: node_list)
            let row = GenerateRows.generate_Row(section: section)
            let chunkGroup = ExploderGroup<SkeletonChunk>(linkedList: chunk_list, layoutPriority: .required)
            _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForChunks(chunkList: chunkGroup.linkedList,
                                                                     chunkListCount: chunkGroup.linkedList.count,
                                                                     elementAmountList: SkeletonLayoutGrowthPlanTool.chunkAmountList)
            
            guard SkeletonLayoutGrowthPlanTool.nodeListCount == node_list.count else {
                #expect(Bool(false))
                return
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.nodeListCount {
                guard SkeletonLayoutGrowthPlanTool.nodeList[index] === node_list[index] else {
                    #expect(Bool(false))
                    return
                }
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.nodeListCount {
                guard SkeletonLayoutGrowthPlanTool.groupedChunkListCount[index] == node_list[index].chunks.count else {
                    #expect(Bool(false))
                    return
                }
                
                for chunk_index in 0..<SkeletonLayoutGrowthPlanTool.groupedChunkListCount[index] {
                    let chunk_1 = SkeletonLayoutGrowthPlanTool.groupedChunkList[index][chunk_index]
                    let chunk_2 = node_list[index].chunks[chunk_index]
                    guard chunk_1 === chunk_2 else {
                        #expect(Bool(false))
                        return
                    }
                    
                }
            }
        }
        
        print("Test chunks medium done! (\(invalid_tests) invalid tests and \(valid_tests) valid tests)")
        
    }
    
}
