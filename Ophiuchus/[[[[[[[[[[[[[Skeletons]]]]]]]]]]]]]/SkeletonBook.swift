//
//  SkeletonBook.swift
//  Ophiuchus
//
//  Created by Nick on 7/5/25.
//

import Foundation

public class SkeletonBook {
    public let pages: [SkeletonPage]
    public let nodeRules: [SkeletonLinkageRule_Nodes]
    public let flexerRules: [SkeletonLinkageRule_Flexers]
    public let pieceRules: [SkeletonLinkageRule_Pieces]
    init(pages: [SkeletonPage],
         nodeRules: [SkeletonLinkageRule_Nodes],
         flexerRules: [SkeletonLinkageRule_Flexers],
         pieceRules: [SkeletonLinkageRule_Pieces]) {
        self.pages = pages
        self.nodeRules = nodeRules
        self.flexerRules = flexerRules
        self.pieceRules = pieceRules
    }
    
    convenience init(rows: [SkeletonRow],
         nodeRules: [SkeletonLinkageRule_Nodes],
         flexerRules: [SkeletonLinkageRule_Flexers],
         pieceRules: [SkeletonLinkageRule_Pieces]) {
        let page = SkeletonPage(rows: rows)
        self.init(pages: [page],
                  nodeRules: nodeRules,
                  flexerRules: flexerRules,
                  pieceRules: pieceRules)
    }
    
    convenience init(rows: [SkeletonRow]) {
        let page = SkeletonPage(rows: rows)
        self.init(pages: [page],
                  nodeRules: [],
                  flexerRules: [],
                  pieceRules: [])
    }
    
    
    
    public init() {
        self.pages = []
        self.nodeRules = []
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
