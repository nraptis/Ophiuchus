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
        
        for section in sections {
            section.row = result
            for node in section.skeletonNodes {
                node.section = section
                node.row = result
                for chunk in node.chunks {
                    chunk.node = node
                    chunk.section = section
                    chunk.row = result
                    for flexer in chunk.flexers {
                        flexer.chunk = chunk
                        flexer.node = node
                        flexer.section = section
                        flexer.row = result
                    }
                    for piece in chunk.pieces {
                        piece.chunk = chunk
                        piece.node = node
                        piece.section = section
                        piece.row = result
                    }
                }
            }
        }
        
        return result
    }
    
}
