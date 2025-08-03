//
//  DumpingUpwardNodeTests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/2/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct DumpingUpwardNodeTests {
    
    @MainActor @Test func test_group_node_1_section_1_node() {
        
        let node_a = GenerateNodes.generate_fixed(size: 10)
        
        let section_a = GenerateSections.generate_section(skeleton_node: node_a)
        let row = GenerateRows.generate_Row(section: section_a)
        
        let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: [node_a], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                nodeListCount: nodeGroup.linkedList.count,
                                                                nodeAmountList: SkeletonLayoutGrowthPlanTool.nodeAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.sectionListCount == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.sectionList[0] === section_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[0][0] === node_a else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_node_1_section_2_node() {
        let node_a = GenerateNodes.generate_fixed(size: 10)
        let node_b = GenerateNodes.generate_fixed(size: 10)
        let section_a = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b])
        let row = GenerateRows.generate_Row(section: section_a)
        let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: [node_a, node_b], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                nodeListCount: nodeGroup.linkedList.count,
                                                                nodeAmountList: SkeletonLayoutGrowthPlanTool.nodeAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.sectionListCount == 1 else {
            #expect(Bool(false))
            return
        }
        
        guard SkeletonLayoutGrowthPlanTool.sectionList[0] === section_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeListCount[0] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[0][0] === node_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[0][1] === node_b else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_node_1_section_3_node() {
        let node_a = GenerateNodes.generate_fixed(size: 10)
        let node_b = GenerateNodes.generate_fixed(size: 10)
        let node_c = GenerateNodes.generate_fixed(size: 10)
        
        let section_a = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b, node_c])
        let row = GenerateRows.generate_Row(section: section_a)
        let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: [node_a, node_b, node_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                nodeListCount: nodeGroup.linkedList.count,
                                                                nodeAmountList: SkeletonLayoutGrowthPlanTool.nodeAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.sectionListCount == 1 else {
            #expect(Bool(false))
            return
        }
        
        guard SkeletonLayoutGrowthPlanTool.sectionList[0] === section_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeListCount[0] == 3 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[0][0] === node_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[0][1] === node_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[0][2] === node_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_node_2_section_2_node() {
        
        let node_a = GenerateNodes.generate_fixed(size: 10)
        let section_a = GenerateSections.generate_section(skeleton_node: node_a)
        
        let node_b = GenerateNodes.generate_fixed(size: 10)
        let section_b = GenerateSections.generate_section(skeleton_node: node_b)
        
        let row = GenerateRows.generate_Row(sections: [section_a, section_b], attemptedCenteredSection: nil)
        let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: [node_a, node_b], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                nodeListCount: nodeGroup.linkedList.count,
                                                                nodeAmountList: SkeletonLayoutGrowthPlanTool.nodeAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.sectionListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.sectionList[0] === section_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.sectionList[1] === section_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeListCount[1] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[0][0] === node_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[1][0] === node_b else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_node_2_section_3_node_a() {
        
        let node_a = GenerateNodes.generate_fixed(size: 10)
        let node_b = GenerateNodes.generate_fixed(size: 10)
        let section_a = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b])
        
        let node_c = GenerateNodes.generate_fixed(size: 10)
        let section_b = GenerateSections.generate_section(skeleton_node: node_c)
        
        let row = GenerateRows.generate_Row(sections: [section_a, section_b], attemptedCenteredSection: nil)
        let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: [node_a, node_b, node_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                nodeListCount: nodeGroup.linkedList.count,
                                                                nodeAmountList: SkeletonLayoutGrowthPlanTool.nodeAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.sectionListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.sectionList[0] === section_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.sectionList[1] === section_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeListCount[0] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeListCount[1] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[0][0] === node_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[0][1] === node_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[1][0] === node_c else {
            #expect(Bool(false))
            return
        }
    }
    
    
    @MainActor @Test func test_group_node_2_section_3_node_b() {
        
        let node_a = GenerateNodes.generate_fixed(size: 10)
        let section_a = GenerateSections.generate_section(skeleton_node: node_a)
        
        let node_b = GenerateNodes.generate_fixed(size: 10)
        let node_c = GenerateNodes.generate_fixed(size: 10)
        let section_b = GenerateSections.generate_section(skeleton_nodes: [node_b, node_c])
        
        let row = GenerateRows.generate_Row(sections: [section_a, section_b], attemptedCenteredSection: nil)
        let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: [node_a, node_b, node_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                nodeListCount: nodeGroup.linkedList.count,
                                                                nodeAmountList: SkeletonLayoutGrowthPlanTool.nodeAmountList)
        
        guard SkeletonLayoutGrowthPlanTool.sectionListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.sectionList[0] === section_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.sectionList[1] === section_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeListCount[1] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[0][0] === node_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[1][0] === node_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedNodeList[1][1] === node_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_several_small_groups_512() {
        
        for _ in 0..<512 {
            
            let sectionCount = Int.random(in: 0...4)
            var section_list = [SkeletonSection]()
            var node_list = [SkeletonNode]()
            
            for _ in 0..<sectionCount {
                let nodeCount = Int.random(in: 0...4)
                for _ in 0..<nodeCount {
                    let which = Int.random(in: 0...5)
                    if which == 0 {
                        let node_a = GenerateNodes.generate_fixed(size: 10)
                        let section = GenerateSections.generate_section(skeleton_nodes: [node_a])
                        node_list.append(node_a)
                        section_list.append(section)
                    } else if which == 1 {
                        let node_a = GenerateNodes.generate_fixed(size: 10)
                        let node_b = GenerateNodes.generate_fixed(size: 10)
                        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b])
                        node_list.append(node_a)
                        node_list.append(node_b)
                        section_list.append(section)
                    } else if which == 2 {
                        let node_a = GenerateNodes.generate_fixed(size: 10)
                        let node_b = GenerateNodes.generate_fixed(size: 10)
                        let node_c = GenerateNodes.generate_fixed(size: 10)
                        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b, node_c])
                        node_list.append(node_a)
                        node_list.append(node_b)
                        node_list.append(node_c)
                        section_list.append(section)
                    } else if which == 3 {
                        let node_a = GenerateNodes.generate_fixed(size: 10)
                        let node_b = GenerateNodes.generate_fixed(size: 10)
                        let node_c = GenerateNodes.generate_fixed(size: 10)
                        let node_d = GenerateNodes.generate_fixed(size: 10)
                        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b, node_c, node_d])
                        node_list.append(node_a)
                        node_list.append(node_b)
                        node_list.append(node_c)
                        node_list.append(node_d)
                        section_list.append(section)
                    } else {
                        let node_a = GenerateNodes.generate_fixed(size: 10)
                        let node_b = GenerateNodes.generate_fixed(size: 10)
                        let node_c = GenerateNodes.generate_fixed(size: 10)
                        let node_d = GenerateNodes.generate_fixed(size: 10)
                        let node_e = GenerateNodes.generate_fixed(size: 10)
                        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b, node_c, node_d, node_e])
                        node_list.append(node_a)
                        node_list.append(node_b)
                        node_list.append(node_c)
                        node_list.append(node_d)
                        node_list.append(node_e)
                        section_list.append(section)
                    }
                }
            }
            
            
            let row = GenerateRows.generate_Row(sections: section_list, attemptedCenteredSection: nil)
            let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: node_list, layoutPriority: .required)
            _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                    nodeListCount: nodeGroup.linkedList.count,
                                                                    nodeAmountList: SkeletonLayoutGrowthPlanTool.nodeAmountList)
            
            guard SkeletonLayoutGrowthPlanTool.sectionListCount == section_list.count else {
                #expect(Bool(false))
                return
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.sectionListCount {
                guard SkeletonLayoutGrowthPlanTool.sectionList[index] === section_list[index] else {
                    #expect(Bool(false))
                    return
                }
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.sectionListCount {
                guard SkeletonLayoutGrowthPlanTool.groupedNodeListCount[index] == section_list[index].skeletonNodes.count else {
                    #expect(Bool(false))
                    return
                }
                
                for node_index in 0..<SkeletonLayoutGrowthPlanTool.groupedNodeListCount[index] {
                    let node_1 = SkeletonLayoutGrowthPlanTool.groupedNodeList[index][node_index]
                    let node_2 = section_list[index].skeletonNodes[node_index]
                    guard node_1 === node_2 else {
                        #expect(Bool(false))
                        return
                    }
                    
                }
            }
        }
    }
    
    @MainActor @Test func test_group_several_medium_groups_1024() {
        
        var invalid_tests = 0
        var valid_tests = 0
        
        for _ in 0..<1024 {
            
            let sectionCount = Int.random(in: 0...4)
            var section_list = [SkeletonSection]()
            var node_list = [SkeletonNode]()
            
            for _ in 0..<sectionCount {
                let nodeCount = Int.random(in: 0...8)

                valid_tests += 1
                
                for _ in 0..<nodeCount {
                    let which = Int.random(in: 0...5)
                    if which == 0 {
                        let node_a = GenerateNodes.generate_fixed(size: 10)
                        let section = GenerateSections.generate_section(skeleton_nodes: [node_a])
                        node_list.append(node_a)
                        section_list.append(section)
                    } else if which == 1 {
                        let node_a = GenerateNodes.generate_fixed(size: 10)
                        let node_b = GenerateNodes.generate_fixed(size: 10)
                        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b])
                        node_list.append(node_a)
                        node_list.append(node_b)
                        section_list.append(section)
                    } else if which == 2 {
                        let node_a = GenerateNodes.generate_fixed(size: 10)
                        let node_b = GenerateNodes.generate_fixed(size: 10)
                        let node_c = GenerateNodes.generate_fixed(size: 10)
                        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b, node_c])
                        node_list.append(node_a)
                        node_list.append(node_b)
                        node_list.append(node_c)
                        section_list.append(section)
                    } else if which == 3 {
                        let node_a = GenerateNodes.generate_fixed(size: 10)
                        let node_b = GenerateNodes.generate_fixed(size: 10)
                        let node_c = GenerateNodes.generate_fixed(size: 10)
                        let node_d = GenerateNodes.generate_fixed(size: 10)
                        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b, node_c, node_d])
                        node_list.append(node_a)
                        node_list.append(node_b)
                        node_list.append(node_c)
                        node_list.append(node_d)
                        section_list.append(section)
                    } else {
                        let node_a = GenerateNodes.generate_fixed(size: 10)
                        let node_b = GenerateNodes.generate_fixed(size: 10)
                        let node_c = GenerateNodes.generate_fixed(size: 10)
                        let node_d = GenerateNodes.generate_fixed(size: 10)
                        let node_e = GenerateNodes.generate_fixed(size: 10)
                        let section = GenerateSections.generate_section(skeleton_nodes: [node_a, node_b, node_c, node_d, node_e])
                        node_list.append(node_a)
                        node_list.append(node_b)
                        node_list.append(node_c)
                        node_list.append(node_d)
                        node_list.append(node_e)
                        section_list.append(section)
                    }
                }
            }
            
            let row = GenerateRows.generate_Row(sections: section_list, attemptedCenteredSection: nil)
            let nodeGroup = ExploderGroup<SkeletonNode>(linkedList: node_list, layoutPriority: .required)
            _ = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForNodes(nodeList: nodeGroup.linkedList,
                                                                    nodeListCount: nodeGroup.linkedList.count,
                                                                    nodeAmountList: SkeletonLayoutGrowthPlanTool.nodeAmountList)
            
            guard SkeletonLayoutGrowthPlanTool.sectionListCount == section_list.count else {
                #expect(Bool(false))
                return
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.sectionListCount {
                guard SkeletonLayoutGrowthPlanTool.sectionList[index] === section_list[index] else {
                    #expect(Bool(false))
                    return
                }
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.sectionListCount {
                guard SkeletonLayoutGrowthPlanTool.groupedNodeListCount[index] == section_list[index].skeletonNodes.count else {
                    #expect(Bool(false))
                    return
                }
                
                for node_index in 0..<SkeletonLayoutGrowthPlanTool.groupedNodeListCount[index] {
                    let node_1 = SkeletonLayoutGrowthPlanTool.groupedNodeList[index][node_index]
                    let node_2 = section_list[index].skeletonNodes[node_index]
                    guard node_1 === node_2 else {
                        #expect(Bool(false))
                        return
                    }
                    
                }
            }
        }
        
        print("Test nodes medium done! (\(invalid_tests) invalid tests and \(valid_tests) valid tests)")
        
    }
    
    
}
