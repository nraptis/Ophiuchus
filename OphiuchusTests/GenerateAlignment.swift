//
//  GenerateAlignment.swift
//  OphiuchusTests
//
//  Created by Nick on 7/6/25.
//

import Foundation
@testable import Ophiuchus

public struct GenerateAlignment {
    
    static func generate_alignment() -> LayoutAlignment {
        let alignment_index = Int.random(in: 0...2)
        if alignment_index == 0 {
            return LayoutAlignment.left
        } else if alignment_index == 1 {
            return LayoutAlignment.center
        } else {
            return LayoutAlignment.right
        }
    }
    
}
