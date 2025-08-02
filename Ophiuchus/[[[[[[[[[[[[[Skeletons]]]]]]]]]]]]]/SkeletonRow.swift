//
//  SkeletonRow.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

enum SkeletonRowInitialLayoutType {
    case doesNotIncludeCenterSection
    case centerSectionProperlyCentered
    case centerSectionSkewed
}

public class SkeletonRow: CustomStringConvertible {
    public var description: String {
        
        let isCenter = (attemptedCenteredSection !== nil)
        let id = ObjectIdentifier(self)
        var result = "SkeletonRow[\(id)] cs: \(children_size), rs: \(remaining_size), sec: \(sections.count), ctr: \(isCenter)"
        if isCenter {
            result += " cl: \(left_size), cc: \(center_size) cr: \(right_size)"
        } else {
            result += " tsr: \(temp_size_required)"
        }
        return result
    }
    
    static func isCenterSectionProperlyCentered(leftSize: Int,
                                                centerSize: Int,
                                                rightSize: Int,
                                                menuWidthWithSafeArea: Int,
                                                safeAreaLeft: Int,
                                                safeAreaRight: Int) -> Bool {
        let _max_size = menuWidthWithSafeArea - safeAreaLeft - safeAreaRight
        let _max_size_2 = (_max_size / 2)
        
        let _center_size_2 = (centerSize / 2)
        let _center_left_x = _max_size_2 - _center_size_2
        if leftSize > _center_left_x {
            // In this case, the left is too large.
            return false
        }
        
        let _center_right_x = _center_left_x + centerSize
        let rightWall = _max_size - rightSize
        
        if _center_right_x > rightWall {
            // In this case, the right is too large.
            return false
        }
        
        return true
    }
    
    var temp_size_required = 0
    var temp_size_high = 0
    var temp_size_medium = 0
    var temp_size_low = 0
    var temp_size_finally = 0
    
    var children_size = 0
    var remaining_size = 0
    
    var max_size = 0
    var max_size_2 = 0
    var left_size = 0
    var right_size = 0
    var center_size = 0
    
    let sections: [SkeletonSection]
    let attemptedCenteredSection: SkeletonSection?
    var attemptedCenteredSectionIndex = 0
    var initialLayoutType = SkeletonRowInitialLayoutType.doesNotIncludeCenterSection
    
    
    public init() {
        self.sections = []
        self.attemptedCenteredSection = nil
    }
    
    public init(sections: [SkeletonSection],
         attemptedCenteredSection: SkeletonSection?) {
        self.sections = sections
        self.attemptedCenteredSection = attemptedCenteredSection
    }
    
    func getSectionIndex(section: SkeletonSection) -> Int? {
        for sectionIndex in 0..<sections.count {
            if sections[sectionIndex] === section {
                return sectionIndex
            }
        }
        return nil
    }
    
    func validate(strict_centering: Bool,
                  menuWidthWithSafeArea: Int,
                  safeAreaLeft: Int,
                  safeAreaRight: Int) -> Bool {
        
        let min_x = safeAreaLeft
        let max_x = menuWidthWithSafeArea - safeAreaRight
        
        for section in sections {
            let start_x = section.x
            let end_x = start_x + section.width
            if start_x < min_x { return false }
            if end_x > max_x { return false }
        }
        
        if let attemptedCenteredSection = attemptedCenteredSection {
            if strict_centering {
                
                let _center_size = attemptedCenteredSection.width
                let _center_size_2 = (_center_size / 2)
                
                let _max_size = menuWidthWithSafeArea - safeAreaLeft - safeAreaRight
                let _max_size_2 = (_max_size / 2)
                
                let valid_x = safeAreaLeft + _max_size_2 - _center_size_2
                if attemptedCenteredSection.x != valid_x { return false }
            }
        }
        return true
    }
    
