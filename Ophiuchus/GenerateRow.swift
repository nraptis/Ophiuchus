//
//  GenerateRow.swift
//  OphiuchusTests
//
//  Created by Nick on 7/6/25.
//

import Foundation
@testable import Ophiuchus

struct GenerateRows {
    
    static let id_queue = DispatchQueue(label: "id_queue_rows")
    private static var row_id = 0
    
    static func generate(flexer: Flexer) -> SkeletonRow {
        let result = generate(flexers: [flexer])
        return result
    }
    
    static func generate(flexers: [Flexer]) -> SkeletonRow {
        let node = WiseLayoutNode.generate(flexers: flexers)
        let section = SkeletonSection.generate(nodes: [node])
        let result = SkeletonRow.generate(sections: [section])
        result.prepare()
        return result
    }
    
    static func generate_centered(flexer: Flexer) -> SkeletonRow {
        let result = generate_centered(flexers: [flexer])
        return result
    }
    
    static func generate_centered(flexers: [Flexer]) -> SkeletonRow {
        let node = WiseLayoutNode.generate(flexers: flexers)
        let section = SkeletonSection.generate(nodes: [node])
        let result = SkeletonRow.generate(sections: [section], centeredSection: section)
        result.prepare()
        return result
    }
    
    
    static func generate(piece: SkeletonPiece) -> SkeletonRow {
        let result = generate(pieces: [piece])
        return result
    }
    
    static func generate(pieces: [SkeletonPiece]) -> SkeletonRow {
        let node = WiseLayoutNode.generate(pieces: pieces)
        let section = SkeletonSection.generate(nodes: [node])
        let result = SkeletonRow.generate(sections: [section])
        result.prepare()
        return result
    }
    
    
    static func generate_centered(piece: SkeletonPiece) -> SkeletonRow {
        let result = generate_centered(pieces: [piece])
        return result
    }
    
    static func generate_centered(pieces: [SkeletonPiece]) -> SkeletonRow {
        let node = WiseLayoutNode.generate(pieces: pieces)
        let section = SkeletonSection.generate(nodes: [node])
        let result = SkeletonRow.generate(sections: [section], centeredSection: section)
        result.prepare()
        return result
    }
    
    
    
    
    static func generate(node: WiseLayoutNode) -> SkeletonRow {
        let result = generate(nodes: [node])
        return result
    }
    
    static func generate(nodes: [WiseLayoutNode]) -> SkeletonRow {
        let section = SkeletonSection.generate(nodes: nodes)
        let result = SkeletonRow.generate(sections: [section])
        result.prepare()
        return result
    }
    
    static func generate_centered(node: WiseLayoutNode) -> SkeletonRow {
        let result = generate_centered(nodes: [node])
        return result
    }
    
    static func generate_centered(nodes: [WiseLayoutNode]) -> SkeletonRow {
        let section = SkeletonSection.generate(nodes: nodes)
        let result = SkeletonRow.generate(sections: [section], centeredSection: section)
        result.prepare()
        return result
    }
    
    
    
    
    static func generate(section: SkeletonSection) -> SkeletonRow {
        let result = generate(sections: [section])
        return result
    }
    
    static func generate(sections: [SkeletonSection]) -> SkeletonRow {
        let result = SkeletonRow.generate(sections: sections)
        result.prepare()
        return result
    }
    
    static func generate_centered(section: SkeletonSection) -> SkeletonRow {
        let result = generate(sections: [section], centeredSection: section)
        return result
    }
    
    static func generate(sections: [SkeletonSection], centeredSection: SkeletonSection?) -> SkeletonRow {
        let result = SkeletonRow.generate(sections: sections, centeredSection: centeredSection)
        result.prepare()
        return result
    }
    
}
