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
        if !(flexer.getTargetSize(layoutPriority: .required) == 50) {
            print("getTargetSize(layoutPriority: .required) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 50) {
            print("getTargetSize(layoutPriority: .high) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 50) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 50) {
            print("getTargetSize(layoutPriority: .low) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 50) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 50")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_1() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 50)
        if !(flexer.getTargetSize(layoutPriority: .required) == 50) {
            print("getTargetSize(layoutPriority: .required) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 50) {
            print("getTargetSize(layoutPriority: .high) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 50) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 50) {
            print("getTargetSize(layoutPriority: .low) was expected to be 50")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 50) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 50")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_2_a() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 200, 250)
        if !(flexer.getTargetSize(layoutPriority: .required) == 200) {
            print("getTargetSize(layoutPriority: .required) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 250) {
            print("getTargetSize(layoutPriority: .high) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 250) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 250) {
            print("getTargetSize(layoutPriority: .low) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 250) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 250")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_2_b() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 200, nil, 250)
        if !(flexer.getTargetSize(layoutPriority: .required) == 200) {
            print("getTargetSize(layoutPriority: .required) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 200) {
            print("getTargetSize(layoutPriority: .high) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 250) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 250) {
            print("getTargetSize(layoutPriority: .low) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 250) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 250")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_2_c() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 200, nil, nil, 250)
        if !(flexer.getTargetSize(layoutPriority: .required) == 200) {
            print("getTargetSize(layoutPriority: .required) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 200) {
            print("getTargetSize(layoutPriority: .high) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 200) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 250) {
            print("getTargetSize(layoutPriority: .low) was expected to be 250")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 250) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 250")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_2_d() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 200, nil, nil, nil, 250)
        if !(flexer.getTargetSize(layoutPriority: .required) == 200) {
            print("getTargetSize(layoutPriority: .required) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 200) {
            print("getTargetSize(layoutPriority: .high) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 200) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 200) {
            print("getTargetSize(layoutPriority: .low) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 250) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 250")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_a() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, 600, 700)
        if !(flexer.getTargetSize(layoutPriority: .required) == 500) {
            print("getTargetSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 600) {
            print("getTargetSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 700) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 700")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 700) {
            print("getTargetSize(layoutPriority: .low) was expected to be 700")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 700) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_b() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, nil, 600, 700)
        if !(flexer.getTargetSize(layoutPriority: .required) == 500) {
            print("getTargetSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 500) {
            print("getTargetSize(layoutPriority: .high) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 600) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 700) {
            print("getTargetSize(layoutPriority: .low) was expected to be 700")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 700) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_c() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, nil, nil, 600, 700)
        if !(flexer.getTargetSize(layoutPriority: .required) == 500) {
            print("getTargetSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 500) {
            print("getTargetSize(layoutPriority: .high) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 500) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 600) {
            print("getTargetSize(layoutPriority: .low) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 700) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_d() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, 600, nil, 700)
        if !(flexer.getTargetSize(layoutPriority: .required) == 500) {
            print("getTargetSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 600) {
            print("getTargetSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 600) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 700) {
            print("getTargetSize(layoutPriority: .low) was expected to be 700")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 700) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_e() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, 600, nil, nil, 700)
        if !(flexer.getTargetSize(layoutPriority: .required) == 500) {
            print("getTargetSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 600) {
            print("getTargetSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 600) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 600) {
            print("getTargetSize(layoutPriority: .low) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 700) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_f() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, nil, 600, 700)
        if !(flexer.getTargetSize(layoutPriority: .required) == 500) {
            print("getTargetSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 500) {
            print("getTargetSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 600) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 700) {
            print("getTargetSize(layoutPriority: .low) was expected to be 700")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 700) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_g() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, nil, 600, nil, 700)
        if !(flexer.getTargetSize(layoutPriority: .required) == 500) {
            print("getTargetSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 500) {
            print("getTargetSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 600) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 600) {
            print("getTargetSize(layoutPriority: .low) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 700) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_3_h() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 500, nil, nil, 600, 700)
        if !(flexer.getTargetSize(layoutPriority: .required) == 500) {
            print("getTargetSize(layoutPriority: .required) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 500) {
            print("getTargetSize(layoutPriority: .high) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 500) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 600) {
            print("getTargetSize(layoutPriority: .low) was expected to be 600")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 700) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 700")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_4_a() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1000, 2000, 3000, 4000)
        if !(flexer.getTargetSize(layoutPriority: .required) == 1000) {
            print("getTargetSize(layoutPriority: .required) was expected to be 1000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 2000) {
            print("getTargetSize(layoutPriority: .high) was expected to be 2000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 3000) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 3000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 4000) {
            print("getTargetSize(layoutPriority: .low) was expected to be 4000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 4000) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 4000")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_4_b() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1000, nil, 2000, 3000, 4000)
        if !(flexer.getTargetSize(layoutPriority: .required) == 1000) {
            print("getTargetSize(layoutPriority: .required) was expected to be 1000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 1000) {
            print("getTargetSize(layoutPriority: .high) was expected to be 1000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 2000) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 2000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 3000) {
            print("getTargetSize(layoutPriority: .low) was expected to be 3000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 4000) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 4000")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_4_c() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1000, 2000, nil, 3000, 4000)
        if !(flexer.getTargetSize(layoutPriority: .required) == 1000) {
            print("getTargetSize(layoutPriority: .required) was expected to be 1000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 2000) {
            print("getTargetSize(layoutPriority: .high) was expected to be 2000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 2000) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 2000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 3000) {
            print("getTargetSize(layoutPriority: .low) was expected to be 3000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 4000) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 4000")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_initializer_4_d() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1000, 2000, 3000, nil, 4000)
        if !(flexer.getTargetSize(layoutPriority: .required) == 1000) {
            print("getTargetSize(layoutPriority: .required) was expected to be 1000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 2000) {
            print("getTargetSize(layoutPriority: .high) was expected to be 2000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 3000) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 3000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 3000) {
            print("getTargetSize(layoutPriority: .low) was expected to be 3000")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .finally) == 4000) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 4000")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_getTargetSize_a() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 100, 200, 300, 400, 500)
        if !(flexer.getTargetSize(layoutPriority: .finally) == 500) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 500")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 400) {
            print("getTargetSize(layoutPriority: .low) was expected to be 400")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 300) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 300")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 200) {
            print("getTargetSize(layoutPriority: .high) was expected to be 200")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .required) == 100) {
            print("getTargetSize(layoutPriority: .required) was expected to be 100")
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_size_flexer_getTargetSize_b() {
        let flexer = Flexer(id: 0, flexerIdentifier: .unknown, 1, 2, 3, 4, 5)
        if !(flexer.getTargetSize(layoutPriority: .finally) == 5) {
            print("getTargetSize(layoutPriority: .finally) was expected to be 5")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .low) == 4) {
            print("getTargetSize(layoutPriority: .low) was expected to be 4")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .medium) == 3) {
            print("getTargetSize(layoutPriority: .medium) was expected to be 3")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .high) == 2) {
            print("getTargetSize(layoutPriority: .high) was expected to be 2")
            #expect(Bool(false))
            return
        }
        if !(flexer.getTargetSize(layoutPriority: .required) == 1) {
            print("getTargetSize(layoutPriority: .required) was expected to be 1")
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
        var desiredSizeRequired = 0
        while desiredSizeRequired <= ceiling {
            var desiredSizeHigh = desiredSizeRequired
            while desiredSizeHigh <= ceiling {
                var desiredSizeMedium = desiredSizeHigh
                while desiredSizeMedium <= ceiling {
                    var desiredSizeLow = desiredSizeMedium
                    while desiredSizeLow <= ceiling {
                        var desiredSizeFinally = desiredSizeLow
                        while desiredSizeFinally <= ceiling {
                            
                            let flexor = Flexer(id: 0, flexerIdentifier: .unknown, desiredSizeRequired,
                                                            desiredSizeHigh,
                                                            desiredSizeMedium,
                                                            desiredSizeLow,
                                                            desiredSizeFinally)
                            if !flexor.validate_desired_sizes() {
                                print("This was an invalid configuration.")
                                print("desiredSizeRequired = \(desiredSizeRequired)")
                                print("desiredSizeHigh = \(desiredSizeHigh)")
                                print("desiredSizeMedium = \(desiredSizeMedium)")
                                print("desiredSizeLow = \(desiredSizeLow)")
                                print("desiredSizeFinally = \(desiredSizeFinally)")
                                
                                #expect(Bool(false))
                                return
                            }
                            
                            if flexor.getTargetSize(layoutPriority: .finally) != desiredSizeFinally {
                                #expect(Bool(false))
                                return
                            }
                            
                            if flexor.getTargetSize(layoutPriority: .low) != desiredSizeLow {
                                #expect(Bool(false))
                                return
                            }
                            
                            if flexor.getTargetSize(layoutPriority: .medium) != desiredSizeMedium {
                                #expect(Bool(false))
                                return
                            }
                            
                            if flexor.getTargetSize(layoutPriority: .high) != desiredSizeHigh {
                                #expect(Bool(false))
                                return
                            }
                            
                            if flexor.getTargetSize(layoutPriority: .required) != desiredSizeRequired {
                                #expect(Bool(false))
                                return
                            }
                            
                            loops += 1
                            desiredSizeFinally += 1
                        }
                        desiredSizeLow += 1
                    }
                    desiredSizeMedium += 1
                }
                desiredSizeHigh += 1
            }
            desiredSizeRequired += 1
        }
        print("Tested with \(loops) loops. Success!")
    }
    
    @Test func test_size_flexer_loops_ingest() {
        var loops = 0
        let ceiling = 8
        var desiredSizeRequired = 0
        while desiredSizeRequired <= ceiling {
            var desiredSizeHigh = desiredSizeRequired
            while desiredSizeHigh <= ceiling {
                var desiredSizeMedium = desiredSizeHigh
                while desiredSizeMedium <= ceiling {
                    var desiredSizeLow = desiredSizeMedium
                    while desiredSizeLow <= ceiling {
                        var desiredSizeFinally = desiredSizeLow
                        while desiredSizeFinally <= ceiling {
                            for layoutPriority in [LayoutPriority.required,
                                             LayoutPriority.high,
                                             LayoutPriority.medium,
                                             LayoutPriority.low,
                                             LayoutPriority.finally] {
                                
                                for _ in 0..<64 {
                                    let currentSize = Int.random(in: 0...256)
                                    
                                    for _ in 0..<64 {
                                        
                                        let available_space = Int.random(in: 0...512)
                                        
                                        let flexor = Flexer(id: 0, flexerIdentifier: .unknown, desiredSizeRequired,
                                                            desiredSizeHigh,
                                                            desiredSizeMedium,
                                                            desiredSizeLow,
                                                            desiredSizeFinally)
                                        flexor.currentSize = currentSize
                                        
                                        // Let's see what we expect the result to be.
                                        let expected_ceiling: Int
                                        switch layoutPriority {
                                        case .required:
                                            expected_ceiling = desiredSizeRequired
                                        case .high:
                                            expected_ceiling = desiredSizeHigh
                                        case .medium:
                                            expected_ceiling = desiredSizeMedium
                                        case .low:
                                            expected_ceiling = desiredSizeLow
                                        case .finally:
                                            expected_ceiling = desiredSizeFinally
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
                                            print("desiredSizeRequired = \(desiredSizeRequired)")
                                            print("desiredSizeHigh = \(desiredSizeHigh)")
                                            print("desiredSizeMedium = \(desiredSizeMedium)")
                                            print("desiredSizeLow = \(desiredSizeLow)")
                                            print("desiredSizeFinally = \(desiredSizeFinally)")
                                            
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
                            desiredSizeFinally += 1
                        }
                        desiredSizeLow += 1
                    }
                    desiredSizeMedium += 1
                }
                desiredSizeHigh += 1
            }
            desiredSizeRequired += 1
        }
        print("Tested with \(loops) loops. Success!")
    }
    
}
