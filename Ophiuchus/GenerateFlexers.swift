//
//  GenerateFlexers.swift
//  OphiuchusTests
//
//  Created by Nick on 7/4/25.
//

import Foundation
@testable import Ophiuchus

struct GenerateFlexers {
    
    static let table_10 = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200]
    static let table_100 = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000]
    
    static func generate_n(_ n: Int) -> [Flexer] {
        var result = [Flexer]()
        var index = 0
        while index < n {
            let flexer = generate_random_climb_n_m(n: 10, m: 10)
            result.append(flexer)
            index += 1
        }
        return result
    }
    
    static func generate(
        _ desiredSizeRequired: Int,
        _ desiredSizeHigh: Int? = nil,
        _ desiredSizeMedium: Int? = nil,
        _ desiredSizeLow: Int? = nil,
        _ desiredSizeFinally: Int? = nil) -> Flexer {
            
            let result = Flexer.generate(desiredSizeRequired: desiredSizeRequired,
                                         desiredSizeHigh: desiredSizeHigh,
                                         desiredSizeMedium: desiredSizeMedium,
                                         desiredSizeLow: desiredSizeLow,
                                         desiredSizeFinally: desiredSizeFinally)
            
            return result
        }
    
    static func generate(currentSize: Int, targetSizeCurrentPriority: Int) -> Flexer {
        let _currentSize = currentSize
        let result = GenerateFlexers.generate(_currentSize,
                                              _currentSize,
                                              _currentSize,
                                              _currentSize,
                                              _currentSize)
        result.currentSize = currentSize
        result.targetSizeCurrentPriority = targetSizeCurrentPriority
        return result
    }
    
    static func generate(currentSize: Int, targetSizeCurrentPriority: Int, name: String) -> Flexer {
        let _currentSize = currentSize
        let result = GenerateFlexers.generate(_currentSize,
                                              _currentSize,
                                              _currentSize,
                                              _currentSize,
                                              _currentSize)
        result.currentSize = currentSize
        result.targetSizeCurrentPriority = targetSizeCurrentPriority
        result.name = name
        return result
    }
    
    static func generate_0() -> Flexer {
        let result = generate(0, 0, 0, 0, 0)
        return result
    }
    
    static func generate_10() -> Flexer {
        let result = generate(10, 10, 10, 10, 10)
        return result
    }
    
    static func generate_one_stepper() -> Flexer {
        let result = generate(1, 2, 3, 4, 5)
        return result
    }
    
    static func generate_two_stepper() -> Flexer {
        let result = generate(2, 4, 6, 8, 10)
        return result
    }
    
    static func generate_100_climb() -> Flexer {
        let result = generate(100, 200, 300, 400, 500)
        return result
    }
    
    static func generate_100_climb_0() -> Flexer {
        let result = generate(0, 100, 200, 300, 400)
        return result
    }
    
    static func generate_100_random_climb() -> Flexer {
        
        let required = Bool.random() ? 0 : 100
        let high = Bool.random() ? (required + 100) : required
        let medium = Bool.random() ? (high + 100) : high
        let low = Bool.random() ? (medium + 100) : medium
        let finally = Bool.random() ? (low + 100) : low
        let result = generate(required, high, medium, low, finally)
        return result
    }
    
    static func generate_10_random_climb() -> Flexer {
        
        let required = Bool.random() ? 0 : 10
        let high = Bool.random() ? (required + 10) : required
        let medium = Bool.random() ? (high + 10) : high
        let low = Bool.random() ? (medium + 10) : medium
        let finally = Bool.random() ? (low + 10) : low
        let result = generate(required, high, medium, low, finally)
        return result
    }
    
    static func generate_random_climb_n(_ n: Int) -> Flexer {
        
        let required = Bool.random() ? 0 : n
        let high = Bool.random() ? (required + n) : required
        let medium = Bool.random() ? (high + n) : high
        let low = Bool.random() ? (medium + n) : medium
        let finally = Bool.random() ? (low + n) : low
        let result = generate(required, high, medium, low, finally)
        return result
    }
    
    static func generate_random_climb_n_m(n: Int, m: Int) -> Flexer {
        
        let required = Int.random(in: 0...n)
        let high = required + Int.random(in: 0...m)
        let medium = high + Int.random(in: 0...m)
        let low = medium + Int.random(in: 0...m)
        let finally = low + Int.random(in: 0...m)
        let result = generate(required, high, medium, low, finally)
        return result
    }
    
}
