//
//  WrappedRow.swift
//  Ophiuchus
//
//  Created by Nick on 8/14/25.
//

import Foundation

class WrappedRow {
    
    let sections: [WrappedSection]
    let row: SkeletonRow
    var expectedGrowthBudget: Int
    init(row: SkeletonRow, sections: [WrappedSection]) {
        self.sections = sections
        self.row = row
        self.expectedGrowthBudget = row.growthBudget
    }
    
    convenience init(row: SkeletonRow) {
        var _sections = [WrappedSection]()
        for section in row.sections {
            let _section = WrappedSection(section: section)
            _sections.append(_section)
        }
        self.init(row: row, sections: _sections)
        
        for section in _sections {
            section.row = self
            for node in section.nodes {
                node.row = self
            }
        }
    }
    
    func inject(row_map: inout [Int: WrappedRow],
                section_map: inout [Int: WrappedSection],
                node_map: inout [Int: WrappedNode]) {
        row_map[row.id] = self
        for section in sections {
            section.inject(section_map: &section_map,
                           node_map: &node_map)
        }
    }
    
}
