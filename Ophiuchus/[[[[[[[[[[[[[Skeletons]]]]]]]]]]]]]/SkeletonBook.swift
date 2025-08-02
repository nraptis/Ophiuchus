//
//  SkeletonBook.swift
//  Ophiuchus
//
//  Created by Nick on 7/5/25.
//

import Foundation

public class SkeletonBook {
    public let pages: [SkeletonPage]
    public let rules_Sections: [SkeletonLinkageRule_Sections]
    public let rules_Nodes: [SkeletonLinkageRule_Nodes]
    public let rules_Chunks: [SkeletonLinkageRule_Chunks]
    public let rules_Flexers: [SkeletonLinkageRule_Flexers]
    public let rules_Pieces: [SkeletonLinkageRule_Pieces]
    init(pages: [SkeletonPage],
         rules_Sections: [SkeletonLinkageRule_Sections],
         rules_Nodes: [SkeletonLinkageRule_Nodes],
         rules_Chunks: [SkeletonLinkageRule_Chunks],
         rules_Flexers: [SkeletonLinkageRule_Flexers],
         rules_Pieces: [SkeletonLinkageRule_Pieces]) {
        self.pages = pages
        self.rules_Sections = rules_Sections
        self.rules_Nodes = rules_Nodes
        self.rules_Chunks = rules_Chunks
        self.rules_Flexers = rules_Flexers
        self.rules_Pieces = rules_Pieces
    }
    
    public init() {
        self.pages = []
        self.rules_Sections = []
        self.rules_Nodes = []
        self.rules_Chunks = []
        self.rules_Flexers = []
        self.rules_Pieces = []
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
