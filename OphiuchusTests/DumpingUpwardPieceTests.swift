//
//  DumpingUpwardFlexerTests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/1/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct DumpingUpwardFlexerTests {
    
    @MainActor @Test func test_group_flexer_1_chunk_1_flexer() {
        
        let flexer_a = GenerateFlexers.generate_flexer(100)
        let chunk_a = GenerateChunks.generate_flexer(flexer: flexer_a)
        let node = GenerateNodes.generate_node(chunks: [chunk_a])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[0][0] === flexer_a else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_flexer_1_chunk_2_flexer() {
        let flexer_a = GenerateFlexers.generate_flexer(100)
        let flexer_b = GenerateFlexers.generate_flexer(100)
        let chunk_a = GenerateChunks.generate_flexer_two(flexer1: flexer_a, flexer2: flexer_b)
        let node = GenerateNodes.generate_node(chunks: [chunk_a])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a, flexer_b], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 1 else {
            #expect(Bool(false))
            return
        }
        
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[0] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[0][0] === flexer_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[0][1] === flexer_b else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_flexer_1_chunk_3_flexer() {
        let flexer_a = GenerateFlexers.generate_flexer(100)
        let flexer_b = GenerateFlexers.generate_flexer(100)
        let flexer_c = GenerateFlexers.generate_flexer(100)
        
        let chunk_a = GenerateChunks.generate_flexer_three(flexer1: flexer_a, flexer2: flexer_b, flexer3: flexer_c)
        let node = GenerateNodes.generate_node(chunks: [chunk_a])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a, flexer_b, flexer_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 1 else {
            #expect(Bool(false))
            return
        }
        
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[0] == 3 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[0][0] === flexer_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[0][1] === flexer_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[0][2] === flexer_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_flexer_2_chunk_2_flexer() {
        
        let flexer_a = GenerateFlexers.generate_flexer(100)
        let chunk_a = GenerateChunks.generate_flexer(flexer: flexer_a)
        
        let flexer_b = GenerateFlexers.generate_flexer(100)
        let chunk_b = GenerateChunks.generate_flexer(flexer: flexer_b)
        
        let node = GenerateNodes.generate_node(chunks: [chunk_a, chunk_b])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a, flexer_b], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[1] === chunk_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[1] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[0][0] === flexer_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[1][0] === flexer_b else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_flexer_2_chunk_3_flexer_a() {
        
        let flexer_a = GenerateFlexers.generate_flexer(100)
        let flexer_b = GenerateFlexers.generate_flexer(100)
        let chunk_a = GenerateChunks.generate_flexer_two(flexer1: flexer_a, flexer2: flexer_b)
        
        let flexer_c = GenerateFlexers.generate_flexer(100)
        let chunk_b = GenerateChunks.generate_flexer(flexer: flexer_c)
        
        let node = GenerateNodes.generate_node(chunks: [chunk_a, chunk_b])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a, flexer_b, flexer_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[1] === chunk_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[0] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[1] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[0][0] === flexer_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[0][1] === flexer_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[1][0] === flexer_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_flexer_2_chunk_3_flexer_b() {
        
        let flexer_a = GenerateFlexers.generate_flexer(100)
        let chunk_a = GenerateChunks.generate_flexer(flexer: flexer_a)
        
        let flexer_b = GenerateFlexers.generate_flexer(100)
        let flexer_c = GenerateFlexers.generate_flexer(100)
        let chunk_b = GenerateChunks.generate_flexer_two(flexer1: flexer_b, flexer2: flexer_c)
        
        let node = GenerateNodes.generate_node(chunks: [chunk_a, chunk_b])
        let section = GenerateSections.generate_section(node: node)
        let row = GenerateRows.generate_Row(section: section)
        let flexerGroup = ExploderGroup<Flexer>(linkedList: [flexer_a, flexer_b, flexer_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
        
        guard SkeletonLayoutGrowthPlanTool.chunkListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[0] === chunk_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.chunkList[1] === chunk_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[1] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[0][0] === flexer_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[1][0] === flexer_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedFlexerList[1][1] === flexer_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_several_small_groups_512() {
        
        for _ in 0..<512 {
            
            let chunkCount = Int.random(in: 0...4)
            var chunk_list = [SkeletonChunk]()
            var flexer_list = [Flexer]()
            
            for _ in 0..<chunkCount {
                let flexerCount = Int.random(in: 0...4)
                for _ in 0..<flexerCount {
                    let which = Int.random(in: 0...2)
                    if which == 0 {
                        let flexer_a = GenerateFlexers.generate_flexer(100)
                        let chunk = GenerateChunks.generate_flexer(flexer: flexer_a)
                        flexer_list.append(flexer_a)
                        chunk_list.append(chunk)
                    } else if which == 1 {
                        let flexer_a = GenerateFlexers.generate_flexer(100)
                        let flexer_b = GenerateFlexers.generate_flexer(100)
                        let chunk = GenerateChunks.generate_flexer_two(flexer1: flexer_a, flexer2: flexer_b)
                        flexer_list.append(flexer_a)
                        flexer_list.append(flexer_b)
                        chunk_list.append(chunk)
                    } else {
                        let flexer_a = GenerateFlexers.generate_flexer(100)
                        let flexer_b = GenerateFlexers.generate_flexer(100)
                        let flexer_c = GenerateFlexers.generate_flexer(100)
                        let chunk = GenerateChunks.generate_flexer_three(flexer1: flexer_a, flexer2: flexer_b, flexer3: flexer_c)
                        flexer_list.append(flexer_a)
                        flexer_list.append(flexer_b)
                        flexer_list.append(flexer_c)
                        chunk_list.append(chunk)
                    }
                }
            }
            
            let node = GenerateNodes.generate_node(chunks: chunk_list)
            let section = GenerateSections.generate_section(node: node)
            let row = GenerateRows.generate_Row(section: section)
            let flexerGroup = ExploderGroup<Flexer>(linkedList: flexer_list, layoutPriority: .required)
            _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
            
            guard SkeletonLayoutGrowthPlanTool.chunkListCount == chunk_list.count else {
                #expect(Bool(false))
                return
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
                guard SkeletonLayoutGrowthPlanTool.chunkList[index] === chunk_list[index] else {
                    #expect(Bool(false))
                    return
                }
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
                guard SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[index] == chunk_list[index].flexers.count else {
                    #expect(Bool(false))
                    return
                }
                
                for flexer_index in 0..<SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[index] {
                    let flexer_1 = SkeletonLayoutGrowthPlanTool.groupedFlexerList[index][flexer_index]
                    let flexer_2 = chunk_list[index].flexers[flexer_index]
                    guard flexer_1 === flexer_2 else {
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
            
            let chunkCount = Int.random(in: 0...8)
            var chunk_list = [SkeletonChunk]()
            var flexer_list = [Flexer]()
            
            for _ in 0..<chunkCount {
                let flexerCount = Int.random(in: 0...8)
                
                valid_tests += 1
                
                for _ in 0..<flexerCount {
                    let which = Int.random(in: 0...2)
                    if which == 0 {
                        let flexer_a = GenerateFlexers.generate_flexer(100)
                        let chunk = GenerateChunks.generate_flexer(flexer: flexer_a)
                        flexer_list.append(flexer_a)
                        chunk_list.append(chunk)
                    } else if which == 1 {
                        let flexer_a = GenerateFlexers.generate_flexer(100)
                        let flexer_b = GenerateFlexers.generate_flexer(100)
                        let chunk = GenerateChunks.generate_flexer_two(flexer1: flexer_a, flexer2: flexer_b)
                        flexer_list.append(flexer_a)
                        flexer_list.append(flexer_b)
                        chunk_list.append(chunk)
                    } else {
                        let flexer_a = GenerateFlexers.generate_flexer(100)
                        let flexer_b = GenerateFlexers.generate_flexer(100)
                        let flexer_c = GenerateFlexers.generate_flexer(100)
                        let chunk = GenerateChunks.generate_flexer_three(flexer1: flexer_a, flexer2: flexer_b, flexer3: flexer_c)
                        flexer_list.append(flexer_a)
                        flexer_list.append(flexer_b)
                        flexer_list.append(flexer_c)
                        chunk_list.append(chunk)
                    }
                }
            }
            
            let node = GenerateNodes.generate_node(chunks: chunk_list)
            let section = GenerateSections.generate_section(node: node)
            let row = GenerateRows.generate_Row(section: section)
            let flexerGroup = ExploderGroup<Flexer>(linkedList: flexer_list, layoutPriority: .required)
            _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForFlexers(flexerGroup: flexerGroup)
            
            guard SkeletonLayoutGrowthPlanTool.chunkListCount == chunk_list.count else {
                #expect(Bool(false))
                return
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
                guard SkeletonLayoutGrowthPlanTool.chunkList[index] === chunk_list[index] else {
                    #expect(Bool(false))
                    return
                }
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.chunkListCount {
                guard SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[index] == chunk_list[index].flexers.count else {
                    #expect(Bool(false))
                    return
                }
                
                for flexer_index in 0..<SkeletonLayoutGrowthPlanTool.groupedFlexerListCount[index] {
                    let flexer_1 = SkeletonLayoutGrowthPlanTool.groupedFlexerList[index][flexer_index]
                    let flexer_2 = chunk_list[index].flexers[flexer_index]
                    guard flexer_1 === flexer_2 else {
                        #expect(Bool(false))
                        return
                    }
                    
                }
            }
        }
        
        print("Test flexers medium done! (\(invalid_tests) invalid tests and \(valid_tests) valid tests)")
        
    }
    
    
}
