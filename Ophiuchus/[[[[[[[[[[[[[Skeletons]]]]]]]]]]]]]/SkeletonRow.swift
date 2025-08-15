//
//  SkeletonRow.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

enum SkeletonRowInitialLayoutType {
    case invalid
    case doesNotIncludeCenterSection
    case centerSectionProperlyCentered
    case centerSectionSkewed
}

public class SkeletonRow: CustomStringConvertible {
    
    
    static func generate(id: Int, sections: [SkeletonSection], centeredSection: SkeletonSection?) -> SkeletonRow {
        let result = SkeletonRow(id: id,
                                 sections: sections,
                                 centeredSection: centeredSection)
        return result
    }
    
    static func generate(sections: [SkeletonSection], centeredSection: SkeletonSection?) -> SkeletonRow {
        let id = SkeletonIdentifierFactory.get_id()
        let result = generate(id: id,
                              sections: sections,
                              centeredSection: centeredSection)
        return result
    }
    
    static func generate(sections: [SkeletonSection]) -> SkeletonRow {
        let id = SkeletonIdentifierFactory.get_id()
        let result = generate(id: id,
                              sections: sections,
                              centeredSection: nil)
        return result
    }
    
    var temp_size_required = 0
    var temp_size_high = 0
    var temp_size_medium = 0
    var temp_size_low = 0
    var temp_size_finally = 0
    
    var childrenSize = 0
    var growthBudget = 0
    
    var max_size = 0
    var max_size_2 = 0
    var leftSizeWithCenteredSection = 0
    var rightSizeWithCenteredSection = 0
    var centerSizeWithCenteredSection = 0
    
    let sections: [SkeletonSection]
    let centeredSection: SkeletonSection?
    var centeredSectionIndex = 0
    
    public let id: Int
    
    public init(id: Int) {
        self.id = id
        self.sections = []
        self.centeredSection = nil
    }
    
    public init(id: Int,
                sections: [SkeletonSection],
                centeredSection: SkeletonSection?) {
        self.id = id
        self.sections = sections
        self.centeredSection = centeredSection
        for _section in sections {
            _section.row = self
            for _node in _section.nodes {
                _node.row = self
                for _piece in _node.pieces {
                    _piece.row = self
                }
                for _flexer in _node.flexers {
                    _flexer.row = self
                }
            }
        }
    }
    
    public init(id: Int,
                sections: [SkeletonSection]) {
        self.id = id
        self.sections = sections
        self.centeredSection = nil
        for _section in sections {
            _section.row = self
            for _node in _section.nodes {
                _node.row = self
                for _piece in _node.pieces {
                    _piece.row = self
                }
                for _flexer in _node.flexers {
                    _flexer.row = self
                }
            }
        }
    }
    
    static func contains(list: [SkeletonRow], row: SkeletonRow) -> Bool {
        for _row in list {
            if _row === row {
                return true
            }
        }
        return false
    }
    
    func contains(section: SkeletonSection) -> Bool {
        for _section in sections {
            if _section === section {
                return true
            }
        }
        return false
    }
    
    func contains(node: WiseLayoutNode) -> Bool {
        for _section in sections {
            for _node in _section.nodes {
                if _node === node {
                    return true
                }
            }
        }
        return false
    }
    
    func contains(piece: SkeletonPiece) -> Bool {
        for _section in sections {
            for _node in _section.nodes {
                
                    for _piece in _node.pieces {
                        if _piece === piece {
                            return true
                        }
                    }
                
            }
        }
        return false
    }
    
    func contains(flexer: Flexer) -> Bool {
        for _section in sections {
            for _node in _section.nodes {
                
                    for _flexer in _node.flexers {
                        if _flexer === flexer {
                            return true
                        }
                    }
                
            }
        }
        return false
    }
    
    
    func countSectionsWithNodes() -> Int {
        var result = 0
        for _section in sections {
            if _section.nodes.count > 0 {
                result += 1
            }
        }
        return result
    }
    
    func countSectionsWithoutNodes() -> Int {
        var result = 0
        for _section in sections {
            if _section.nodes.count == 0 {
                result += 1
            }
        }
        return result
    }
    
    func countNodes() -> Int {
        var result = 0
        for _section in sections {
            result += _section.nodes.count
        }
        return result
    }
    
