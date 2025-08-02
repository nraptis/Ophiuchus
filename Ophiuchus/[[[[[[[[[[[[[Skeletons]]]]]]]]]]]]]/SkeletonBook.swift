//
//  SkeletonBook.swift
//  Ophiuchus
//
//  Created by Nick on 7/5/25.
//

import Foundation

public class SkeletonBook {
    public let pages: [SkeletonPage]
    public let sectionRules: [SkeletonLinkageRule_Sections]
    public let nodeRules: [SkeletonLinkageRule_Nodes]
    public let chunkRules: [SkeletonLinkageRule_Chunks]
    public let flexerRules: [SkeletonLinkageRule_Flexers]
    public let pieceRules: [SkeletonLinkageRule_Pieces]
    init(pages: [SkeletonPage],
         sectionRules: [SkeletonLinkageRule_Sections],
         nodeRules: [SkeletonLinkageRule_Nodes],
         chunkRules: [SkeletonLinkageRule_Chunks],
         flexerRules: [SkeletonLinkageRule_Flexers],
         pieceRules: [SkeletonLinkageRule_Pieces]) {
        self.pages = pages
        self.sectionRules = sectionRules
        self.nodeRules = nodeRules
        self.chunkRules = chunkRules
        self.flexerRules = flexerRules
        self.pieceRules = pieceRules
    }
    
    public init() {
        self.pages = []
        self.sectionRules = []
        self.nodeRules = []
        self.chunkRules = []
        self.flexerRules = []
        self.pieceRules = []
    }
    
    func prepare(menuWidthWithSafeArea: Int,
                 safeAreaLeft: Int,
                 safeAreaRight: Int) {
        for page in pages {
            page.prepare(menuWidthWithSafeArea: menuWidthWithSafeArea,
                         safeAreaLeft: safeAreaLeft,
                         safeAreaRight: safeAreaRight)
        }
    }
    
}
