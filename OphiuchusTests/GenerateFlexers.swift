//
//  GenerateFlexers.swift
//  OphiuchusTests
//
//  Created by Nick on 7/4/25.
//

import Foundation
@testable import Ophiuchus

struct GenerateFlexers {
    
    static let id_queue = DispatchQueue(label: "id_queue_flexers")
    
    static let table_10 = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200]
    static let table_100 = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000]
    
    static func generate_n_flexers(n: Int) -> [Flexer] {
        var result = [Flexer]()
        var index = 0
        while index < n {
            let flexer = generate_n_m_climb(n: 10, m: 10)
            result.append(flexer)
            index += 1
        }
        return result
    }
    
    private static var flexer_id = 0
    static func generate_flexer(
        _ desired_size_required: Int,
        _ desired_size_high: Int? = nil,
        _ desired_size_medium: Int? = nil,
        _ desired_size_low: Int? = nil,
        _ desired_size_finally: Int? = nil) -> Flexer {
        
        let id = id_queue.sync {
            let id = GenerateFlexers.flexer_id
            GenerateFlexers.flexer_id += 1
            if GenerateFlexers.flexer_id > 1_000_000_000 { GenerateFlexers.flexer_id = 0 }
            return id
        }
        
        let result = Flexer(id: id,
                            flexerIdentifier: .unknown,
                            desired_size_required,
                            desired_size_high,
                            desired_size_medium,
                            desired_size_low,
                            desired_size_finally)
        return result
    }
    
    static func generate_0() -> Flexer {
        return generate_flexer(0)
    }
    
    static func generate_100_climb() -> Flexer {
        return generate_flexer(100, 200, 300, 400, 500)
    }
    
    static func generate_100_climb_0() -> Flexer {
        return generate_flexer(0, 100, 200, 300, 400)
    }
    
    static func generate_100_random_climb() -> Flexer {
        
        let required = Bool.random() ? 0 : 100
        let high = Bool.random() ? (required + 100) : required
        let medium = Bool.random() ? (high + 100) : high
        let low = Bool.random() ? (medium + 100) : medium
        let finally = Bool.random() ? (low + 100) : low
        return generate_flexer(required, high, medium, low, finally)
    }
    
    static func generate_10_random_climb() -> Flexer {
        
        let required = Bool.random() ? 0 : 10
        let high = Bool.random() ? (required + 10) : required
        let medium = Bool.random() ? (high + 10) : high
        let low = Bool.random() ? (medium + 10) : medium
        let finally = Bool.random() ? (low + 10) : low
        return generate_flexer(required, high, medium, low, finally)
    }
    
    static func generate_n_random_climb(n: Int) -> Flexer {
        
        let required = Bool.random() ? 0 : n
        let high = Bool.random() ? (required + n) : required
        let medium = Bool.random() ? (high + n) : high
        let low = Bool.random() ? (medium + n) : medium
        let finally = Bool.random() ? (low + n) : low
        return generate_flexer(required, high, medium, low, finally)
    }
    
    static func generate_n_m_climb(n: Int, m: Int) -> Flexer {
        
        let required = Int.random(in: 0...n)
        let high = required + Int.random(in: 0...m)
        let medium = high + Int.random(in: 0...m)
        let low = medium + Int.random(in: 0...m)
        let finally = low + Int.random(in: 0...m)
        return generate_flexer(required, high, medium, low, finally)
    }
    
    
    
}
