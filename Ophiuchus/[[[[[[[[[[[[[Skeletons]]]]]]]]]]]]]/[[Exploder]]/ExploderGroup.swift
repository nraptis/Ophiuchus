//
//  ExploderGroup.swift
//  Ophiuchus
//
//  Created by Nick on 7/4/25.
//

import Foundation

public class ExploderGroup<Element: ExploderConforming> {
    let linkedList: [Element]
    let set: Set<Int>
    let layoutPriority: LayoutPriority
    var smallestList = [Element]()
    var smallest_stride = 0
    init(linkedList: [Element], layoutPriority: LayoutPriority) {
        self.linkedList = linkedList
        self.set = Set(linkedList.map { $0.id })
        self.layoutPriority = layoutPriority
    }
    
    func compute_smallest() {
        smallestList.removeAll(keepingCapacity: true)
        smallest_stride = 0
        
        if linkedList.count <= 1 { return }
        
        var smallest_value = Int.max
        var second_smallest_value = Int.max
        
        for element in linkedList {
            let currentSize = element.currentSize
            if currentSize < smallest_value {
                second_smallest_value = smallest_value
                smallest_value = currentSize
            } else {
                if currentSize > smallest_value && currentSize < second_smallest_value {
                    second_smallest_value = currentSize
                }
            }
        }
        
        guard second_smallest_value != Int.max else {
            return
        }
        
        for element in linkedList {
            if element.currentSize == smallest_value {
                smallestList.append(element)
            }
        }
        smallest_stride = second_smallest_value - smallest_value
    }
    
    func is_largest(_ element: Element) -> Bool {
        var largest_size = -999_999
        for _element in linkedList {
            if _element.currentSize > largest_size {
                largest_size = _element.currentSize
            }
        }
        if element.currentSize == largest_size {
            return true
        } else {
            return false
        }
    }
    
    func is_all_same_currentSize() -> Bool {
        if linkedList.count <= 1 { return true }
        let chosen_size = linkedList[0].currentSize
        for _element in linkedList {
            if _element.currentSize != chosen_size { return false }
        }
        return true
    }
    
}
