//
//  GrowPlanChild.swift
//  Ophiuchus
//
//  Created by Nick on 8/2/25.
//

import Foundation

class GrowthPlan {
    let row: SkeletonRow
    let section: SkeletonSection
    var amount: Int
    
    init(layoutRow: SkeletonRow, layoutSection: SkeletonSection) {
        self.row = layoutRow
        self.section = layoutSection
        self.amount = 1
    }
    
    init(layoutRow: SkeletonRow,
         layoutSection: SkeletonSection,
         amount: Int) {
        self.row = layoutRow
        self.section = layoutSection
        self.amount = amount
    }
    
}
