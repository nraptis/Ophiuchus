//
//  RowOverlapTests.swift
//  OphiuchusTests
//
//  Created by Nick on 7/10/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct RowOverlapTests {
    
    func generate_row(x1: Int, width1: Int, x2: Int, width2: Int) -> SkeletonRow {
        let section_a = GenerateSections.generate_alreadyPlaced(x: x1, width: width1)
        let section_b = GenerateSections.generate_alreadyPlaced(x: x2, width: width2)
        let result = GenerateRows.generate(sections: [section_a, section_b], centeredSection: nil)
        return result
    }
    
    @Test func test_row_overlap_zero_width_a() {
        let row = generate_row(x1: 0, width1: 0, x2: 0, width2: 0)
        if row.sectionsOverlap_test() {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_row_overlap_zero_width_b() {
        let row = generate_row(x1: 0, width1: 100, x2: 0, width2: 0)
        if row.sectionsOverlap_test() {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_row_overlap_zero_width_c() {
        let row = generate_row(x1: 0, width1: 0, x2: 0, width2: 100)
        if row.sectionsOverlap_test() {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_row_overlap_zero_width_d() {
        let row = generate_row(x1: 0, width1: 100, x2: 50, width2: 0)
        if !row.sectionsOverlap_test() {
            #expect(Bool(false))
            return
        }
    }
    
    @Test func test_row_overlap_zero_width_e() {
        let row = generate_row(x1: 50, width1: 0, x2: 0, width2: 100)
        if !row.sectionsOverlap_test() {
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_short
    //b_short
    @Test func test_row_overlap_a_left_of_b_a_short_b_short() {
        let x1 = 100
        let width1 = 50
        let x2 = 200
        let width2 = 50
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_short_b_short has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_short
    //b_medium
    @Test func test_row_overlap_a_left_of_b_a_short_b_medium() {
        let x1 = 100
        let width1 = 50
        let x2 = 200
        let width2 = 100
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_short_b_medium has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_short
    //b_long
    @Test func test_row_overlap_a_left_of_b_a_short_b_long() {
        let x1 = 100
        let width1 = 50
        let x2 = 200
        let width2 = 150
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_short_b_long has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_short
    //b_huge
    @Test func test_row_overlap_a_left_of_b_a_short_b_huge() {
        let x1 = 100
        let width1 = 50
        let x2 = 200
        let width2 = 1000
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_short_b_huge has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_medium
    //b_short
    @Test func test_row_overlap_a_left_of_b_a_medium_b_short() {
        let x1 = 100
        let width1 = 100
        let x2 = 200
        let width2 = 50
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_medium_b_short has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_medium
    //b_medium
    @Test func test_row_overlap_a_left_of_b_a_medium_b_medium() {
        let x1 = 100
        let width1 = 100
        let x2 = 200
        let width2 = 100
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_medium_b_medium has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_medium
    //b_long
    @Test func test_row_overlap_a_left_of_b_a_medium_b_long() {
        let x1 = 100
        let width1 = 100
        let x2 = 200
        let width2 = 150
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_medium_b_long has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_medium
    //b_huge
    @Test func test_row_overlap_a_left_of_b_a_medium_b_huge() {
        let x1 = 100
        let width1 = 100
        let x2 = 200
        let width2 = 1000
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_medium_b_huge has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_long
    //b_short
    @Test func test_row_overlap_a_left_of_b_a_long_b_short() {
        let x1 = 100
        let width1 = 150
        let x2 = 200
        let width2 = 50
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_long_b_short has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_long
    //b_medium
    @Test func test_row_overlap_a_left_of_b_a_long_b_medium() {
        let x1 = 100
        let width1 = 150
        let x2 = 200
        let width2 = 100
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_long_b_medium has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_long
    //b_long
    @Test func test_row_overlap_a_left_of_b_a_long_b_long() {
        let x1 = 100
        let width1 = 150
        let x2 = 200
        let width2 = 150
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_long_b_long has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_long
    //b_huge
    @Test func test_row_overlap_a_left_of_b_a_long_b_huge() {
        let x1 = 100
        let width1 = 150
        let x2 = 200
        let width2 = 1000
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_long_b_huge has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_huge
    //b_short
    @Test func test_row_overlap_a_left_of_b_a_huge_b_short() {
        let x1 = 100
        let width1 = 1000
        let x2 = 200
        let width2 = 50
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_huge_b_short has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_huge
    //b_medium
    @Test func test_row_overlap_a_left_of_b_a_huge_b_medium() {
        let x1 = 100
        let width1 = 1000
        let x2 = 200
        let width2 = 100
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_huge_b_medium has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_huge
    //b_long
    @Test func test_row_overlap_a_left_of_b_a_huge_b_long() {
        let x1 = 100
        let width1 = 1000
        let x2 = 200
        let width2 = 150
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_huge_b_long has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_left_of_b
    //a_huge
    //b_huge
    @Test func test_row_overlap_a_left_of_b_a_huge_b_huge() {
        let x1 = 100
        let width1 = 1000
        let x2 = 200
        let width2 = 1000
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_left_of_b_a_huge_b_huge has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_short
    //b_short
    @Test func test_row_overlap_a_right_of_b_a_short_b_short() {
        let x1 = 200
        let width1 = 50
        let x2 = 100
        let width2 = 50
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_short_b_short has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_short
    //b_medium
    @Test func test_row_overlap_a_right_of_b_a_short_b_medium() {
        let x1 = 200
        let width1 = 50
        let x2 = 100
        let width2 = 100
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_short_b_medium has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_short
    //b_long
    @Test func test_row_overlap_a_right_of_b_a_short_b_long() {
        let x1 = 200
        let width1 = 50
        let x2 = 100
        let width2 = 150
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_short_b_long has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_short
    //b_huge
    @Test func test_row_overlap_a_right_of_b_a_short_b_huge() {
        let x1 = 200
        let width1 = 50
        let x2 = 100
        let width2 = 1000
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_short_b_huge has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_medium
    //b_short
    @Test func test_row_overlap_a_right_of_b_a_medium_b_short() {
        let x1 = 200
        let width1 = 100
        let x2 = 100
        let width2 = 50
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_medium_b_short has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_medium
    //b_medium
    @Test func test_row_overlap_a_right_of_b_a_medium_b_medium() {
        let x1 = 200
        let width1 = 100
        let x2 = 100
        let width2 = 100
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_medium_b_medium has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_medium
    //b_long
    @Test func test_row_overlap_a_right_of_b_a_medium_b_long() {
        let x1 = 200
        let width1 = 100
        let x2 = 100
        let width2 = 150
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_medium_b_long has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_medium
    //b_huge
    @Test func test_row_overlap_a_right_of_b_a_medium_b_huge() {
        let x1 = 200
        let width1 = 100
        let x2 = 100
        let width2 = 1000
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_medium_b_huge has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_long
    //b_short
    @Test func test_row_overlap_a_right_of_b_a_long_b_short() {
        let x1 = 200
        let width1 = 150
        let x2 = 100
        let width2 = 50
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_long_b_short has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_long
    //b_medium
    @Test func test_row_overlap_a_right_of_b_a_long_b_medium() {
        let x1 = 200
        let width1 = 150
        let x2 = 100
        let width2 = 100
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_long_b_medium has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_long
    //b_long
    @Test func test_row_overlap_a_right_of_b_a_long_b_long() {
        let x1 = 200
        let width1 = 150
        let x2 = 100
        let width2 = 150
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_long_b_long has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_long
    //b_huge
    @Test func test_row_overlap_a_right_of_b_a_long_b_huge() {
        let x1 = 200
        let width1 = 150
        let x2 = 100
        let width2 = 1000
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_long_b_huge has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_huge
    //b_short
    @Test func test_row_overlap_a_right_of_b_a_huge_b_short() {
        let x1 = 200
        let width1 = 1000
        let x2 = 100
        let width2 = 50
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_huge_b_short has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_huge
    //b_medium
    @Test func test_row_overlap_a_right_of_b_a_huge_b_medium() {
        let x1 = 200
        let width1 = 1000
        let x2 = 100
        let width2 = 100
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // not overlap
        if row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_huge_b_medium has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_huge
    //b_long
    @Test func test_row_overlap_a_right_of_b_a_huge_b_long() {
        let x1 = 200
        let width1 = 1000
        let x2 = 100
        let width2 = 150
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_huge_b_long has failed...")
            #expect(Bool(false))
            return
        }
    }
    
    //a_right_of_b
    //a_huge
    //b_huge
    @Test func test_row_overlap_a_right_of_b_a_huge_b_huge() {
        let x1 = 200
        let width1 = 1000
        let x2 = 100
        let width2 = 1000
        let row = generate_row(x1: x1, width1: width1, x2: x2, width2: width2)
        
        // yes overlap
        if !row.sectionsOverlap_test() {
            print("test_row_overlap_a_right_of_b_a_huge_b_huge has failed...")
            #expect(Bool(false))
            return
        }
    }
    
}
