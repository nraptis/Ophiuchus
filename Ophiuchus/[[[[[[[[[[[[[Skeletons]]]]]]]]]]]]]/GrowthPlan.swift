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
    
    init(row: SkeletonRow, section: SkeletonSection) {
        self.row = row
        self.section = section
        self.amount = 1
    }
    
}
