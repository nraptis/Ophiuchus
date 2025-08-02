//
//  FlexerTests_Simple.swift
//  OphiuchusTests
//
//  Created by Nick on 7/3/25.
//

import Testing
@testable import Ophiuchus

struct FlexerTests {
    
    @Test func test_unsafe() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 50)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 50) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 50) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 50) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 50) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 50) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 50")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_1() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 50)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 50) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 50) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 50) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 50) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 50) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 50")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_2_a() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 200, 250)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 200) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 250) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 250) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 250) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 250) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 250")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_2_b() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 200, nil, 250)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 200) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 200) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 250) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 250) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 250) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 250")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_2_c() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 200, nil, nil, 250)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 200) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 200) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 200) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 250) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 250) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 250")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_2_d() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 200, nil, nil, nil, 250)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 200) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 200) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 200) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 200) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 250) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 250")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_a() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, 600, 700)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 500) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 600) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 700) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 700")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 700) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 700")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 700) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_b() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, nil, 600, 700)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 500) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 500) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 600) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 700) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 700")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 700) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_c() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, nil, nil, 600, 700)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 500) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 500) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 500) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 600) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 700) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_d() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, 600, nil, 700)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 500) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 600) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 600) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 700) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 700")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 700) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_e() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, 600, nil, nil, 700)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 500) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 600) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 600) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 600) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 700) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_f() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, nil, 600, 700)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 500) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 500) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 600) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 700) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 700")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 700) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_g() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, nil, 600, nil, 700)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 500) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 500) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 600) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 600) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 700) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_h() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, nil, nil, 600, 700)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 500) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 500) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 500) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 600) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 700) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_4_a() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1000, 2000, 3000, 4000)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 1000) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 1000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 2000) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 2000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 3000) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 3000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 4000) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 4000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 4000) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 4000")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_4_b() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1000, nil, 2000, 3000, 4000)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 1000) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 1000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 1000) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 1000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 2000) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 2000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 3000) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 3000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 4000) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 4000")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_4_c() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1000, 2000, nil, 3000, 4000)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 1000) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 1000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 2000) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 2000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 2000) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 2000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 3000) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 3000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 4000) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 4000")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_4_d() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1000, 2000, 3000, nil, 4000)
        if !(flexer.getDesiredSize(layoutPriority: .required) == 1000) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 1000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 2000) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 2000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 3000) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 3000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 3000) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 3000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 4000) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 4000")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_getDesiredSize_a() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 100, 200, 300, 400, 500)
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 500) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 400) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 400")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 300) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 300")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 200) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .required) == 100) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 100")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_getDesiredSize_b() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1, 2, 3, 4, 5)
        if !(flexer.getDesiredSize(layoutPriority: .finally) == 5) {
            print("getDesiredSize(layoutPriority: .finally) was expected to be 5")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .low) == 4) {
            print("getDesiredSize(layoutPriority: .low) was expected to be 4")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .medium) == 3) {
            print("getDesiredSize(layoutPriority: .medium) was expected to be 3")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .high) == 2) {
            print("getDesiredSize(layoutPriority: .high) was expected to be 2")
            #expect(Bool(false))
            return
        }
        if !(flexer.getDesiredSize(layoutPriority: .required) == 1) {
            print("getDesiredSize(layoutPriority: .required) was expected to be 1")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_invalid_case_1() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 3, 2, 3, 4, 5)
        if flexer.validate_desired_sizes() {
            print("test_size_flexer_invalid_case_1 -> This case is expected to be invalid...")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_invalid_case_2() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1, 4, 3, 4, 5)
        if flexer.validate_desired_sizes() {
            print("test_size_flexer_invalid_case_2 -> This case is expected to be invalid...")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_invalid_case_3() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1, 2, 5, 4, 5)
        if flexer.validate_desired_sizes() {
            print("test_size_flexer_invalid_case_3 -> This case is expected to be invalid...")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_invalid_case_4() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1, 2, 3, 6, 5)
        if flexer.validate_desired_sizes() {
            print("test_size_flexer_invalid_case_4 -> This case is expected to be invalid...")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_invalid_case_5() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 7, 7, 7, 7, 6)
        if flexer.validate_desired_sizes() {
            print("test_size_flexer_invalid_case_5 -> This case is expected to be invalid...")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_valid_case_1() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1, 1, 1, 1, 1)
        if !(flexer.validate_desired_sizes()) {
            print("test_size_flexer_valid_case_1 -> This case is expected to be valid...")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_valid_case_2() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 7, 7, 7, 7, 8)
        if !flexer.validate_desired_sizes() {
            print("test_size_flexer_valid_case_2 -> This case is expected to be invalid...")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_valid_case_3() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 5, 5, 6, 6, 1000)
        if !flexer.validate_desired_sizes() {
            print("test_size_flexer_valid_case_3 -> This case is expected to be invalid...")
            #expect(Bool(false))
            return
        }
    }

    @Test func test_size_flexer_valid_case_4() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 3, 5, 5, 5, 5)
        if !flexer.validate_desired_sizes() {
            print("test_size_flexer_valid_case_4 -> This case is expected to be invalid...")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_valid_case_5() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 0, 100, 100, 100, 1000)
        if !flexer.validate_desired_sizes() {
            print("test_size_flexer_valid_case_5 -> This case is expected to be invalid...")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_valid_case_6() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 0, 0, 100, 100, 100)
        if !flexer.validate_desired_sizes() {
            print("test_size_flexer_valid_case_6 -> This case is expected to be invalid...")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_loops_basic() {
        var loops = 0
        let ceiling = 24
        var desired_size_required = 0
        while desired_size_required <= ceiling {
            var desired_size_high = desired_size_required
            while desired_size_high <= ceiling {
                var desired_size_medium = desired_size_high
                while desired_size_medium <= ceiling {
                    var desired_size_low = desired_size_medium
                    while desired_size_low <= ceiling {
                        var desired_size_finally = desired_size_low
                        while desired_size_finally <= ceiling {
                            
                            let flexor = Flexer(id: 0, flexerIdentifier: .unknown, desired_size_required,
                                                            desired_size_high,
                                                            desired_size_medium,
                                                            desired_size_low,
                                                            desired_size_finally)
                            if !flexor.validate_desired_sizes() {
                                print("This was an invalid configuration.")
                                print("desired_size_required = \(desired_size_required)")
                                print("desired_size_high = \(desired_size_high)")
                                print("desired_size_medium = \(desired_size_medium)")
                                print("desired_size_low = \(desired_size_low)")
                                print("desired_size_finally = \(desired_size_finally)")
                                
                                #expect(Bool(false))
                                return
                            }
                            
                            if flexor.getDesiredSize(layoutPriority: .finally) != desired_size_finally {
                                #expect(Bool(false))
                                return
                            }
                            
                            if flexor.getDesiredSize(layoutPriority: .low) != desired_size_low {
                                #expect(Bool(false))
                                return
                            }
                            
                            if flexor.getDesiredSize(layoutPriority: .medium) != desired_size_medium {
                                #expect(Bool(false))
                                return
                            }
                            
                            if flexor.getDesiredSize(layoutPriority: .high) != desired_size_high {
                                #expect(Bool(false))
                                return
                            }
                            
                            if flexor.getDesiredSize(layoutPriority: .required) != desired_size_required {
                                #expect(Bool(false))
                                return
                            }
                            
                            loops += 1
                            desired_size_finally += 1
                        }
                        desired_size_low += 1
                    }
                    desired_size_medium += 1
                }
                desired_size_high += 1
            }
            desired_size_required += 1
        }
        print("Tested with \(loops) loops. Success!")
    }
    
    @Test func test_size_flexer_loops_ingest() {
        var loops = 0
        let ceiling = 8
        var desired_size_required = 0
        while desired_size_required <= ceiling {
            var desired_size_high = desired_size_required
            while desired_size_high <= ceiling {
                var desired_size_medium = desired_size_high
                while desired_size_medium <= ceiling {
                    var desired_size_low = desired_size_medium
                    while desired_size_low <= ceiling {
                        var desired_size_finally = desired_size_low
                        while desired_size_finally <= ceiling {
                            for layoutPriority in [LayoutPriority.required,
                                             LayoutPriority.high,
                                             LayoutPriority.medium,
                                             LayoutPriority.low,
                                             LayoutPriority.finally] {
                                
                                for _ in 0..<64 {
                                    let currentSize = Int.random(in: 0...256)
                                    
                                    for _ in 0..<64 {
                                        
                                        let available_space = Int.random(in: 0...512)
                                        
                                        let flexor = Flexer(id: 0, flexerIdentifier: .unknown, desired_size_required,
                                                            desired_size_high,
                                                            desired_size_medium,
                                                            desired_size_low,
                                                            desired_size_finally)
                                        flexor.currentSize = currentSize
                                        
                                        // Let's see what we expect the result to be.
                                        let expected_ceiling: Int
                                        switch layoutPriority {
                                        case .required:
                                            expected_ceiling = desired_size_required
                                        case .high:
                                            expected_ceiling = desired_size_high
                                        case .medium:
                                            expected_ceiling = desired_size_medium
                                        case .low:
                                            expected_ceiling = desired_size_low
                                        case .finally:
                                            expected_ceiling = desired_size_finally
                                        }
                                        
                                        let expected_result: Int
                                        let expected_new_size: Int
                                        if currentSize >= expected_ceiling {
                                            expected_new_size = currentSize
                                            expected_result = available_space
                                        } else {
                                            
                                            let distance_to_ceiling = expected_ceiling - currentSize
                                            if distance_to_ceiling > available_space {
                                                // we take all available_space
                                                expected_new_size = currentSize + available_space
                                                expected_result = 0
                                            } else {
                                                // we take only distance_to_ceiling
                                                expected_new_size = currentSize + distance_to_ceiling
                                                expected_result = available_space - distance_to_ceiling
                                            }
                                        }
                                        
                                        let actual_result = flexor.ingestIfPossible(available_space: available_space,
                                                                                    layoutPriority: layoutPriority)
                                        let actual_new_size = flexor.currentSize
                                        
                                        if actual_result != expected_result {
                                            #expect(Bool(false))
                                            
                                            print("This was an invalid configuration.")
                                            print("desired_size_required = \(desired_size_required)")
                                            print("desired_size_high = \(desired_size_high)")
                                            print("desired_size_medium = \(desired_size_medium)")
                                            print("desired_size_low = \(desired_size_low)")
                                            print("desired_size_finally = \(desired_size_finally)")
                                            
                                            print("expected_result = \(expected_result)")
                                            print("expected_new_size = \(expected_new_size)")
                                            
                                            print("actual_result = \(actual_result)")
                                            print("actual_new_size = \(actual_new_size)")
                                            
                                            return
                                        }
                                        
                                        if actual_new_size != expected_new_size {
                                            #expect(Bool(false))
                                            return
                                        }
                                        
                                        loops += 1
                                    }
                                }
                            }
                            desired_size_finally += 1
                        }
                        desired_size_low += 1
                    }
                    desired_size_medium += 1
                }
                desired_size_high += 1
            }
            desired_size_required += 1
        }
        print("Tested with \(loops) loops. Success!")
    }
    
}