    func countPieces() -> Int {
        var result = 0
        for section in sections {
            for _node in section.nodes {
                
                    result += _node.pieces.count
                
            }
        }
        return result
    }
    
    func countFlexers() -> Int {
        var result = 0
        for section in sections {
            for _node in section.nodes {
                result += _node.flexers.count
            }
        }
        return result
    }
    
    public var description: String {
        
        let isCenter = (centeredSection !== nil)
        let id = ObjectIdentifier(self)
        var result = "SkeletonRow[\(id)] cs: \(childrenSize), rs: \(growthBudget), sec: \(sections.count), ctr: \(isCenter)"
        if isCenter {
            result += " cl: \(leftSizeWithCenteredSection), cc: \(centerSizeWithCenteredSection) cr: \(rightSizeWithCenteredSection)"
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
    
    func getSectionIndex(section: SkeletonSection) -> Int? {
        for sectionIndex in 0..<sections.count {
            if sections[sectionIndex] === section {
                return sectionIndex
            }
        }
        return nil
    }
    
    func validate(isStrictCenteringRequired: Bool,
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
        
        if let centeredSection = centeredSection {
            if isStrictCenteringRequired {
                
                let _center_size = centeredSection.width
                let _center_size_2 = (_center_size / 2)
                
                let _max_size = menuWidthWithSafeArea - safeAreaLeft - safeAreaRight
                let _max_size_2 = (_max_size / 2)
                
                let valid_x = safeAreaLeft + _max_size_2 - _center_size_2
                if centeredSection.x != valid_x { return false }
            }
        }
        return true
    }
    
    func prepare() {
        centeredSectionIndex = -1
        if let centeredSection = centeredSection {
            var didFindCenterSection = false
            for sectionIndex in 0..<sections.count {
                let section = sections[sectionIndex]
                section.indexInRow = sectionIndex
                if section === centeredSection {
                    didFindCenterSection = true
                    centeredSectionIndex = sectionIndex
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
        
        if let centeredSection = centeredSection {
            leftSizeWithCenteredSection = 0
            rightSizeWithCenteredSection = 0
            centerSizeWithCenteredSection = 0
            for section in sections {
                if section === centeredSection {
                    centerSizeWithCenteredSection = section.currentSize
                } else {
                    if section.isLeftOfCenter == true {
                        leftSizeWithCenteredSection += section.currentSize
                    } else {
                        rightSizeWithCenteredSection += section.currentSize
                    }
                }
            }
            childrenSize = (leftSizeWithCenteredSection + centerSizeWithCenteredSection + rightSizeWithCenteredSection)
            growthBudget = max_size - childrenSize
            
            // initialLayoutType
            
        } else {
            childrenSize = 0
            for section in sections {
                childrenSize += section.currentSize
            }
            growthBudget = max_size - childrenSize
        }
    }
    
    
    
    
    
    /*
    func getGrowPlan_Flexer(flexers: [Flexer]) -> [SectionAndAmount] {
        
        //TODO: Sanity check:
        for flexer in flexers {
            guard flexer.row === self else {
                fatalError("This flexer is not for this row...")
            }
        }
        
        return [SectionAndAmount(section: sections[0], amount: 1)]
        
    }
    */
    
    /*
    func canAcceptAllGrowthPlansSimultaneously(growthPlans: [GrowthPlan]) -> Bool {
        for growthPlan in growthPlans {
            guard growthPlan.row === self else {
                fatalError("This growth plan is not for this row...")
            }
            if growthPlan.section.indexInRow < 0 {
                fatalError("Expect indexInRow to be calculated.")
            }
            if growthPlan.section.indexInRow >= sections.count {
                fatalError("Expect indexInRow to be in range, it's \(growthPlan.section.indexInRow) of \(sections.count).")
            }
            if let centeredSection = centeredSection {
                if centeredSectionIndex < 0 {
                    fatalError("Expecting centeredSectionIndex (\(centeredSectionIndex)) in range [0..<\(sections.count)]")
                }
                if centeredSectionIndex >= sections.count {
                    fatalError("Expecting centeredSectionIndex (\(centeredSectionIndex)) in range [0..<\(sections.count)]")
                }
                for sectionIndex in 0..<sections.count {
                    if sections[sectionIndex].indexInRow != sectionIndex {
                        fatalError("Expecting the section index to be accurate, it's not.")
                    }
                    if sections[sectionIndex] === centeredSection {
                        if sectionIndex != centeredSectionIndex {
                            fatalError("Expecting the center section to be where I expected it to be...")
                        }
                    }
                }
            }
        }
        
        if centeredSection !== nil {
            
            var totalConsumedSizeLeft = 0
            var totalConsumedSizeCenter = 0
            var totalConsumedSizeRight = 0
            
            for growthPlan in growthPlans {
                let growthPlanSection = growthPlan.section
                if growthPlanSection.indexInRow < centeredSectionIndex {
                    totalConsumedSizeLeft += growthPlan.amount
                } else if growthPlanSection.indexInRow > centeredSectionIndex {
                    totalConsumedSizeRight += growthPlan.amount
                } else {
                    totalConsumedSizeCenter += growthPlan.amount
                }
            }
            
            let result = SkeletonRow.isCenterSectionProperlyCentered(leftSize: left_size + totalConsumedSizeLeft,
                                                                     centerSize: center_size + totalConsumedSizeCenter,
                                                                     rightSize: right_size + totalConsumedSizeCenter,
                                                                     menuWidthWithSafeArea: _menuWidthWithSafeArea,
                                                                     safeAreaLeft: _safeAreaLeft,
                                                                     safeAreaRight: _safeAreaRight)
            return result
            
        } else {
            
            var totalConsumedSize = 0
            for growthPlan in growthPlans {
                totalConsumedSize += growthPlan.amount
            }
            
            if totalConsumedSize > growthBudget {
                return false
            } else {
                return true
            }
        }
    }
    */
    
    
    func canGrowAllSectionsByProposedGrowthAmount(sections: [SkeletonSection],
                                    sectionCount: Int) -> Bool {
        
        
        for sectionIndex in 0..<sectionCount {
            let _section = sections[sectionIndex]
            guard _section.row === self else {
                fatalError("This growth plan is not for this row...")
            }
            if _section.indexInRow < 0 {
                fatalError("Expect indexInRow to be calculated.")
            }
            if _section.indexInRow >= self.sections.count {
                fatalError("Expect indexInRow to be in range, it's \(_section.indexInRow) of \(self.sections.count).")
            }
            if let centeredSection = centeredSection {
                if centeredSectionIndex < 0 {
                    fatalError("Expecting centeredSectionIndex (\(centeredSectionIndex)) in range [0..<\(self.sections.count)]")
                }
                if centeredSectionIndex >= sections.count {
                    fatalError("Expecting centeredSectionIndex (\(centeredSectionIndex)) in range [0..<\(self.sections.count)]")
                }
                for sectionIndex in 0..<sections.count {
                    if sections[sectionIndex].indexInRow != sectionIndex {
                        fatalError("Expecting the section index to be accurate, it's not.")
                    }
                    if sections[sectionIndex] === centeredSection {
                        if sectionIndex != centeredSectionIndex {
                            fatalError("Expecting the center section to be where I expected it to be...")
                        }
                    }
                }
            }
        }
        
        for sectionIndex in 0..<sectionCount {
            let _section = sections[sectionIndex]
            var exists = false
            for section in self.sections {
                if _section === section {
                    exists = true
                    break
                }
            }
            if !exists {
                fatalError("This section is not in the row we're querying...")
            }
            
        }

        
        if centeredSection !== nil {
            
            var add_left = 0
            var add_right = 0
            var add_center = 0
            for sectionIndex in 0..<sectionCount {
                let section = sections[sectionIndex]
                let amount = section.proposedGrowthAmount
                if section.indexInRow < centeredSectionIndex {
                    add_left += amount
                } else if section.indexInRow > centeredSectionIndex {
                    add_right += amount
                } else {
                    add_center += amount
                }
            }
            print("and here we are...")
            if SkeletonRow.isCenterSectionProperlyCentered(leftSize: leftSizeWithCenteredSection + add_left,
                                                           centerSize: rightSizeWithCenteredSection + add_right,
                                                           rightSize: rightSizeWithCenteredSection + add_right,
                                                           menuWidthWithSafeArea: _menuWidthWithSafeArea,
                                                           safeAreaLeft: _safeAreaLeft,
                                                           safeAreaRight: _safeAreaRight) {
                return true
            } else {
                return false
            }
        } else {
            
            var amountSum = 0
            for sectionIndex in 0..<sectionCount {
                let section = sections[sectionIndex]
                let amount = section.proposedGrowthAmount
                amountSum += amount
            }
            
            if amountSum <= growthBudget {
                return true
            } else {
                return false
            }
        }
        
    }
    
    
    func canGrowSection(section: SkeletonSection, amount: Int) -> Bool {
        
        
        
        guard section.row === self else {
            fatalError("This growth plan is not for this row...")
        }
        if section.indexInRow < 0 {
            fatalError("Expect indexInRow to be calculated.")
        }
        if section.indexInRow >= self.sections.count {
            fatalError("Expect indexInRow to be in range, it's \(section.indexInRow) of \(self.sections.count).")
        }
        if let centeredSection = centeredSection {
            if centeredSectionIndex < 0 {
                fatalError("Expecting centeredSectionIndex (\(centeredSectionIndex)) in range [0..<\(self.sections.count)]")
            }
            if centeredSectionIndex >= sections.count {
                fatalError("Expecting centeredSectionIndex (\(centeredSectionIndex)) in range [0..<\(self.sections.count)]")
            }
            for sectionIndex in 0..<sections.count {
                if sections[sectionIndex].indexInRow != sectionIndex {
                    fatalError("Expecting the section index to be accurate, it's not.")
                }
                if sections[sectionIndex] === centeredSection {
                    if sectionIndex != centeredSectionIndex {
                        fatalError("Expecting the center section to be where I expected it to be...")
                    }
                }
            }
        }
        
        
        var exists = false
        for _section in self.sections {
            if _section === section {
                exists = true
                break
            }
        }
        if !exists {
            fatalError("This section is not in the row we're querying...")
        }
        
        
        
        if centeredSection !== nil {
            
            var add_left = 0
            var add_right = 0
            var add_center = 0
            
            let amount = section.proposedGrowthAmount
            if section.indexInRow < centeredSectionIndex {
                add_left += amount
            } else if section.indexInRow > centeredSectionIndex {
                add_right += amount
            } else {
                add_center += amount
            }
            
            if SkeletonRow.isCenterSectionProperlyCentered(leftSize: leftSizeWithCenteredSection + add_left,
                                                           centerSize: rightSizeWithCenteredSection + add_right,
                                                           rightSize: rightSizeWithCenteredSection + add_right,
                                                           menuWidthWithSafeArea: _menuWidthWithSafeArea,
                                                           safeAreaLeft: _safeAreaLeft,
                                                           safeAreaRight: _safeAreaRight) {
                return true
            } else {
                return false
            }
        } else {
            if amount <= growthBudget {
                return true
            } else {
                return false
            }
        }
    }
    
    func growAllSectionsByProposedGrowthAmount_Unsafe(sections: [SkeletonSection],
                                                      sectionCount: Int) {
        
        if centeredSection !== nil {
            
            for sectionIndex in 0..<sectionCount {
                let section = sections[sectionIndex]
                if section.indexInRow < centeredSectionIndex {
                    leftSizeWithCenteredSection += section.proposedGrowthAmount
                    growthBudget -= section.proposedGrowthAmount
                } else if section.indexInRow > centeredSectionIndex {
                    rightSizeWithCenteredSection += section.proposedGrowthAmount
                    growthBudget -= section.proposedGrowthAmount
                } else {
                    centerSizeWithCenteredSection += section.proposedGrowthAmount
                    growthBudget -= section.proposedGrowthAmount
                }
            }
        } else {
            for sectionIndex in 0..<sectionCount {
                let section = sections[sectionIndex]
                growthBudget -= section.proposedGrowthAmount
            }
        }
        
        for sectionIndex in 0..<sectionCount {
            let section = sections[sectionIndex]
            section.currentSize += section.proposedGrowthAmount
        }
        
        
        print("Row Remaining_size \(growthBudget), childrenSize \(childrenSize)")
        if growthBudget < 0 {
            print("what?!??!?!??!?!??!?!??!?!")
        }
        
        if sectionsOverlap_test() {
            fatalError("WHAT WE OVERLAP!?!??!?!?!")
        }
    }
    
    
    func canGrowOneSectionByOne(section: SkeletonSection) -> Bool {
        
        
        guard section.row === self else {
            fatalError("This growth plan is not for this row...")
        }
        if section.indexInRow < 0 {
            fatalError("Expect indexInRow to be calculated.")
        }
        if section.indexInRow >= sections.count {
            fatalError("Expect indexInRow to be in range, it's \(section.indexInRow) of \(sections.count).")
        }
        if let centeredSection = centeredSection {
            if centeredSectionIndex < 0 {
                fatalError("Expecting centeredSectionIndex (\(centeredSectionIndex)) in range [0..<\(sections.count)]")
            }
            if centeredSectionIndex >= sections.count {
                fatalError("Expecting centeredSectionIndex (\(centeredSectionIndex)) in range [0..<\(sections.count)]")
            }
            for sectionIndex in 0..<sections.count {
                if sections[sectionIndex].indexInRow != sectionIndex {
                    fatalError("Expecting the section index to be accurate, it's not.")
                }
                if sections[sectionIndex] === centeredSection {
                    if sectionIndex != centeredSectionIndex {
                        fatalError("Expecting the center section to be where I expected it to be...")
                    }
                }
            }
        }
        
            var exists = false
            for _section in self.sections {
                if _section === section {
                    exists = true
                    break
                }
            }
            if !exists {
                fatalError("This section is not in the row we're querying...")
            }
         
        
        
        if centeredSection !== nil {
            
            
            var add_left = 0
            var add_right = 0
            var add_center = 0
            if section.indexInRow < centeredSectionIndex {
                add_left += 1
            } else if section.indexInRow > centeredSectionIndex {
                add_right += 1
            } else {
                add_center += 1
            }
            
            print("and here we are...")
            if SkeletonRow.isCenterSectionProperlyCentered(leftSize: leftSizeWithCenteredSection + add_left,
                                                           centerSize: rightSizeWithCenteredSection + add_right,
                                                           rightSize: rightSizeWithCenteredSection + add_right,
                                                           menuWidthWithSafeArea: _menuWidthWithSafeArea,
                                                           safeAreaLeft: _safeAreaLeft,
                                                           safeAreaRight: _safeAreaRight) {
                return true
            } else {
                return false
            }
        } else {
            if growthBudget > 0 {
                return true
            } else {
                return false
            }
        }
        
    }
    
    func growOneSectionByOne_Unsafe(section: SkeletonSection) {
        if centeredSection !== nil {
            if section.indexInRow > centeredSectionIndex {
                rightSizeWithCenteredSection += 1
            } else if section.indexInRow < centeredSectionIndex {
                leftSizeWithCenteredSection += 1
            } else {
                centerSizeWithCenteredSection += 1
            }
        }
        growthBudget -= 1
        childrenSize += 1
        
        section.currentSize += 1
        
        print("Row Remaining_size \(growthBudget), childrenSize \(childrenSize)")
        if growthBudget < 0 {
            print("what?!??!?!??!?!??!?!??!?!")
        }
    }
    
    /*
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
        
        if let centeredSection = centeredSection {
            
            var left_pairs = [SectionAndAmount]()
            var right_pairs = [SectionAndAmount]()
            var center_pair = SectionAndAmount(section: centeredSection, amount: 0)
            for sectionAmountPair in sectionAmountPairs {
                let section = sectionAmountPair.section
                if section.indexInRow < centeredSectionIndex {
                    left_pairs.append(sectionAmountPair)
                } else if section.indexInRow > centeredSectionIndex {
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
    */
    
    func positionContentAfterSizeComputation(menuWidthWithSafeArea: Int,
                                                  safeAreaLeft: Int,
                                                  safeAreaRight: Int) {
        if let centeredSection = centeredSection {
            var section_x = safeAreaLeft
            for section in sections {
                if section !== centeredSection {
                    if section.isLeftOfCenter == true {
                        section.x = section_x
                        section_x += section.width
                    }
                }
            }
            
            let center_x = safeAreaLeft + max_size_2
            let expected_section_center_x = center_x - (centerSizeWithCenteredSection / 2)
            let expected_section_right_x = safeAreaLeft + max_size - rightSizeWithCenteredSection
            if section_x > expected_section_center_x {
                centeredSection.x = section_x
                section_x += centerSizeWithCenteredSection
                if section_x < expected_section_right_x { section_x = expected_section_right_x }
                for section in sections {
                    if section !== centeredSection {
                        if section.isLeftOfCenter == false {
                            section.x = section_x
                            section_x += section.width
                        }
                    }
                }
            } else {
                if (expected_section_center_x + centerSizeWithCenteredSection) > expected_section_right_x {
                    let expected_right_and_center_joined_x = expected_section_right_x - centerSizeWithCenteredSection
                    if expected_right_and_center_joined_x < section_x {
                        centeredSection.x = section_x
                        section_x += centerSizeWithCenteredSection
                        for section in sections {
                            if section !== centeredSection {
                                if section.isLeftOfCenter == false {
                                    section.x = section_x
                                    section_x += section.width
                                }
                            }
                        }
                    } else {
                        section_x = expected_right_and_center_joined_x
                        centeredSection.x = section_x
                        section_x = expected_section_right_x
                        for section in sections {
                            if section !== centeredSection {
                                if section.isLeftOfCenter == false {
                                    section.x = section_x
                                    section_x += section.width
                                }
                            }
                        }
                    }
                } else {
                    section_x = expected_section_center_x
                    centeredSection.x = section_x
                    section_x = expected_section_right_x
                    for section in sections {
                        if section !== centeredSection {
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
            section.positionContentAfterSizeComputation()
        }
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
        
        if let centeredSection = centeredSection {
            
            var leftSections = [SkeletonSection]()
            var leftSections_totalWidth = 0
            for section in sections {
                if section !== centeredSection {
                    if section.isLeftOfCenter == true {
                        leftSections.append(section)
                        leftSections_totalWidth += section.currentSize
                    }
                }
            }
            
            var section_x = safeAreaLeft
            for section in leftSections {
                if section.x != section_x {
                    print("[C-Left] Expected section (\(section.x) and \(section.width)) to be at \(section_x)...")
                    return false
                }
                section_x += section.currentSize
            }
            
            var rightSections = [SkeletonSection]()
            var rightSections_totalWidth = 0
            for section in sections {
                if section !== centeredSection {
                    if section.isLeftOfCenter == false {
                        rightSections.append(section)
                        rightSections_totalWidth += section.currentSize
                    }
                }
            }
            
            let possible_center_x_case_1 = safeAreaLeft + leftSections_totalWidth
            if centeredSection.x == possible_center_x_case_1 {
                
                // This case is valid, it means that we are crammed to the left section...
                section_x += centeredSection.currentSize
            } else {
                
                let possible_center_x_case_2 = safeAreaLeft + max_size_2 - (centeredSection.currentSize / 2)
                if possible_center_x_case_2 < possible_center_x_case_1 {
                    // This shouldn't be possible
                    print("possible_center_x_case_2 < possible_center_x_case_1")
                    print("\(possible_center_x_case_2) < \(possible_center_x_case_1)")
                    return false
                }
                if centeredSection.x == possible_center_x_case_2 {
                    // In this case, we are exactly centered.
                    // Generally where we want to be.
                    section_x = possible_center_x_case_2 + centeredSection.currentSize
                } else {
                    
                    let possible_center_x_case_3 = safeAreaLeft + max_size - rightSections_totalWidth - centeredSection.currentSize
                    if possible_center_x_case_3 > possible_center_x_case_2 {
                        // This shouldn't be possible
                        print("possible_center_x_case_3 > possible_center_x_case_2")
                        print("\(possible_center_x_case_3) > \(possible_center_x_case_2)")
                        return false
                    }
                    
                    if centeredSection.x == possible_center_x_case_3 {
                        // This is the crammed-right case...
                        section_x = possible_center_x_case_3 + centeredSection.currentSize
                    } else {
                        print("none of the center-x cases matched, this is a bad layout!")
                        return false
                    }
                }
            }
            
            if rightSections.count > 0 {
                
                if rightSections[0].x < (centeredSection.x + centeredSection.width) {
                    print("right section overlap, this should not happen!")
                    return false
                }
                
                let possible_right_x_case_1 = centeredSection.x + centeredSection.width
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
                    section_x += section.currentSize
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
                section_x += section.currentSize
            }
        }
        return true
    }
    
}
