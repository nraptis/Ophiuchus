//
//  ProperlyCenteredTests.swift
//  OphiuchusTests
//
//  Created by Nick on 8/1/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct ProperlyCenteredTests {
    
    @Test func test_basic_working_example() {
        if !SkeletonRow.isCenterSectionProperlyCentered(leftSize: 100,
                                                        centerSize: 100,
                                                        rightSize: 100,
                                                        menuWidthWithSafeArea: 1000,
                                                        safeAreaLeft: 0,
                                                        safeAreaRight: 0) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_basic_not_working_example() {
        if SkeletonRow.isCenterSectionProperlyCentered(leftSize: 100,
                                                       centerSize: 100,
                                                       rightSize: 100,
                                                       menuWidthWithSafeArea: 100,
                                                       safeAreaLeft: 0,
                                                       safeAreaRight: 0) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_edge_case_left_a() {
        if !SkeletonRow.isCenterSectionProperlyCentered(leftSize: 50,
                                                        centerSize: 100,
                                                        rightSize: 10,
                                                        menuWidthWithSafeArea: 200,
                                                        safeAreaLeft: 0,
                                                        safeAreaRight: 0) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_edge_case_left_b() {
        if SkeletonRow.isCenterSectionProperlyCentered(leftSize: 51,
                                                        centerSize: 100,
                                                        rightSize: 10,
                                                        menuWidthWithSafeArea: 200,
                                                        safeAreaLeft: 0,
                                                        safeAreaRight: 0) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_edge_case_right_a() {
        if !SkeletonRow.isCenterSectionProperlyCentered(leftSize: 10,
                                                        centerSize: 100,
                                                        rightSize: 50,
                                                        menuWidthWithSafeArea: 200,
                                                        safeAreaLeft: 0,
                                                        safeAreaRight: 0) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_edge_case_right_b() {
        if SkeletonRow.isCenterSectionProperlyCentered(leftSize: 10,
                                                        centerSize: 100,
                                                        rightSize: 51,
                                                        menuWidthWithSafeArea: 200,
                                                        safeAreaLeft: 0,
                                                        safeAreaRight: 0) {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_1000_passing_cases() {
        
        for _ in 0..<1000 {
            if !SkeletonRow.isCenterSectionProperlyCentered(leftSize: Int.random(in: 0...100),
                                                            centerSize: Int.random(in: 0...100),
                                                            rightSize: Int.random(in: 0...100),
                                                            menuWidthWithSafeArea: 300,
                                                            safeAreaLeft: 0,
                                                            safeAreaRight: 0) {
                #expect(Bool(false))
                return
            }
            
        }
    }
    
    @Test func test_5000_manual_cases_a() {
        
        // Here I am essentially typing the same
        // formula 3 different ways; this ensures
        // that there is no mistake in the test
        // or in the code itself...
        
        for _ in 0..<5000 {
            let left = Int.random(in: 0...100)
            let center = Int.random(in: 0...100)
            let right = Int.random(in: 0...100)
            let menuWidthWithSafeArea = Int.random(in: 0...400)
            let safeAreaLeft = 0
            let safeAreaRight = 0
            let menuWidth = (menuWidthWithSafeArea - safeAreaLeft - safeAreaRight)
            let centerCenterX = (menuWidth / 2)
            let center2 = center / 2
            let centerLeft = centerCenterX - center2
            let centerRight = centerLeft + center
            var isExpectedToPass = true
            
            if left > centerLeft { isExpectedToPass = false }
            let rightX = menuWidth - right
            if centerRight > rightX { isExpectedToPass = false }
            
            if SkeletonRow.isCenterSectionProperlyCentered(leftSize: left,
                                                            centerSize: center,
                                                            rightSize: right,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight) != isExpectedToPass {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @Test func test_5000_manual_cases_b() {
        
        // Here I am essentially typing the same
        // formula 3 different ways; this ensures
        // that there is no mistake in the test
        // or in the code itself...
        
        for _ in 0..<5000 {
            let left = Int.random(in: 0...256)
            let center = Int.random(in: 0...256)
            let right = Int.random(in: 0...256)
            let menuWidthWithSafeArea = Int.random(in: 0...768)
            let safeAreaLeft = Int.random(in: 0...256)
            let safeAreaRight = Int.random(in: 0...256)
            
            var isExpectedToPass = true
            
            var rowSize = (menuWidthWithSafeArea)
            rowSize -= safeAreaLeft
            rowSize -= safeAreaRight
            
            let rowSize2 = rowSize / 2
            
            let centerLeft = rowSize2 - (center / 2)
            let centerRight = centerLeft + center
            
            let leftX = left
            if leftX > centerLeft { isExpectedToPass = false }
            
            let rightX = (menuWidthWithSafeArea - safeAreaLeft - safeAreaRight - right)
            if rightX < centerRight { isExpectedToPass = false }
            
            if SkeletonRow.isCenterSectionProperlyCentered(leftSize: left,
                                                            centerSize: center,
                                                            rightSize: right,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight) != isExpectedToPass {
                #expect(Bool(false))
                return
            }
        }
    }
    
    @Test func test_5000_manual_cases_c() {
        
        // Here I am essentially typing the same
        // formula 3 different ways; this ensures
        // that there is no mistake in the test
        // or in the code itself...
        
        for _ in 0..<5000 {
            let left = Int.random(in: 0...512)
            let center = Int.random(in: 0...512)
            let right = Int.random(in: 0...512)
            let menuWidthWithSafeArea = Int.random(in: 0...1024)
            let safeAreaLeft = Int.random(in: 0...64)
            let safeAreaRight = Int.random(in: 0...64)
            
            var isExpectedToPass = true
            
            let half_x = (menuWidthWithSafeArea - safeAreaLeft - safeAreaRight) >> 1
            let center_x1 = half_x - (center >> 1) + safeAreaLeft
            let center_x2 = center_x1 + center
            
            let left_x = left + safeAreaLeft
            let right_x = (menuWidthWithSafeArea - safeAreaRight) - right
            
            if left_x > center_x1 { isExpectedToPass = false }
            if right_x < center_x2 { isExpectedToPass = false }
            
            if SkeletonRow.isCenterSectionProperlyCentered(leftSize: left,
                                                            centerSize: center,
                                                            rightSize: right,
                                                            menuWidthWithSafeArea: menuWidthWithSafeArea,
                                                            safeAreaLeft: safeAreaLeft,
                                                            safeAreaRight: safeAreaRight) != isExpectedToPass {
                #expect(Bool(false))
                return
            }
            
        }
    }
}
