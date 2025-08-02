//
//  Permutations.swift
//  OphiuchusTests
//
//  Created by Nick on 7/4/25.
//

import Foundation

func getAllPermutations<Element: Comparable>(_ input: [Element])  -> [[Element]] {
    
    var result = [[Element]]()
    var list = [Element]()
    let input = input.sorted()
    var visited = [Bool](repeating: false, count: input.count)
    
    func helper() {
        if list.count == input.count {
            result.append(list)
            return
        }
        for index in input.indices {
            if visited[index] {
                continue
            }
            if index > 0, !visited[index - 1], input[index] == input[index - 1] {
                continue
            }
            list.append(input[index])
            visited[index] = true
            
            helper()
            
            list.removeLast()
            visited[index] = false
        }
    }
    helper()
    return result
}

