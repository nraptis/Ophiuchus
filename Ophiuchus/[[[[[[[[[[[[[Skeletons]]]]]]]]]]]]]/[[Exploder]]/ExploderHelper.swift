//
//  ExploderHelper.swift
//  Ophiuchus
//
//  Created by Nick on 8/2/25.
//

import Foundation

public struct ExploderHelper {
    
    public static func smallestSizeUnique(list: [ExploderConforming]) -> Int? {
        var smallest_value = Int.max
        var second_smallest_value = Int.max
        for _item in list {
            let currentSize = _item.currentSize
            if currentSize < smallest_value {
                second_smallest_value = smallest_value
                smallest_value = currentSize
            } else {
                if currentSize > smallest_value && currentSize < second_smallest_value {
                    second_smallest_value = currentSize
                }
            }
        }
        if second_smallest_value == Int.max {
            return nil
        }
        return smallest_value
    }
    
    public static func isLargestSize(item: ExploderConforming, list: [ExploderConforming]) -> Bool {
        var largest_size = -999_999
        for _item in list {
            if _item.currentSize > largest_size {
                largest_size = _item.currentSize
            }
        }
        if item.currentSize == largest_size {
            return true
        } else {
            return false
        }
    }
    
    public static func isAllEqualSize(list: [ExploderConforming]) -> Bool {
        if list.count <= 1 { return true }
        let size = list[0].currentSize
        for _item in list {
            if _item.currentSize != size {
                return false
            }
        }
        return true
    }
    
}
