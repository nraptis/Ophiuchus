//
//  Subsets.swift
//  OphiuchusTests
//
//  Created by Nick on 7/4/25.
//

import Foundation

func getAllSubsets<Element: Comparable>(_ input: [Element])  -> [[Element]] {
    let input = input.sorted()
    var result = [[Element]]()
    result.append([])
    var index = 0
    while index < input.count {
        var duplicateCount = 1
        while (index + duplicateCount) < input.count && input[index + duplicateCount] == input[index] {
            duplicateCount += 1
        }
        
        let resultCount = result.count
        for resultIndex in 0..<resultCount {
            var array = result[resultIndex]
            for _ in 0..<duplicateCount {
                array.append(input[index])
                result.append(array)
            }
        }
        index += duplicateCount
    }
    return result
}
