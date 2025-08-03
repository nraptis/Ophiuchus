//
//  GrowthPlanTests_Wild_Sections.swift
//  OphiuchusTests
//
//  Created by Nick on 8/3/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct GrowthPlanTests_Wild_Sections {
    
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
    
    @MainActor @Test func test_growth_plan_wild_sections_1_row_shuffled() {
        for _ in 0..<1024 {
            let sectionCount = Int.random(in: 1..<24)
            var sections = GenerateSections.generate_n_sections(n: sectionCount)
            let row = GenerateRows.generate_Row(sections: sections)
            sections.shuffle()
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
    
    @MainActor @Test func test_growth_plan_wild_sections_random_10_rows() {
        
        for _ in 0..<1024 {
            
            let rowCount = Int.random(in: 1...10)
            
            var rows = [SkeletonRow]()
            var sections = [SkeletonSection]()
            
            for _ in 0..<rowCount {
                let sectionCount = Int.random(in: 1..<8)
                let subsections = GenerateSections.generate_n_sections(n: sectionCount)
                let row = GenerateRows.generate_Row(sections: subsections)
                sections.append(contentsOf: subsections)
                rows.append(row)
            }
            
            let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: sections, layoutPriority: .required)
            let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForSections(sectionList: sectionGroup.linkedList,
                                                                                           sectionListCount: sectionGroup.linkedList.count,
                                                                                           sectionAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            
            guard rowGrowthPlans.count == rows.count else {
                print("rowGrowthPlans.count was \(rowGrowthPlans.count)")
                #expect(Bool(false))
                return
            }
            
            // Let's make sure all the rows got a growth plan
            for layoutRow in rows {
                
                var rowGrowthPlan: RowGrowthPlans?
                for _rowGrowthPlan in rowGrowthPlans {
                    if _rowGrowthPlan.layoutRow === layoutRow {
                        rowGrowthPlan = _rowGrowthPlan
                        break
                    }
                }
                guard let rowGrowthPlan = rowGrowthPlan else {
                    print("a row did not have an associated growth plan.")
                    #expect(Bool(false))
                    return
                }
                
                guard rowGrowthPlan.growthPlans.count == layoutRow.sections.count else {
                    #expect(Bool(false))
                    return
                }
                
                for sectionIndex in 0..<layoutRow.sections.count {
                    let growthPlan = rowGrowthPlan.growthPlans[sectionIndex]
                    guard growthPlan.amount == 1 else {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_sections_random_10_rows_shuffled() {
        
        for _ in 0..<1024 {
            
            let rowCount = Int.random(in: 1...10)
            
            var rows = [SkeletonRow]()
            var sections = [SkeletonSection]()
            
            for _ in 0..<rowCount {
                let sectionCount = Int.random(in: 1..<8)
                var subsections = GenerateSections.generate_n_sections(n: sectionCount)
                subsections.shuffle()
                let row = GenerateRows.generate_Row(sections: subsections)
                sections.append(contentsOf: subsections)
                rows.append(row)
            }
            sections.shuffle()
            rows.shuffle()
            
            let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: sections, layoutPriority: .required)
            let rowGrowthPlans = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForSections(sectionList: sectionGroup.linkedList,
                                                                                           sectionListCount: sectionGroup.linkedList.count,
                                                                                           sectionAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            guard rowGrowthPlans.count == rows.count else {
                print("rowGrowthPlans.count was \(rowGrowthPlans.count)")
                #expect(Bool(false))
                return
            }
            
            // Let's make sure all the rows got a growth plan
            for layoutRow in rows {
                
                var rowGrowthPlan: RowGrowthPlans?
                for _rowGrowthPlan in rowGrowthPlans {
                    if _rowGrowthPlan.layoutRow === layoutRow {
                        rowGrowthPlan = _rowGrowthPlan
                        break
                    }
                }
                guard let rowGrowthPlan = rowGrowthPlan else {
                    print("a row did not have an associated growth plan.")
                    #expect(Bool(false))
                    return
                }
                
                guard rowGrowthPlan.growthPlans.count == layoutRow.sections.count else {
                    #expect(Bool(false))
                    return
                }
                
                for sectionIndex in 0..<layoutRow.sections.count {
                    let growthPlan = rowGrowthPlan.growthPlans[sectionIndex]
                    guard growthPlan.amount == 1 else {
                        #expect(Bool(false))
                        return
                    }
                }
            }
        }
    }
    
}