    func prepare() {
        attemptedCenteredSectionIndex = -1
        if let attemptedCenteredSection = attemptedCenteredSection {
            var didFindCenterSection = false
            for sectionIndex in 0..<sections.count {
                let section = sections[sectionIndex]
                section.indexInRow = sectionIndex
                if section === attemptedCenteredSection {
                    didFindCenterSection = true
                    attemptedCenteredSectionIndex = sectionIndex
                }
                if didFindCenterSection {
                    section.isLeftOfCenter = false
                } else {
                    section.isLeftOfCenter = true
                }
            }
        } else {
            for sectionIndex in 0..<sections.count {
                let section = sections[sectionIndex]
                section.indexInRow = sectionIndex
                section.isLeftOfCenter = false
            }
        }
    }
    
    private var _menuWidthWithSafeArea = 0
    private var _safeAreaLeft = 0
    private var _safeAreaRight = 0
    func snap_minimum_after_children_ready(menuWidthWithSafeArea: Int,
                                           safeAreaLeft: Int,
                                           safeAreaRight: Int) {
        
        _menuWidthWithSafeArea = menuWidthWithSafeArea
        _safeAreaLeft = safeAreaLeft
        _safeAreaRight = safeAreaRight
        
        max_size = menuWidthWithSafeArea - safeAreaLeft - safeAreaRight
        max_size_2 = (max_size / 2)
        
        if let attemptedCenteredSection = attemptedCenteredSection {
            left_size = 0
            right_size = 0
            center_size = 0
            for section in sections {
                if section === attemptedCenteredSection {
                    center_size = section.current_size
                } else {
                    if section.isLeftOfCenter == true {
                        left_size += section.current_size
                    } else {
                        right_size += section.current_size
                    }
                }
            }
            children_size = (left_size + center_size + right_size)
            remaining_size = max_size - children_size
            
            // initialLayoutType
            
        } else {
            children_size = 0
            for section in sections {
                children_size += section.current_size
            }
            remaining_size = max_size - children_size
            initialLayoutType = .doesNotIncludeCenterSection
        }
    }
    
    
    func growChildrenByOne_Unsafe(section: SkeletonSection) {
        if let attemptedCenteredSection = attemptedCenteredSection {
            if section === attemptedCenteredSection {
                center_size += 1
            } else {
                if section.isLeftOfCenter == true {
                    left_size += 1
                } else {
                    right_size += 1
                }
            }
        }
        remaining_size -= 1
        children_size += 1
    }
    
