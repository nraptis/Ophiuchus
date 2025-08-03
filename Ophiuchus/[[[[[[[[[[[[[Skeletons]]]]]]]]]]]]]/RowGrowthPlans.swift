//
//  GrowthPlansForRow.swift
//  Ophiuchus
//
//  Created by Nick on 8/2/25.
//

import Foundation

struct RowGrowthPlans {
    let layoutRow: SkeletonRow
    let growthPlans: [GrowthPlan]
    
    func getGrowthPlan(layoutSection: SkeletonSection) -> GrowthPlan? {
        for growthPlan in growthPlans {
            if growthPlan.layoutSection === layoutSection {
                return growthPlan
            }
        }
        return nil
    }
    
}
