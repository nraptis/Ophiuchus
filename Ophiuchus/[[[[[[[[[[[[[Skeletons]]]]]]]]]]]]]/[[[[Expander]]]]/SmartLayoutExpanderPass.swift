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
        var fudge = 0
        while fudge < 4096 {
            if SmartLayoutExpanderPulse.pulse() {
                fudge += 1
            } else {
                break
            }
        }
        if fudge >= 4096 {
            print("FATAL: Looks like we got stuck in a loop...")
        }
    }
    
    public static func prepare_naive(groupData: SkeletonLayoutGroupDataExploded,
                                     layoutPriority: LayoutPriority) {
        
        groupData.calculateFlexerTargetSizeCurrentPriority(layoutPriority: layoutPriority)
        
        ListFactory_GroupsA.flexerGroupListReset()
        ListFactory_GroupsA.pieceGroupListReset()
        ListFactory_GroupsA.nodeGroupListReset()
        ListFactory_GroupsA.sectionListReset()
        
        let flexerGroups = groupData.flexerGroups
        let pieceGroups = groupData.pieceGroups
        let nodeGroups = groupData.nodeGroups
        
        for pieceGroup in pieceGroups {
            ListFactory_GroupsA.pieceGroupListAdd(pieceGroup: pieceGroup)
            pieceGroup.isLockedAtCurrentPriority = false
            
            pieceGroup.isMono = (pieceGroup.linkedList.count <= 1)
            pieceGroup.isActiveAtCurrentPriority = pieceGroup.matchesPriority(layoutPriority: layoutPriority)
            
        }
        
        for flexerGroup in flexerGroups {
            ListFactory_GroupsA.flexerGroupListAdd(flexerGroup: flexerGroup)
            flexerGroup.isLockedAtCurrentPriority = false
            
            flexerGroup.isMono = (flexerGroup.linkedList.count <= 1)
            flexerGroup.isActiveAtCurrentPriority = flexerGroup.matchesPriority(layoutPriority: layoutPriority)
            
        }
        
        for nodeGroup in nodeGroups {
            ListFactory_GroupsA.nodeGroupListAdd(nodeGroup: nodeGroup)
            nodeGroup.isLockedAtCurrentPriority = false
            
            nodeGroup.isMono = (nodeGroup.linkedList.count <= 1)
            nodeGroup.isActiveAtCurrentPriority = nodeGroup.matchesPriority(layoutPriority: layoutPriority)
        }
        
        for section in groupData.sections {
            ListFactory_GroupsA.sectionListAdd(section: section)
            section.isLockedAtCurrentPriority = false
        }
    }
    
    public static func prepare_intelligent(groupData: SkeletonLayoutGroupDataExploded, layoutPriority: LayoutPriority) {
        
        groupData.calculateFlexerTargetSizeCurrentPriority(layoutPriority: layoutPriority)
        
        ListFactory_GroupsA.flexerGroupListReset()
        ListFactory_GroupsA.pieceGroupListReset()
        ListFactory_GroupsA.nodeGroupListReset()
        ListFactory_GroupsA.sectionListReset()
        
        let flexerGroups = groupData.flexerGroups
        let pieceGroups = groupData.pieceGroups
        let nodeGroups = groupData.nodeGroups
        
        for pieceGroup in pieceGroups {
            if pieceGroup.isLockedAtEveryPriority { continue }
            ListFactory_GroupsA.pieceGroupListAdd(pieceGroup: pieceGroup)
            pieceGroup.isLockedAtCurrentPriority = false
            pieceGroup.isActiveAtCurrentPriority = pieceGroup.matchesPriority(layoutPriority: layoutPriority)
        }
        
        for flexerGroup in flexerGroups {
            if flexerGroup.isLockedAtEveryPriority { continue }
            ListFactory_GroupsA.flexerGroupListAdd(flexerGroup: flexerGroup)
            flexerGroup.isLockedAtCurrentPriority = false
            flexerGroup.isActiveAtCurrentPriority = flexerGroup.matchesPriority(layoutPriority: layoutPriority)
        }
        
        for nodeGroup in nodeGroups {
            if nodeGroup.isLockedAtEveryPriority { continue }
            ListFactory_GroupsA.nodeGroupListAdd(nodeGroup: nodeGroup)
            nodeGroup.isLockedAtCurrentPriority = false
            nodeGroup.isActiveAtCurrentPriority = nodeGroup.matchesPriority(layoutPriority: layoutPriority)
        }
        
        for section in groupData.sections {
            ListFactory_GroupsA.sectionListAdd(section: section)
            section.isLockedAtCurrentPriority = false
        }
        
    }
    
    
    
}
