//
//  InterfaceContainerSupplier.swift
//  InterfaceKit
//
//  Created by Nick on 8/3/25.
//

import Foundation

protocol InterfaceContainerSupplier: ExploderConforming {
    
    
    var childrenSize: Int { get set }
    var didGrowOnCurrentPass: Bool { get set }
    var alignment: LayoutAlignment { get }
    var x: Int { get set }
    var width: Int { get set }
    
    
}

extension InterfaceContainerSupplier {
    func getGap() -> Int {
        var result = currentSize - childrenSize
        if result < 0 {
            fatalError("Gap should never be < 0")
        }
        return result
    }
    
}
