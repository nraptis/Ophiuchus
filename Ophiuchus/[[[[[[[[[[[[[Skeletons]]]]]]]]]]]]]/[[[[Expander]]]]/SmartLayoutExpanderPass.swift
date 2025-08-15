//
//  SmartLayoutExpanderPass.swift
//  Ophiuchus
//
//  Created by Nick on 8/11/25.
//

import Foundation

struct SmartLayoutExpanderPass {
    
    public static func prepare_naive(groupData: SkeletonLayoutGroupDataExploded, layoutPriority: LayoutPriority) -> Bool {
        var result = true
        
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
            pieceGroup.isActiveAtCurrentPriority = pieceGroup.matchesPriorityOrContainsOneElement(layoutPriority: layoutPriority)
        }
        
        for flexerGroup in flexerGroups {
            ListFactory_Groups.flexerGroupListAdd(flexerGroup: flexerGroup)
            flexerGroup.isLockedAtCurrentPriority = false
            flexerGroup.isActiveAtCurrentPriority = flexerGroup.matchesPriorityOrContainsOneElement(layoutPriority: layoutPriority)
        }
        
        for nodeGroup in groupData.nodeGroups {
            ListFactory_Groups.nodeGroupListAdd(nodeGroup: nodeGroup)
            nodeGroup.isLockedAtCurrentPriority = false
            nodeGroup.isActiveAtCurrentPriority = nodeGroup.matchesPriorityOrContainsOneElement(layoutPriority: layoutPriority)
        }
        
        for section in groupData.sections {
            ListFactory_Groups.sectionListAdd(section: section)
            section.isLockedAtCurrentPriority = false
        }
        
        for flexerGroup in flexerGroups {
            
            /*
            flexerGroup.isLockedAtCurrentPriority = false
            if flexerGroup.isLockedAtEveryPriority { continue }
            if flexerGroup.matchesPriority(layoutPriority: layoutPriority) {
                // We do match this priority, let's consider the group as a whole...
                
                if flexerGroup.areAnyAbleToGrowAtCurrentPriority() {
                    // We can try to grow this group.
                    ListFactory_Groups.flexerListAdd(flexerGroup: flexerGroup)
                } else {
                    if flexerGroup.areAllEqualSize() {
                        // We can't do anything with this group.
                        flexerGroup.isLockedAtCurrentPriority = true
                    } else {
                        // We can try to grow this group.
                        ListFactory_Groups.flexerListAdd(flexerGroup: flexerGroup)
                    }
                }
            } else {
                // We do *not* match this priority.
                // We only consider individual flexer growth.
                if flexerGroup.areAnyAbleToGrowAtCurrentPriority() {
                    // We can try to grow this group.
                    ListFactory_Groups.flexerListAdd(flexerGroup: flexerGroup)
                } else {
                    flexerGroup.isLockedAtCurrentPriority = true
                }
            }
            */
        }
        
        
        
        
        
        return result
    }
    
    public static func prepare_intelligent(groupData: SkeletonLayoutGroupDataExploded, layoutPriority: LayoutPriority) -> Bool {
        prepare_naive(groupData: groupData,
                      layoutPriority: layoutPriority)
    }
    
    
    
}
