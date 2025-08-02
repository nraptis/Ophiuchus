//
//  ExploderGroupFlexers.swift
//  Ophiuchus
//
//  Created by Nick on 8/2/25.
//

import Foundation

public class ExploderGroupFlexers {
    let flexers: [Flexer]
    let set: Set<Int>
    let layoutPriority: LayoutPriority
    //let growPlans: [GrowPlan]
    var smallestList = [Flexer]()
    var smallest_stride = 0
    
    init(flexers: [Flexer],
         //growPlans: [GrowPlan],
         layoutPriority: LayoutPriority) {
        self.flexers = flexers
        self.set = Set(flexers.map { $0.id })
        self.layoutPriority = layoutPriority
        //self.growPlans = growPlans
        
        /*
        var _growPlans = [GrowPlan]()
        var sectionMap = [Int: GrowPlan]()
        
        for flexer in linkedList {
            
            if let existingGrowPlan = sectionMap[flexer.section.id] {
                existingGrowPlan.amount += 1
            } else {
                let growPlan = GrowPlan(row: flexer.row,
                                              section: flexer.section)
                sectionMap[flexer.section.id] = growPlan
            }
        }
        */
    }
    
    /*
    func compute_smallest() {
        smallestList.removeAll(keepingCapacity: true)
        smallest_stride = 0
        
        if flexers.count <= 1 { return }
        
        guard let smallestSize = Exploder.smallestSizeUnique(list: flexers) else { return }
        
        var smallest_value = Int.max
        var second_smallest_value = Int.max
        
        for _flexer in flexers {
            let currentSize = _flexer.currentSize
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
        
        for _flexer in flexers {
            if _flexer.currentSize == smallest_value {
                smallestList.append(_flexer)
            }
        }
        smallest_stride = second_smallest_value - smallest_value
    }
    */
    
    func isLargestSize(flexer: Flexer) -> Bool {
        let result = ExploderHelper.isLargestSize(item: flexer, list: flexers)
        return result
    }
    
    func isAllEqualSize() -> Bool {
        let result = ExploderHelper.isAllEqualSize(list: flexers)
        return result
    }
    
}
