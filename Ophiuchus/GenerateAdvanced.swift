//
//  GenerateAdvanced.swift
//  Ophiuchus
//
//  Created by Nick on 8/14/25.
//

import Foundation

struct GenerateAdvanced {
    
    class NodeGroupBag {
        let nodeGroup: ExploderGroup<WiseLayoutNode>
        var sectionItems: [SectionWithNodes]
        init(nodeGroup: ExploderGroup<WiseLayoutNode>) {
            self.nodeGroup = nodeGroup
            self.sectionItems = []
        }
    }
    
    class SectionWithNodes {
        let section: SkeletonSection
        var nodes: [WiseLayoutNode]
        init(section: SkeletonSection) {
            self.section = section
            self.nodes = []
        }
    }
    
    static func generateSectionsWithNodes(nodes: [WiseLayoutNode],
                                                            nodeCount: Int) -> [SectionWithNodes] {
        var result = [SectionWithNodes]()
        var map = [Int: SectionWithNodes]()
        for nodeIndex in 0..<nodeCount {
            let node = nodes[nodeIndex]
            if node.group! !== nodes[0].group! {
                fatalError("This is a fundamental minunderstanding???")
            }
        }
        
        for nodeIndex in 0..<nodeCount {
            let node = nodes[nodeIndex]
            let section = node.section!
            let sectionId = section.id
            if let item = map[sectionId] {
                item.nodes.append(node)
            } else {
                let sectionWithNodes = SectionWithNodes(section: section)
                sectionWithNodes.nodes.append(node)
                result.append(sectionWithNodes)
                map[sectionId] = sectionWithNodes
            }
        }
        return result
        
    }
    
    static func generateBags(nodeGroups inputNodeGroups: [ExploderGroup<WiseLayoutNode>]) -> [NodeGroupBag] {
        var result = [NodeGroupBag]()
        for nodeGroup in inputNodeGroups {
            let bag = NodeGroupBag(nodeGroup: nodeGroup)
            bag.sectionItems = generateSectionsWithNodes(nodes: nodeGroup.linkedList,
                                                         nodeCount: nodeGroup.linkedList.count)
            result.append(bag)
        }
        return result
    }
    
    static func generateUniqueNodeGroups(nodeGroups inputNodeGroups: [ExploderGroup<WiseLayoutNode>]) -> [ExploderGroup<WiseLayoutNode>] {
        var result = [ExploderGroup<WiseLayoutNode>]()
        var nodeGroupIdentifiers = Set<Int>()
        for nodeGroup in inputNodeGroups {
            let nodeGroupId = nodeGroup.id
            if !nodeGroupIdentifiers.contains(nodeGroupId) {
                nodeGroupIdentifiers.insert(nodeGroupId)
                result.append(nodeGroup)
            }
        }
        return result
    }
    
    //static func wrap
    
    
    
    static func testWrapNodes(_ nodes: [WiseLayoutNode]) -> [WrappedNode] {
        var result = [WrappedNode]()
        for node in nodes {
            
            let wrappedNode = WrappedNode(node: node)
            wrappedNode.expectedSize = node.currentSize
            result.append(wrappedNode)
        }
        return result
    }
    
    static func testWrapNodesMap(_ nodes: [WrappedNode]) -> [Int: WrappedNode] {
        var result = [Int: WrappedNode]()
        for node in nodes {
            if let existing = result[node.node.id] {
                fatalError("Two Nodes?")
            }
            result[node.node.id] = node
        }
        return result
    }
    
    
}
