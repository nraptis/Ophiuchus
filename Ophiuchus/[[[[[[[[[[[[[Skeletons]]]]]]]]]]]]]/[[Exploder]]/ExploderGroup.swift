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
            let current_size = element.current_size
            if current_size < smallest_value {
                second_smallest_value = smallest_value
                smallest_value = current_size
            } else {
                if current_size > smallest_value && current_size < second_smallest_value {
                    second_smallest_value = current_size
                }
            }
        }
        
        guard second_smallest_value != Int.max else {
            return
        }
        
        for element in linkedList {
            if element.current_size == smallest_value {
                smallestList.append(element)
            }
        }
        smallest_stride = second_smallest_value - smallest_value
    }
    
    func is_largest(_ element: Element) -> Bool {
        var largest_size = -999_999
        for _element in linkedList {
            if _element.current_size > largest_size {
                largest_size = _element.current_size
            }
        }
        if element.current_size == largest_size {
            return true
        } else {
            return false
        }
    }
    
    func is_all_same_current_size() -> Bool {
        if linkedList.count <= 1 { return true }
        let chosen_size = linkedList[0].current_size
        for _element in linkedList {
            if _element.current_size != chosen_size { return false }
        }
        return true
    }
    
}
