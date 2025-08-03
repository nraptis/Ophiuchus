//
//  GrowthPlanTests_Wild_Flexers.swift
//  OphiuchusTests
//
//  Created by Nick on 8/3/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct GrowthPlanTests_Wild_Flexers {
    
    @MainActor @Test func test_growth_plan_wild_sections_1_row() {
        
        for _ in 0..<1024 {
            
            let sectionCount = Int.random(in: 1..<24)
            let sections = GenerateSections.generate_n_sections(n: sectionCount)
            let row = GenerateRows.generate_Row(sections: sections)
            
            let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: sections, layoutPriority: .required)
            let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForSections(sectionList: sectionGroup.linkedList,
                                                                                           sectionListCount: sectionGroup.linkedList.count,
                                                                                           sectionAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            guard rowGrowthPlans.count == 1 else {
                print("rowGrowthPlans.count was \(rowGrowthPlans.count)")
                #expect(Bool(false))
                return
            }
            guard rowGrowthPlans[0].growthPlans.count == sections.count else {
                #expect(Bool(false))
                return
            }
            for sectionIndex in 0..<sections.count {
                if rowGrowthPlans[0].growthPlans[sectionIndex].amount != 1 {
                    #expect(Bool(false))
                    return
                }
            }
        }
    }
}
