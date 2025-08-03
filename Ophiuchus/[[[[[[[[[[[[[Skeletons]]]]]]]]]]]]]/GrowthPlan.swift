//
//  GrowPlanChild.swift
//  Ophiuchus
//
//  Created by Nick on 8/2/25.
//

import Foundation

class GrowthPlan {
    let layoutRow: SkeletonRow
    let layoutSection: SkeletonSection
    var amount: Int
    
    init(layoutRow: SkeletonRow, layoutSection: SkeletonSection) {
        self.layoutRow = layoutRow
        self.layoutSection = layoutSection
        self.amount = 1
    }
    
    init(layoutRow: SkeletonRow,
         layoutSection: SkeletonSection,
         amount: Int) {
        self.layoutRow = layoutRow
        self.layoutSection = layoutSection
        self.amount = amount
    }
    
}
