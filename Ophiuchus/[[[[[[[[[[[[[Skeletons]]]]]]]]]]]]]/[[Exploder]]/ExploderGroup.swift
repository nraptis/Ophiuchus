//
//  ExploderGroup.swift
//  Ophiuchus
//
//  Created by Nick on 7/4/25.
//

import Foundation

public class ExploderGroup<Element: ExploderConforming> {
    
    let id: Int
    let linkedList: [Element]
    let set: Set<Int>
    let layoutPriority: LayoutPriority
    var smallestList = [Element]()
    
    //var isActiveAtCurrentPriorityOrMono = false
    //var isActiveAtCurrentPriority = false
    var isActiveAtCurrentPriority = false
    var isMono = false
    
    //var isUbiquitousA = false
    //var isUbiquitousB = false
    
    
    var isLockedAtEveryPriority = false
    var isLockedAtCurrentPriority = false
    
    var isAllEqualAtCurrentPriority = false
    
    private(set) var secondSmallestValue = 0
    
    
    init(id: Int,
         linkedList: [Element],
         layoutPriority: LayoutPriority) {
        self.id = id
        self.linkedList = linkedList
        self.set = Set(linkedList.map { $0.id })
        self.layoutPriority = layoutPriority
    }
    
    func computeSmallestIfNotAllEqual() -> Bool {
        if linkedList.count <= 1 {
            return false
        }
        
        var smallestValue = Int.max
        secondSmallestValue = Int.max
        
        for element in linkedList {
            let currentSize = element.currentSize
            if currentSize < smallestValue {
                secondSmallestValue = smallestValue
                smallestValue = currentSize
            } else {
                if currentSize > smallestValue && currentSize < secondSmallestValue {
                    secondSmallestValue = currentSize
                }
            }
        }
        
        guard secondSmallestValue != Int.max else {
            return false
        }
        
        smallestList.removeAll(keepingCapacity: true)
        for element in linkedList {
            if element.currentSize == smallestValue {
                smallestList.append(element)
            }
        }
        return true
    }
    
    func isLargestSize(element: Element) -> Bool {
        var largestSize = -999_999
        for item in linkedList {
            if item.currentSize > largestSize {
                largestSize = item.currentSize
            }
        }
        if element.currentSize == largestSize {
            return true
        } else {
            return false
        }
    }
    
    func getLargestSize() -> Int {
        var largestSize = 0
        for item in linkedList {
            if item.currentSize > largestSize {
                largestSize = item.currentSize
            }
        }
        return largestSize
    }
    
    func areAllEqualSize() -> Bool {
        
        if linkedList.count <= 1 { return true }
        let size = linkedList[0].currentSize
        for item in linkedList {
            if item.currentSize != size {
                return false
            }
        }
        return true
    }
    
    
    func matchesPriority(layoutPriority: LayoutPriority) -> Bool {
        if self.layoutPriority.gte(layoutPriority: layoutPriority) {
            return true
        } else {
            return false
        }
    }
    
    func matchesPriorityOrMono(layoutPriority: LayoutPriority) -> Bool {
        if linkedList.count <= 1 {
            return true
        } else if self.layoutPriority.gte(layoutPriority: layoutPriority) {
            return true
        } else {
            return false
        }
    }
    
    func contains(elements: [any ExploderConforming]) -> Bool {
        for item in elements {
            if !(set.contains(item.id)) {
                return false
            }
        }
        return true
    }
    
}


extension ExploderGroup where Element: Flexer {

    // @Precondition: "flexer.targetSizeCurrentPriority" is accurate.
    func areAllEqualSizeAndAbleToGrowAtCurrentPriority() -> Bool {
        if linkedList.count <= 0 { return false }
        let size = linkedList[0].currentSize
        for flexer in linkedList {
            if flexer.currentSize != size { return false }
            if flexer.currentSize >= flexer.targetSizeCurrentPriority { return false }
        }
        return true
    }
    
    func areAllAbleToGrowAtCurrentPriority() -> Bool {
        for flexer in linkedList {
            if flexer.currentSize >= flexer.targetSizeCurrentPriority {
                return false
            }
        }
        return true
    }
    
    func areAnyAbleToGrowAtCurrentPriority() -> Bool {
        for flexer in linkedList {
            if flexer.currentSize < flexer.targetSizeCurrentPriority {
                return true
            }
        }
        return false
    }
    
    func getLargestTargetSizeCurrentPriority() -> Int {
        var result = 0
        for flexer in linkedList {
            if flexer.targetSizeCurrentPriority > result {
                result = flexer.targetSizeCurrentPriority
            }
        }
        return result
    }
    
    
}
