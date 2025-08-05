//
//  GrowthPlansForRow.swift
//  Ophiuchus
//
//  Created by Nick on 8/2/25.
//

import Foundation

struct RowGrowthPlans {
    let row: SkeletonRow
    let growthPlans: [GrowthPlan]
    
    func getGrowthPlan(section: SkeletonSection) -> GrowthPlan? {
        for growthPlan in growthPlans {
            if growthPlan.section === section {
                return growthPlan
            }
        }
        return nil
    }
    
    func contains(section: SkeletonSection) -> Bool {
        for growthPlan in growthPlans {
            if growthPlan.section === section {
                return true
            }
        }
        return false
    }
    
}
