//
//  ExploderGroupChunks.swift
//  Ophiuchus
//
//  Created by Nick on 7/5/25.
//

import Foundation

public class ExploderGroupChunks {
    let linkedList: [any SkeletonChunkConforming]
    let layoutPriority: LayoutPriority
    let set: Set<Int>
    
    var smallestList = [any SkeletonChunkConforming]()
    var smallest_stride = 0
    
    init(linkedList: [any SkeletonChunkConforming],
         layoutPriority: LayoutPriority) {
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
        let smallest = linkedList[0]
        for element in linkedList {
            if element.currentSize == smallest_value {
                smallestList.append(element)
            }
        }
        smallest_stride = second_smallest_value - smallest_value
    }
    
}
