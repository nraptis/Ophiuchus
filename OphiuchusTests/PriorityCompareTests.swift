//
//  PriorityCompareTests.swift
//  OphiuchusTests
//
//  Created by Nick on 7/11/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct PriorityCompareTests {
    
    @Test func test_equal() {
        
        if !(LayoutPriority.required.gte(layoutPriority: LayoutPriority.required)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.high.gte(layoutPriority: LayoutPriority.high)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.medium.gte(layoutPriority: LayoutPriority.medium)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.low.gte(layoutPriority: LayoutPriority.low)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.finally.gte(layoutPriority: LayoutPriority.finally)) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_first_required() {
        if !(LayoutPriority.required.gte(layoutPriority: LayoutPriority.required)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.required.gte(layoutPriority: LayoutPriority.high)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.required.gte(layoutPriority: LayoutPriority.medium)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.required.gte(layoutPriority: LayoutPriority.low)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.required.gte(layoutPriority: LayoutPriority.finally)) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_second_required() {
        
        if !(LayoutPriority.required.gte(layoutPriority: LayoutPriority.required)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.high.gte(layoutPriority: LayoutPriority.required)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.medium.gte(layoutPriority: LayoutPriority.required)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.low.gte(layoutPriority: LayoutPriority.required)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.finally.gte(layoutPriority: LayoutPriority.required)) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_first_high() {
        if (LayoutPriority.high.gte(layoutPriority: LayoutPriority.required)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.high.gte(layoutPriority: LayoutPriority.high)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.high.gte(layoutPriority: LayoutPriority.medium)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.high.gte(layoutPriority: LayoutPriority.low)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.high.gte(layoutPriority: LayoutPriority.finally)) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_second_high() {
        
        if !(LayoutPriority.required.gte(layoutPriority: LayoutPriority.high)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.high.gte(layoutPriority: LayoutPriority.high)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.medium.gte(layoutPriority: LayoutPriority.high)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.low.gte(layoutPriority: LayoutPriority.high)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.finally.gte(layoutPriority: LayoutPriority.high)) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_first_medium() {
        if (LayoutPriority.medium.gte(layoutPriority: LayoutPriority.required)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.medium.gte(layoutPriority: LayoutPriority.high)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.medium.gte(layoutPriority: LayoutPriority.medium)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.medium.gte(layoutPriority: LayoutPriority.low)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.medium.gte(layoutPriority: LayoutPriority.finally)) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_second_medium() {
        
        if !(LayoutPriority.required.gte(layoutPriority: LayoutPriority.medium)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.high.gte(layoutPriority: LayoutPriority.medium)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.medium.gte(layoutPriority: LayoutPriority.medium)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.low.gte(layoutPriority: LayoutPriority.medium)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.finally.gte(layoutPriority: LayoutPriority.medium)) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_first_low() {
        if (LayoutPriority.low.gte(layoutPriority: LayoutPriority.required)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.low.gte(layoutPriority: LayoutPriority.high)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.low.gte(layoutPriority: LayoutPriority.medium)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.low.gte(layoutPriority: LayoutPriority.low)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.low.gte(layoutPriority: LayoutPriority.finally)) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_second_low() {
        
        if !(LayoutPriority.required.gte(layoutPriority: LayoutPriority.low)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.high.gte(layoutPriority: LayoutPriority.low)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.medium.gte(layoutPriority: LayoutPriority.low)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.low.gte(layoutPriority: LayoutPriority.low)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.finally.gte(layoutPriority: LayoutPriority.low)) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_first_finally() {
        if (LayoutPriority.finally.gte(layoutPriority: LayoutPriority.required)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.finally.gte(layoutPriority: LayoutPriority.high)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.finally.gte(layoutPriority: LayoutPriority.medium)) {
            #expect(Bool(false))
            return
        }
        
        if (LayoutPriority.finally.gte(layoutPriority: LayoutPriority.low)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.finally.gte(layoutPriority: LayoutPriority.finally)) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_second_finally() {
        
        if !(LayoutPriority.required.gte(layoutPriority: LayoutPriority.finally)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.high.gte(layoutPriority: LayoutPriority.finally)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.medium.gte(layoutPriority: LayoutPriority.finally)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.low.gte(layoutPriority: LayoutPriority.finally)) {
            #expect(Bool(false))
            return
        }
        
        if !(LayoutPriority.finally.gte(layoutPriority: LayoutPriority.finally)) {
            #expect(Bool(false))
            return
        }
    }
    
}
