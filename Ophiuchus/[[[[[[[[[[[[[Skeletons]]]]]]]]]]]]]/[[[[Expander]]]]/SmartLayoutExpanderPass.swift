//
//  SmartLayoutExpanderPass.swift
//  Ophiuchus
//
//  Created by Nick on 8/11/25.
//

import Foundation

struct SmartLayoutExpanderPass {
    
    public static func pass(groupData: SkeletonLayoutGroupDataExploded,
                            layoutPriority: LayoutPriority) {
        SmartLayoutExpanderPass.prepare_intelligent(groupData: groupData, layoutPriority: layoutPriority)
        var max_loops = 1000
        var fudge = 0
        while fudge < max_loops {
            if SmartLayoutExpanderPulse.pulse() {
                fudge += 1
            } else {
                break
            }
        }
        if fudge == max_loops {
            fatalError("TODO: Remove. We got stuck on a loop...")
        }
    }
    
    public static func prepare_naive(groupData: SkeletonLayoutGroupDataExploded,
                                     layoutPriority: LayoutPriority) {
        
        groupData.calculateFlexerTargetSizeCurrentPriority(layoutPriority: layoutPriority)
        
        ListFactory_Groups.flexerGroupListReset()
        ListFactory_Groups.pieceGroupListReset()
        ListFactory_Groups.nodeGroupListReset()
        ListFactory_Groups.sectionListReset()
        
        let flexerGroups = groupData.flexerGroups
        let pieceGroups = groupData.pieceGroups
        let nodeGroups = groupData.nodeGroups
        let sections = groupData.sections
        
        for pieceGroup in pieceGroups {
            ListFactory_Groups.pieceGroupListAdd(pieceGroup: pieceGroup)
            pieceGroup.isLockedAtCurrentPriority = false
            pieceGroup.isActiveAtCurrentPriorityOrMono = pieceGroup.matchesPriorityOrMono(layoutPriority: layoutPriority)
        }
        
        for flexerGroup in flexerGroups {
            ListFactory_Groups.flexerGroupListAdd(flexerGroup: flexerGroup)
            flexerGroup.isLockedAtCurrentPriority = false
            
            if flexerGroup.linkedList.count <= 1 {
                flexerGroup.isInactiveAtCurrentPriorityOrMono = true
            } else {
                if flexerGroup.matchesPriority(layoutPriority: layoutPriority) {
                    flexerGroup.isInactiveAtCurrentPriorityOrMono = false
                } else {
                    flexerGroup.isInactiveAtCurrentPriorityOrMono = true
                }
            }
        }
        
        for nodeGroup in groupData.nodeGroups {
            ListFactory_Groups.nodeGroupListAdd(nodeGroup: nodeGroup)
            nodeGroup.isLockedAtCurrentPriority = false
            nodeGroup.isActiveAtCurrentPriorityOrMono = nodeGroup.matchesPriorityOrMono(layoutPriority: layoutPriority)
        }
        
        for section in groupData.sections {
            ListFactory_Groups.sectionListAdd(section: section)
            section.isLockedAtCurrentPriority = false
        }
    }
    
    public static func prepare_intelligent(groupData: SkeletonLayoutGroupDataExploded, layoutPriority: LayoutPriority) {
        prepare_naive(groupData: groupData,
                      layoutPriority: layoutPriority)
    }
    
    
    
}
