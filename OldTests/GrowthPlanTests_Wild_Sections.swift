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
        
        for _ in 0..<2048 {
            
            let sectionCount = Int.random(in: 0..<8)
            let sections_unfiltered = GenerateSections.generate_n_sections(n: sectionCount)
            let sections = GenerateSections.filterRandomly(list: sections_unfiltered)
            
            let row = GenerateRows.generate_Row(sections: sections_unfiltered)
           
            
            let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: sections, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForSections(sectionList: sectionGroup.linkedList,
                                                                                           sectionListCount: sectionGroup.linkedList.count,
                                                                                           sectionAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            let rows = [row]
            if !GrowthPlanValidator.checkSections(pRows: rows,
                                                  pSections: sections,
                                                  pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_sections_1_row_shuffled() {
        
        for _ in 0..<2048 {
            
            let sectionCount = Int.random(in: 0..<8)
            var sections_unfiltered = GenerateSections.generate_n_sections(n: sectionCount)
            sections_unfiltered.shuffle()
            
            var sections = GenerateSections.filterRandomly(list: sections_unfiltered)
            sections.shuffle()
            
            let row = GenerateRows.generate_Row(sections: sections_unfiltered)
           
            
            let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: sections, layoutPriority: .required)
            var pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForSections(sectionList: sectionGroup.linkedList,
                                                                                           sectionListCount: sectionGroup.linkedList.count,
                                                                                           sectionAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            pRowGrowthPlansList.shuffle()
            
            let rows = [row]
            if !GrowthPlanValidator.checkSections(pRows: rows,
                                                  pSections: sections,
                                                  pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_sections_n_rows() {
        
        for _ in 0..<2048 {
            
            let rowCount = Int.random(in: 0..<8)
            var rows = [SkeletonRow]()
            var sections_final: [SkeletonSection] = []
            for _ in 0..<rowCount {
                
                let sectionCount = Int.random(in: 0..<8)
                let sections_unfiltered = GenerateSections.generate_n_sections(n: sectionCount)
                let sections = GenerateSections.filterRandomly(list: sections_unfiltered)
                
                let row = GenerateRows.generate_Row(sections: sections_unfiltered)
                rows.append(row)
                
                
            
                sections_final.append(contentsOf: sections)
            }
            
            let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: sections_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForSections(sectionList: sectionGroup.linkedList,
                                                                                                sectionListCount: sectionGroup.linkedList.count,
                                                                                                sectionAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            if !GrowthPlanValidator.checkSections(pRows: rows,
                                                  pSections: sections_final,
                                                  pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @MainActor @Test func test_growth_plan_wild_sections_n_rows_shuffled() {
        
        for _ in 0..<2048 {
            
            let rowCount = Int.random(in: 0..<8)
            var rows = [SkeletonRow]()
            var rows_orphaned = [SkeletonRow]()
            var sections_final: [SkeletonSection] = []
            for _ in 0..<rowCount {
                
                let sectionCount = Int.random(in: 0..<8)
                var sections_unfiltered = GenerateSections.generate_n_sections(n: sectionCount)
                sections_unfiltered.shuffle()
                var sections = GenerateSections.filterRandomly(list: sections_unfiltered)
                sections.shuffle()
                
                let row = GenerateRows.generate_Row(sections: sections_unfiltered)
                if Bool.random() {
                    rows.append(row)
                } else {
                    rows_orphaned.append(row)
                }
            
                sections_final.append(contentsOf: sections)
            }
            sections_final.shuffle()
            rows.shuffle()
            
            let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: sections_final, layoutPriority: .required)
            let pRowGrowthPlansList = SkeletonLayoutGrowthPlanTool.getRowGrowthPlansForSections(sectionList: sectionGroup.linkedList,
                                                                                                sectionListCount: sectionGroup.linkedList.count,
                                                                                                sectionAmountList: SkeletonLayoutGrowthPlanTool.amountListDefault)
            
            if !GrowthPlanValidator.checkSections(pRows: rows,
                                                  pSections: sections_final,
                                                  pRowGrowthPlansList: pRowGrowthPlansList) {
                #expect(Bool(false))
                return
            }
        }
    }
}
