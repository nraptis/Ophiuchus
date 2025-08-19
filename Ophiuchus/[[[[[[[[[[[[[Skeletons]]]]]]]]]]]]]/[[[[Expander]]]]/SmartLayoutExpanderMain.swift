//
//  SmartLayoutExpanderMain.swift
//  Ophiuchus
//
//  Created by Nick on 8/11/25.
//

import Foundation

struct SmartLayoutExpanderMain {

    static func positionContent(pages: [SkeletonPage],
                                menuWidthWithSafeArea: Int,
                                safeAreaLeft: Int,
                                safeAreaRight: Int) {
        for _page in pages {
            for _row in _page.rows {
                for _section in _row.sections {
                    _section.width = _section.currentSize
                    for _node in _section.nodes {
                        _node.width = _node.currentSize
                    }
                }
                _row.positionContentAfterSizeComputation(menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                         safeAreaLeft: safeAreaLeft,
                                                         safeAreaRight: safeAreaRight)
            }
        }
    }
    
    public static func prepare(groupData: SkeletonLayoutGroupDataExploded) {
        
        let flexerGroups = groupData.flexerGroups
        let pieceGroups = groupData.pieceGroups
        let nodeGroups = groupData.nodeGroups
        let sections = groupData.sections
        
        for pieceGroup in pieceGroups {
            pieceGroup.isLockedAtCurrentPriority = false
            pieceGroup.isLockedAtEveryPriority = false
            pieceGroup.isMono = (pieceGroup.linkedList.count <= 1)
        }
        
        for flexerGroup in flexerGroups {
            flexerGroup.isLockedAtCurrentPriority = false
            flexerGroup.isLockedAtEveryPriority = false
            flexerGroup.isMono = (flexerGroup.linkedList.count <= 1)
        }
        
        for nodeGroup in nodeGroups {
            nodeGroup.isLockedAtCurrentPriority = false
            nodeGroup.isLockedAtEveryPriority = false
            nodeGroup.isMono = (nodeGroup.linkedList.count <= 1)
            for node in nodeGroup.linkedList {
                node.isLockedAtCurrentPriority = false
                node.isLockedAtEveryPriority = false
            }
        }
        
        for section in sections {
            ListFactory_GroupsA.sectionListAdd(section: section)
            section.isLockedAtCurrentPriority = false
            section.isLockedAtEveryPriority = false
        }
    }
    
}
