//
//  Partitions.swift
//  OphiuchusTests
//
//  Created by Nick on 7/4/25.
//

import Foundation

func getAllPartitions<T>(_ array: [T]) -> [[[T]]] {
    var result = [[[T]]]()
    func backtrack(start: Int, path: [[T]]) {
        if start == array.count {
            result.append(path)
            return
        }
        for end in (start + 1)...array.count {
            let slice = Array(array[start..<end])
            backtrack(start: end, path: path + [slice])
        }
    }
    backtrack(start: 0, path: [])
    return result
}