    func canGrowByOne(section: SkeletonSection) -> Bool {
        if remaining_size > 0 {
            if let attemptedCenteredSection = attemptedCenteredSection {
                let new_center_size = center_size + 1
                let new_center_left_x = max_size_2 - (new_center_size / 2)
                if section === attemptedCenteredSection {
                    let new_center_right_x = new_center_left_x + new_center_size
                    if left_size >= new_center_left_x {
                        return false
                    }
                    let area_right_of_center_size = (max_size - new_center_right_x)
                    if right_size >= area_right_of_center_size {
                        return false
                    }
                    return true
                } else {
                    if section.isLeftOfCenter == true {
                        let new_center_size = center_size + 1
                        let new_center_left_x = max_size_2 - (new_center_size / 2)
                        if left_size >= new_center_left_x {
                            return false
                        }
                        return true
                    } else {
                        let new_center_right_x = new_center_left_x + new_center_size
                        let area_right_of_center_size = (max_size - new_center_right_x)
                        if right_size >= area_right_of_center_size {
                            return false
                        }
                        return true
                    }
                }
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    func getGrowPlan_Flexer(flexers: [Flexer]) -> [SectionAndAmount] {
        
        //TODO: Sanity check:
        for flexer in flexers {
            guard flexer.row === self else {
                fatalError("This flexer is not for this row...")
            }
        }
        
        return [SectionAndAmount(section: sections[0], amount: 1)]
        
    }
    
    struct SectionAndAmount {
        let section: SkeletonSection
        let amount: Int
    }
    func canGrowSections(sectionAmountPairs: [SectionAndAmount]) -> Bool {
        
        for sectionAmountPair in sectionAmountPairs {
            var exists = false
            for section in sections {
                if section === sectionAmountPair.section {
                    exists = true
                    break
                }
            }
            if !exists {
                fatalError("This section is not in the row we're querying...")
            }
        }
        
        if let attemptedCenteredSection = attemptedCenteredSection {
            
            var left_pairs = [SectionAndAmount]()
            var right_pairs = [SectionAndAmount]()
            var center_pair = SectionAndAmount(section: attemptedCenteredSection, amount: 0)
            for sectionAmountPair in sectionAmountPairs {
                let section = sectionAmountPair.section
                if section.indexInRow < attemptedCenteredSectionIndex {
                    left_pairs.append(sectionAmountPair)
                } else if section.indexInRow > attemptedCenteredSectionIndex {
                    left_pairs.append(sectionAmountPair)
                } else {
                    center_pair = sectionAmountPair
                }
            }
            print("and here we are...")
            
            return false
        } else {
            
            // This is the much easier case
            // We just need to see if this
            var sum = 0
            for sectionAmountPair in sectionAmountPairs {
                sum += sectionAmountPair.amount
            }
            if sum <= remaining_size {
                return true
            } else {
                return false
            }
        }
    }
    
    func position_content_after_size_computation(menuWidthWithSafeArea: Int,
                                                  safeAreaLeft: Int,
                                                  safeAreaRight: Int) {
        if let attemptedCenteredSection = attemptedCenteredSection {
            var section_x = safeAreaLeft
            for section in sections {
                if section !== attemptedCenteredSection {
                    if section.isLeftOfCenter == true {
                        section.x = section_x
                        section_x += section.width
                    }
                }
            }
            
            let center_x = safeAreaLeft + max_size_2
            let expected_section_center_x = center_x - (center_size / 2)
            let expected_section_right_x = safeAreaLeft + max_size - right_size
            if section_x > expected_section_center_x {
                attemptedCenteredSection.x = section_x
                section_x += center_size
                if section_x < expected_section_right_x { section_x = expected_section_right_x }
                for section in sections {
                    if section !== attemptedCenteredSection {
                        if section.isLeftOfCenter == false {
                            section.x = section_x
                            section_x += section.width
                        }
                    }
                }
            } else {
                if (expected_section_center_x + center_size) > expected_section_right_x {
                    let expected_right_and_center_joined_x = expected_section_right_x - center_size
                    if expected_right_and_center_joined_x < section_x {
                        attemptedCenteredSection.x = section_x
                        section_x += center_size
                        for section in sections {
                            if section !== attemptedCenteredSection {
                                if section.isLeftOfCenter == false {
                                    section.x = section_x
                                    section_x += section.width
                                }
                            }
                        }
                    } else {
                        section_x = expected_right_and_center_joined_x
                        attemptedCenteredSection.x = section_x
                        section_x = expected_section_right_x
                        for section in sections {
                            if section !== attemptedCenteredSection {
                                if section.isLeftOfCenter == false {
                                    section.x = section_x
                                    section_x += section.width
                                }
                            }
                        }
                    }
                } else {
                    section_x = expected_section_center_x
                    attemptedCenteredSection.x = section_x
                    section_x = expected_section_right_x
                    for section in sections {
                        if section !== attemptedCenteredSection {
                            if section.isLeftOfCenter == false {
                                section.x = section_x
                                section_x += section.width
                            }
                        }
                    }
                }
            }
        } else {
            var section_x = safeAreaLeft
            for section in sections {
                section.x = section_x
                section_x += section.width
            }
        }
        /*
        for section in sections {
            var node_x = 0
            for node in section.skeletonNodes {
                node.x = node_x
                node_x += node.width
                var chunk_x = 0
                for chunk in node.chunks {
                    chunk.x = chunk_x
                    chunk_x += chunk.width
                }
            }
        }
        */
        
        for section in sections {
            section.position_content_after_size_computation()
        }
    }
    
    func computeSize_test(menuWidthWithSafeArea: Int,
                          safeAreaLeft: Int,
                          safeAreaRight: Int,
                          layoutPriority: LayoutPriority) -> Int {
        
        let max_size_test = menuWidthWithSafeArea - safeAreaLeft - safeAreaRight
        
        var computed_size = 0
        for section in sections {
            computed_size += section.computeSize(layoutPriority: layoutPriority)
        }
        if computed_size > max_size_test {
            computed_size = max_size_test
        }
        return computed_size
    }
    
    func sectionsOverlap_test() -> Bool {
        
        var sectionIndexA = 0
        while sectionIndexA < sections.count {
            
            let sectionA = sections[sectionIndexA]
            let sectionAX1 = sectionA.x
            let sectionAX2 = (sectionA.x + sectionA.width)
            
            var sectionIndexB = 0
            while sectionIndexB < sections.count {
                
                if sectionIndexA != sectionIndexB {
                    let sectionB = sections[sectionIndexB]
                    let sectionBX1 = sectionB.x
                    let sectionBX2 = (sectionB.x + sectionB.width)
                    
                    if sectionAX1 > sectionBX1 && sectionAX1 < sectionBX2 {
                        print("Sections Overlap [A: \(sectionIndexA)] [B: \(sectionIndexB)]")
                        print("[\(sectionAX1) to \(sectionAX2)] [\(sectionBX1) to \(sectionBX2)]")
                        return true
                    }
                    
                    if sectionAX2 > sectionBX1 && sectionAX2 < sectionBX2 {
                        print("Sections Overlap [A: \(sectionIndexA)] [B: \(sectionIndexB)]")
                        print("[\(sectionAX1) to \(sectionAX2)] [\(sectionBX1) to \(sectionBX2)]")
                        return true
                    }
                    
                    if sectionBX1 > sectionAX1 && sectionBX1 < sectionAX2 {
                        print("Sections Overlap [A: \(sectionIndexA)] [B: \(sectionIndexB)]")
                        print("[\(sectionAX1) to \(sectionAX2)] [\(sectionBX1) to \(sectionBX2)]")
                        return true
                    }
                    
                    if sectionBX2 > sectionAX1 && sectionBX2 < sectionAX2 {
                        print("Sections Overlap [A: \(sectionIndexA)] [B: \(sectionIndexB)]")
                        print("[\(sectionAX1) to \(sectionAX2)] [\(sectionBX1) to \(sectionBX2)]")
                        return true
                    }
                    
                }
                sectionIndexB += 1
            }
            
            sectionIndexA += 1
        }
        return false
    }
    
    
    func sectionsLayoutValid_test(menuWidthWithSafeArea: Int,
                                  safeAreaLeft: Int,
                                  safeAreaRight: Int) -> Bool {
        
        if let attemptedCenteredSection = attemptedCenteredSection {
            
            var leftSections = [SkeletonSection]()
            var leftSections_totalWidth = 0
            for section in sections {
                if section !== attemptedCenteredSection {
                    if section.isLeftOfCenter == true {
                        leftSections.append(section)
                        leftSections_totalWidth += section.current_size
                    }
                }
            }
            
            var section_x = safeAreaLeft
            for section in leftSections {
                if section.x != section_x {
                    print("[C-Left] Expected section (\(section.x) and \(section.width)) to be at \(section_x)...")
                    return false
                }
                section_x += section.current_size
            }
            
            var rightSections = [SkeletonSection]()
            var rightSections_totalWidth = 0
            for section in sections {
                if section !== attemptedCenteredSection {
                    if section.isLeftOfCenter == false {
                        rightSections.append(section)
                        rightSections_totalWidth += section.current_size
                    }
                }
            }
            
            let possible_center_x_case_1 = safeAreaLeft + leftSections_totalWidth
            if attemptedCenteredSection.x == possible_center_x_case_1 {
                
                // This case is valid, it means that we are crammed to the left section...
                section_x += attemptedCenteredSection.current_size
            } else {
                
                let possible_center_x_case_2 = safeAreaLeft + max_size_2 - (attemptedCenteredSection.current_size / 2)
                if possible_center_x_case_2 < possible_center_x_case_1 {
                    // This shouldn't be possible
                    print("possible_center_x_case_2 < possible_center_x_case_1")
                    print("\(possible_center_x_case_2) < \(possible_center_x_case_1)")
                    return false
                }
                if attemptedCenteredSection.x == possible_center_x_case_2 {
                    // In this case, we are exactly centered.
                    // Generally where we want to be.
                    section_x = possible_center_x_case_2 + attemptedCenteredSection.current_size
                } else {
                    
                    let possible_center_x_case_3 = safeAreaLeft + max_size - rightSections_totalWidth - attemptedCenteredSection.current_size
                    if possible_center_x_case_3 > possible_center_x_case_2 {
                        // This shouldn't be possible
                        print("possible_center_x_case_3 > possible_center_x_case_2")
                        print("\(possible_center_x_case_3) > \(possible_center_x_case_2)")
                        return false
                    }
                    
                    if attemptedCenteredSection.x == possible_center_x_case_3 {
                        // This is the crammed-right case...
                        section_x = possible_center_x_case_3 + attemptedCenteredSection.current_size
                    } else {
                        print("none of the center-x cases matched, this is a bad layout!")
                        return false
                    }
                }
            }
            
            if rightSections.count > 0 {
                
                if rightSections[0].x < (attemptedCenteredSection.x + attemptedCenteredSection.width) {
                    print("right section overlap, this should not happen!")
                    return false
                }
                
                let possible_right_x_case_1 = attemptedCenteredSection.x + attemptedCenteredSection.width
                if rightSections[0].x == possible_right_x_case_1 {
                    // In this case, we are crammed to the center piece.
                } else {
                    let the_only_possible_right_x = safeAreaLeft + max_size - (rightSections_totalWidth)
                    if rightSections[0].x != the_only_possible_right_x {
                        print("right section can not only be at \"the_only_possible_right_x\"...")
                        return false
                    }
                    section_x = the_only_possible_right_x
                }
                
                for section in rightSections {
                    if section.x != section_x {
                        print("[C-Right-2] Expected section (\(section.x) and \(section.width)) to be at \(section_x)...")
                        return false
                    }
                    section_x += section.current_size
                }
                
                // Finally, we ended at the edge or beyond...
                if section_x < (safeAreaLeft + max_size) {
                    print("the right section ended wrong")
                    return false
                }
            }
        } else {
            
            // In this case, every section should be at the right of the previous section...
            var section_x = safeAreaLeft
            for section in sections {
                if section.x != section_x {
                    print("[U] Expected section (\(section.x) and \(section.width)) to be at \(section_x)...")
                    return false
                }
                section_x += section.current_size
            }
        }
        
        return true
    }
    
    public func log_me(name: String, row_index: Int) {
        print("\tRow \(row_index) with \(sections.count) sections, from \(name)...")
        if let attemptedCenteredSection = attemptedCenteredSection {
            var center_index = -1
            for sectionIndex in sections.indices {
                if sections[sectionIndex] === attemptedCenteredSection {
                    center_index = sectionIndex
                }
            }
            print("\tRow has the \(center_index) section marked as center section. (x = \(attemptedCenteredSection.x), width = \(attemptedCenteredSection.width))")
            print("\tRow has \(left_size) left_size, \(center_size) center_size, \(right_size) right_size.")
            
        } else {
            print("\tRow has no center section, this is a traditional layout.")
            print("\tRow has \(children_size) children_size.")
        }
        
        print("\tRow has \(max_size) max_size, \(remaining_size) remaining_size.")
        
        for sectionIndex in sections.indices {
            sections[sectionIndex].log_me(name: name, row_index: row_index, section_index: sectionIndex)
        }
        
    }
    
}
