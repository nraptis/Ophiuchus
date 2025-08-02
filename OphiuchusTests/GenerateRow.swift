//
//  GenerateRow.swift
//  OphiuchusTests
//
//  Created by Nick on 7/6/25.
//

import Foundation
@testable import Ophiuchus

struct GenerateRows {
    
    static func generate_Row(section: SkeletonSection) -> SkeletonRow {
        GenerateRows.generate_Row(sections: [section], attemptedCenteredSection: nil)
    }
    
    static func generate_Row(sections: [SkeletonSection], attemptedCenteredSection: SkeletonSection?) -> SkeletonRow {
        let result = SkeletonRow(sections: sections, attemptedCenteredSection: attemptedCenteredSection)
        return result
    }
    
}
