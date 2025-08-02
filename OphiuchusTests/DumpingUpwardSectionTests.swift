//
//  DumpingUpwardRowTests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/2/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct DumpingUpwardSectionTests {
    
    @MainActor @Test func test_group_section_1_row_1_section() {
        
        let section_a = GenerateSections.generate_fixed(size: 10)
        
        
        let row_a = GenerateRows.generate_Row(section: section_a)
        
        let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: [section_a], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getGrowthPlansForSections(sectionList: sectionGroup.linkedList, sectionListCount: sectionGroup.linkedList.count)
        
        guard SkeletonLayoutGrowthPlanTool.rowListCount == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.rowList[0] === row_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[0][0] === section_a else {
            #expect(Bool(false))
            return
        }
    }
    
    
    @MainActor @Test func test_group_section_1_row_2_section() {
        let section_a = GenerateSections.generate_fixed(size: 10)
        let section_b = GenerateSections.generate_fixed(size: 10)
        let row_a = GenerateRows.generate_Row(sections: [section_a, section_b])
        let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: [section_a, section_b], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getGrowthPlansForSections(sectionList: sectionGroup.linkedList, sectionListCount: sectionGroup.linkedList.count)
        
        guard SkeletonLayoutGrowthPlanTool.rowListCount == 1 else {
            #expect(Bool(false))
            return
        }
        
        guard SkeletonLayoutGrowthPlanTool.rowList[0] === row_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionListCount[0] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[0][0] === section_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[0][1] === section_b else {
            #expect(Bool(false))
            return
        }
    }
    
    
    @MainActor @Test func test_group_section_1_row_3_section() {
        let section_a = GenerateSections.generate_fixed(size: 10)
        let section_b = GenerateSections.generate_fixed(size: 10)
        let section_c = GenerateSections.generate_fixed(size: 10)
        
        let row_a = GenerateRows.generate_Row(sections: [section_a, section_b, section_c])
        
        let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: [section_a, section_b, section_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getGrowthPlansForSections(sectionList: sectionGroup.linkedList, sectionListCount: sectionGroup.linkedList.count)
        
        guard SkeletonLayoutGrowthPlanTool.rowListCount == 1 else {
            #expect(Bool(false))
            return
        }
        
        guard SkeletonLayoutGrowthPlanTool.rowList[0] === row_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionListCount[0] == 3 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[0][0] === section_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[0][1] === section_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[0][2] === section_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_section_2_row_2_section() {
        
        let section_a = GenerateSections.generate_fixed(size: 10)
        let row_a = GenerateRows.generate_Row(section: section_a)
        
        let section_b = GenerateSections.generate_fixed(size: 10)
        let row_b = GenerateRows.generate_Row(section: section_b)
        
        let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: [section_a, section_b], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getGrowthPlansForSections(sectionList: sectionGroup.linkedList, sectionListCount: sectionGroup.linkedList.count)
        
        guard SkeletonLayoutGrowthPlanTool.rowListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.rowList[0] === row_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.rowList[1] === row_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionListCount[1] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[0][0] === section_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[1][0] === section_b else {
            #expect(Bool(false))
            return
        }
    }
    
    
    @MainActor @Test func test_group_section_2_row_3_section_a() {
        
        let section_a = GenerateSections.generate_fixed(size: 10)
        let section_b = GenerateSections.generate_fixed(size: 10)
        let row_a = GenerateRows.generate_Row(sections: [section_a, section_b])
        
        let section_c = GenerateSections.generate_fixed(size: 10)
        let row_b = GenerateRows.generate_Row(section: section_c)
        
        let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: [section_a, section_b, section_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getGrowthPlansForSections(sectionList: sectionGroup.linkedList, sectionListCount: sectionGroup.linkedList.count)
        
        guard SkeletonLayoutGrowthPlanTool.rowListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.rowList[0] === row_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.rowList[1] === row_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionListCount[0] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionListCount[1] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[0][0] === section_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[0][1] === section_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[1][0] === section_c else {
            #expect(Bool(false))
            return
        }
    }
    
    
    @MainActor @Test func test_group_section_2_row_3_section_b() {
        
        let section_a = GenerateSections.generate_fixed(size: 10)
        let row_a = GenerateRows.generate_Row(section: section_a)
        
        let section_b = GenerateSections.generate_fixed(size: 10)
        let section_c = GenerateSections.generate_fixed(size: 10)
        let row_b = GenerateRows.generate_Row(sections: [section_b, section_c])
        
        let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: [section_a, section_b, section_c], layoutPriority: .required)
        _ = SkeletonLayoutGrowthPlanTool.getGrowthPlansForSections(sectionList: sectionGroup.linkedList, sectionListCount: sectionGroup.linkedList.count)
        
        guard SkeletonLayoutGrowthPlanTool.rowListCount == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.rowList[0] === row_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.rowList[1] === row_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionListCount[0] == 1 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionListCount[1] == 2 else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[0][0] === section_a else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[1][0] === section_b else {
            #expect(Bool(false))
            return
        }
        guard SkeletonLayoutGrowthPlanTool.groupedSectionList[1][1] === section_c else {
            #expect(Bool(false))
            return
        }
    }
    
    @MainActor @Test func test_group_several_small_groups_512() {
        
        for _ in 0..<512 {
            
            let rowCount = Int.random(in: 0...5)
            var row_list = [SkeletonRow]()
            var section_list = [SkeletonSection]()
            
            for _ in 0..<rowCount {
                let sectionCount = Int.random(in: 0...5)
                for _ in 0..<sectionCount {
                    let which = Int.random(in: 0...6)
                    if which == 0 {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let row = GenerateRows.generate_Row(sections: [section_a])
                        section_list.append(section_a)
                        row_list.append(row)
                    } else if which == 1 {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let section_b = GenerateSections.generate_fixed(size: 10)
                        let row = GenerateRows.generate_Row(sections: [section_a, section_b])
                        section_list.append(section_a)
                        section_list.append(section_b)
                        row_list.append(row)
                    } else if which == 2 {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let section_b = GenerateSections.generate_fixed(size: 10)
                        let section_c = GenerateSections.generate_fixed(size: 10)
                        let row = GenerateRows.generate_Row(sections: [section_a, section_b, section_c])
                        section_list.append(section_a)
                        section_list.append(section_b)
                        section_list.append(section_c)
                        row_list.append(row)
                    } else if which == 3 {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let section_b = GenerateSections.generate_fixed(size: 10)
                        let section_c = GenerateSections.generate_fixed(size: 10)
                        let section_d = GenerateSections.generate_fixed(size: 10)
                        let row = GenerateRows.generate_Row(sections: [section_a, section_b, section_c, section_d])
                        section_list.append(section_a)
                        section_list.append(section_b)
                        section_list.append(section_c)
                        section_list.append(section_d)
                        
                        row_list.append(row)
                    } else if which == 4 {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let section_b = GenerateSections.generate_fixed(size: 10)
                        let section_c = GenerateSections.generate_fixed(size: 10)
                        let section_d = GenerateSections.generate_fixed(size: 10)
                        let section_e = GenerateSections.generate_fixed(size: 10)
                        
                        let row = GenerateRows.generate_Row(sections: [section_a, section_b, section_c, section_d, section_e])
                        section_list.append(section_a)
                        section_list.append(section_b)
                        section_list.append(section_c)
                        section_list.append(section_d)
                        section_list.append(section_e)
                        
                        row_list.append(row)
                    } else {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let section_b = GenerateSections.generate_fixed(size: 10)
                        let section_c = GenerateSections.generate_fixed(size: 10)
                        let section_d = GenerateSections.generate_fixed(size: 10)
                        let section_e = GenerateSections.generate_fixed(size: 10)
                        let section_f = GenerateSections.generate_fixed(size: 10)
                        
                        let row = GenerateRows.generate_Row(sections: [section_a, section_b, section_c, section_d, section_e, section_f])
                        section_list.append(section_a)
                        section_list.append(section_b)
                        section_list.append(section_c)
                        section_list.append(section_d)
                        section_list.append(section_e)
                        section_list.append(section_f)
                        
                        row_list.append(row)
                    }
                }
            }
            
            
            let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: section_list, layoutPriority: .required)
            _ = SkeletonLayoutGrowthPlanTool.getGrowthPlansForSections(sectionList: sectionGroup.linkedList, sectionListCount: sectionGroup.linkedList.count)
            
            guard SkeletonLayoutGrowthPlanTool.rowListCount == row_list.count else {
                #expect(Bool(false))
                return
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.rowListCount {
                guard SkeletonLayoutGrowthPlanTool.rowList[index] === row_list[index] else {
                    #expect(Bool(false))
                    return
                }
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.rowListCount {
                guard SkeletonLayoutGrowthPlanTool.groupedSectionListCount[index] == row_list[index].sections.count else {
                    #expect(Bool(false))
                    return
                }
                
                for section_index in 0..<SkeletonLayoutGrowthPlanTool.groupedSectionListCount[index] {
                    let section_1 = SkeletonLayoutGrowthPlanTool.groupedSectionList[index][section_index]
                    let section_2 = row_list[index].sections[section_index]
                    guard section_1 === section_2 else {
                        #expect(Bool(false))
                        return
                    }
                    
                }
            }
        }
    }
    
    
    @MainActor @Test func test_group_several_medium_groups_1024() {
        
        var invalid_tests = 0
        var valid_tests = 0
        
        for _ in 0..<1024 {
            
            let rowCount = Int.random(in: 0...8)
            var row_list = [SkeletonRow]()
            var section_list = [SkeletonSection]()
            
            for _ in 0..<rowCount {
                let sectionCount = Int.random(in: 0...8)
                
                if rowCount * sectionCount > 32 {
                    invalid_tests += 1
                    continue
                }
                
                valid_tests += 1
                
                for _ in 0..<sectionCount {
                    let which = Int.random(in: 0...6)
                    if which == 0 {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let row = GenerateRows.generate_Row(sections: [section_a])
                        section_list.append(section_a)
                        row_list.append(row)
                    } else if which == 1 {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let section_b = GenerateSections.generate_fixed(size: 10)
                        let row = GenerateRows.generate_Row(sections: [section_a, section_b])
                        section_list.append(section_a)
                        section_list.append(section_b)
                        row_list.append(row)
                    } else if which == 2 {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let section_b = GenerateSections.generate_fixed(size: 10)
                        let section_c = GenerateSections.generate_fixed(size: 10)
                        let row = GenerateRows.generate_Row(sections: [section_a, section_b, section_c])
                        section_list.append(section_a)
                        section_list.append(section_b)
                        section_list.append(section_c)
                        row_list.append(row)
                    } else if which == 3 {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let section_b = GenerateSections.generate_fixed(size: 10)
                        let section_c = GenerateSections.generate_fixed(size: 10)
                        let section_d = GenerateSections.generate_fixed(size: 10)
                        let row = GenerateRows.generate_Row(sections: [section_a, section_b, section_c, section_d])
                        section_list.append(section_a)
                        section_list.append(section_b)
                        section_list.append(section_c)
                        section_list.append(section_d)
                        
                        row_list.append(row)
                    } else if which == 4 {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let section_b = GenerateSections.generate_fixed(size: 10)
                        let section_c = GenerateSections.generate_fixed(size: 10)
                        let section_d = GenerateSections.generate_fixed(size: 10)
                        let section_e = GenerateSections.generate_fixed(size: 10)
                        
                        let row = GenerateRows.generate_Row(sections: [section_a, section_b, section_c, section_d, section_e])
                        section_list.append(section_a)
                        section_list.append(section_b)
                        section_list.append(section_c)
                        section_list.append(section_d)
                        section_list.append(section_e)
                        
                        row_list.append(row)
                    } else {
                        let section_a = GenerateSections.generate_fixed(size: 10)
                        let section_b = GenerateSections.generate_fixed(size: 10)
                        let section_c = GenerateSections.generate_fixed(size: 10)
                        let section_d = GenerateSections.generate_fixed(size: 10)
                        let section_e = GenerateSections.generate_fixed(size: 10)
                        let section_f = GenerateSections.generate_fixed(size: 10)
                        
                        let row = GenerateRows.generate_Row(sections: [section_a, section_b, section_c, section_d, section_e, section_f])
                        section_list.append(section_a)
                        section_list.append(section_b)
                        section_list.append(section_c)
                        section_list.append(section_d)
                        section_list.append(section_e)
                        section_list.append(section_f)
                        
                        row_list.append(row)
                    }
                }
            }
            
            let sectionGroup = ExploderGroup<SkeletonSection>(linkedList: section_list, layoutPriority: .required)
            _ = SkeletonLayoutGrowthPlanTool.getGrowthPlansForSections(sectionList: sectionGroup.linkedList, sectionListCount: sectionGroup.linkedList.count)
            
            guard SkeletonLayoutGrowthPlanTool.rowListCount == row_list.count else {
                #expect(Bool(false))
                return
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.rowListCount {
                guard SkeletonLayoutGrowthPlanTool.rowList[index] === row_list[index] else {
                    #expect(Bool(false))
                    return
                }
            }
            
            for index in 0..<SkeletonLayoutGrowthPlanTool.rowListCount {
                guard SkeletonLayoutGrowthPlanTool.groupedSectionListCount[index] == row_list[index].sections.count else {
                    #expect(Bool(false))
                    return
                }
                
                for section_index in 0..<SkeletonLayoutGrowthPlanTool.groupedSectionListCount[index] {
                    let section_1 = SkeletonLayoutGrowthPlanTool.groupedSectionList[index][section_index]
                    let section_2 = row_list[index].sections[section_index]
                    guard section_1 === section_2 else {
                        #expect(Bool(false))
                        return
                    }
                    
                }
            }
        }
        
        print("Test sections medium done! (\(invalid_tests) invalid tests and \(valid_tests) valid tests)")
        
    }
    
}
