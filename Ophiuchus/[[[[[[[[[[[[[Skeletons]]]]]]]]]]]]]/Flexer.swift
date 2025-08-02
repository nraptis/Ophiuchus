//
//  Flexer.swift
//  It's You
//
//  Created by Nick on 7/2/25.
//

import Foundation

public enum FlexerIdentifier: UInt8 {
    case unknown
    case heroPaddingLeft
    case heroPaddingRight
    case heroSpacingLong
    
    case outsideBoxPaddingLeft
    case outsideBoxPaddingRight
    
    case slavePaddingLeft
    case slavePaddingRight
    
    case accentPaddingLeft
    case accentPaddingRight
    
}

public class Flexer: ExploderConforming {
    
    public var current_size = 0
    var target_size = 0
    
    let desired_size_required: Int // For example, getting to "squeezed" padding.
    let desired_size_high: Int // For example, getting to "standard" padding.
    let desired_size_medium: Int // For example, getting segment buttons all to the same size.
    let desired_size_low: Int // For example, getting to "relaxed" padding.
    let desired_size_finally: Int // For example, the remaining space, which a spacer will fill.
    
    unowned var chunk: (any SkeletonChunkConforming)!
    unowned var node: SkeletonNode!
    unowned var section: SkeletonSection!
    unowned var row: SkeletonRow!
    unowned var group_unsafe: ExploderGroup<Flexer>!
    var didGrowOnCurrentPass = false
    
    public let id: Int
    let flexerIdentifier: FlexerIdentifier
    public convenience init(id: Int,
                            flexerIdentifier: FlexerIdentifier) {
        self.init(id: id,
                  flexerIdentifier: flexerIdentifier,
                  0,
                  0,
                  0,
                  0,
                  0)
    }
    
    public convenience init(id: Int,
                            flexerIdentifier: FlexerIdentifier,
                            squeezed: Int,
                            standard: Int,
                            relaxed: Int) {
        self.init(id: id,
                  flexerIdentifier: flexerIdentifier,
                  squeezed,
                  standard,
                  standard,
                  relaxed,
                  relaxed)
    }
    
    public init(id: Int,
                flexerIdentifier: FlexerIdentifier,
                _ desired_size_required: Int,
                _ desired_size_high: Int? = nil,
                _ desired_size_medium: Int? = nil,
                _ desired_size_low: Int? = nil,
                _ desired_size_finally: Int? = nil) {
        
        let _desired_size_high: Int
        if let desired_size_high = desired_size_high {
            _desired_size_high = desired_size_high
        } else {
            _desired_size_high = desired_size_required
        }
        
        let _desired_size_medium: Int
        if let desired_size_medium = desired_size_medium {
            _desired_size_medium = desired_size_medium
        } else {
            _desired_size_medium = _desired_size_high
        }
        
        let _desired_size_low: Int
        if let desired_size_low = desired_size_low {
            _desired_size_low = desired_size_low
        } else {
            _desired_size_low = _desired_size_medium
        }
        
        let _desired_size_finally: Int
        if let desired_size_finally = desired_size_finally {
            _desired_size_finally = desired_size_finally
        } else {
            _desired_size_finally = _desired_size_low
        }
        
        self.id = id
        self.flexerIdentifier = flexerIdentifier
        self.desired_size_required = desired_size_required
        self.desired_size_high = _desired_size_high
        self.desired_size_medium = _desired_size_medium
        self.desired_size_low = _desired_size_low
        self.desired_size_finally = _desired_size_finally
    }
    
    // @Param available_space: this is exactly how much space the outside world has to allocate.
    // @Param layoutPriority: this is the layoutPriority level we're laying out at...
    // @Returns: after ingesting from available_space, this would be the new "available_space"...
    
    func ingestIfPossible(available_space: Int, layoutPriority: LayoutPriority) -> Int {
        if available_space < 0 {
            fatalError("available_space cannot be < 0")
        }
        if available_space > 0 {
            let desired_size = getDesiredSize(layoutPriority: layoutPriority)
            let amount_to_ingest = desired_size - current_size
            if amount_to_ingest > 0 {
                if amount_to_ingest < available_space {
                    // We take exactly "amount_to_ingest"
                    current_size += amount_to_ingest
                    let result = available_space - amount_to_ingest
                    return result
                } else {
                    // We take ALL of the "available_space"
                    current_size += available_space
                    let result = 0
                    return result
                }
                
            } else {
                return available_space
            }
        } else {
            return available_space
        }
    }
    
    func validate_desired_sizes() -> Bool {
        guard desired_size_high >= desired_size_required else {
            print("valid - this is not valid, case desired_size_high")
            return false
        }
        guard desired_size_medium >= desired_size_high else {
            print("valid - this is not valid, case desired_size_medium")
            return false
        }
        guard desired_size_low >= desired_size_medium else {
            print("valid - this is not valid, case desired_size_low")
            return false
        }
        guard desired_size_finally >= desired_size_low else {
            print("valid - this is not valid, case desired_size_finally")
            return false
        }
        
        return true
    }
    
    func getDesiredSize(layoutPriority: LayoutPriority) -> Int {
        switch layoutPriority {
        case .required:
            return desired_size_required
        case .high:
            return desired_size_high
        case .medium:
            return desired_size_medium
        case .low:
            return desired_size_low
        case .finally:
            return desired_size_finally
        }
    }
    
    func canGrowByOne() -> Bool {
        if chunk.children_size < chunk.current_size {
            return true
        }
        if node.children_size < node.current_size {
            return true
        }
        if section.children_size < section.current_size {
            return true
        }
        if row.canGrowByOne(section: section) {
            return true
        }
        return false
    }
    
    func growByOne_Unsafe_Bubble() {
        current_size += 1
        //node.growChildrenByOne_Unsafe_Bubble()
        chunk.growChildrenByOne_Unsafe_Bubble()
    }
    
}
