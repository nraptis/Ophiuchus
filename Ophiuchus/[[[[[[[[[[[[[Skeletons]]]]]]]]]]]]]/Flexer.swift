//
//  Flexer.swift
//  It's You
//
//  Created by Nick on 7/2/25.
//

import Foundation

public enum FlexerIdentifier: UInt8 {
    case unknown
    
    case spacer
    
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
    
    var name = ""
    
    static func generate(id: Int,
        desiredSizeRequired: Int,
        desiredSizeHigh: Int?,
        desiredSizeMedium: Int?,
        desiredSizeLow: Int?,
        desiredSizeFinally: Int?) -> Flexer {
        let result = Flexer(id: id,
                            flexerIdentifier: .unknown,
                            desiredSizeRequired,
                            desiredSizeHigh,
                            desiredSizeMedium,
                            desiredSizeLow,
                            desiredSizeFinally)
        return result
    }
    
    static func generate(
        desiredSizeRequired: Int,
        desiredSizeHigh: Int?,
        desiredSizeMedium: Int?,
        desiredSizeLow: Int?,
        desiredSizeFinally: Int?) -> Flexer {
            let id = SkeletonIdentifierFactory.get_id()
        let result = generate(id: id,
                              desiredSizeRequired: desiredSizeRequired,
                              desiredSizeHigh: desiredSizeHigh,
                              desiredSizeMedium: desiredSizeMedium,
                              desiredSizeLow: desiredSizeLow,
                              desiredSizeFinally: desiredSizeFinally)
        return result
    }
    
    static func fetch(flexerIdentifier: FlexerIdentifier, flexers: [Flexer]) -> Flexer? {
        for flexer in flexers {
            if flexer.flexerIdentifier == flexerIdentifier {
                return flexer
            }
        }
        return nil
    }
    
    static func contains(list: [Flexer], flexer: Flexer) -> Bool {
        for _flexer in list {
            if _flexer === flexer {
                return true
            }
        }
        return false
    }
    
    public var currentSize = 0
    public var targetSizeCurrentPriority = 0
    
    //TODO: Back to unowned...
    public var node: WiseLayoutNode!
    public var section: SkeletonSection!
    public var row: SkeletonRow!
    public var group: ExploderGroup<Flexer>!
    
    var proposedGrowthAmount = 0
    
    
    let desiredSizeRequired: Int // For example, getting to "squeezed" padding.
    let desiredSizeHigh: Int // For example, getting to "standard" padding.
    let desiredSizeMedium: Int // For example, getting segment buttons all to the same size.
    let desiredSizeLow: Int // For example, getting to "relaxed" padding.
    let desiredSizeFinally: Int // For example, the remaining space, which a spacer will fill.
    
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
                _ desiredSizeRequired: Int,
                _ desiredSizeHigh: Int? = nil,
                _ desiredSizeMedium: Int? = nil,
                _ desiredSizeLow: Int? = nil,
                _ desiredSizeFinally: Int? = nil) {
        
        let _desiredSizeHigh: Int
        if let desiredSizeHigh = desiredSizeHigh {
            _desiredSizeHigh = desiredSizeHigh
        } else {
            _desiredSizeHigh = desiredSizeRequired
        }
        
        let _desiredSizeMedium: Int
        if let desiredSizeMedium = desiredSizeMedium {
            _desiredSizeMedium = desiredSizeMedium
        } else {
            _desiredSizeMedium = _desiredSizeHigh
        }
        
        let _desiredSizeLow: Int
        if let desiredSizeLow = desiredSizeLow {
            _desiredSizeLow = desiredSizeLow
        } else {
            _desiredSizeLow = _desiredSizeMedium
        }
        
        let _desiredSizeFinally: Int
        if let desiredSizeFinally = desiredSizeFinally {
            _desiredSizeFinally = desiredSizeFinally
        } else {
            _desiredSizeFinally = _desiredSizeLow
        }
        
        self.id = id
        self.flexerIdentifier = flexerIdentifier
        self.desiredSizeRequired = desiredSizeRequired
        self.desiredSizeHigh = _desiredSizeHigh
        self.desiredSizeMedium = _desiredSizeMedium
        self.desiredSizeLow = _desiredSizeLow
        self.desiredSizeFinally = _desiredSizeFinally
        
    }
    
    // @Param available_space: this is exactly how much space the outside world has to allocate.
    // @Param layoutPriority: this is the layoutPriority level we're laying out at...
    // @Returns: after ingesting from available_space, this would be the new "available_space"...
    
    func ingestIfPossible(available_space: Int, layoutPriority: LayoutPriority) -> Int {
        if available_space < 0 {
            fatalError("available_space cannot be < 0")
        }
        if available_space > 0 {
            let desired_size = getTargetSize(layoutPriority: layoutPriority)
            let amount_to_ingest = desired_size - currentSize
            if amount_to_ingest > 0 {
                if amount_to_ingest < available_space {
                    // We take exactly "amount_to_ingest"
                    currentSize += amount_to_ingest
                    let result = available_space - amount_to_ingest
                    return result
                } else {
                    // We take ALL of the "available_space"
                    currentSize += available_space
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
        guard desiredSizeHigh >= desiredSizeRequired else {
            print("valid - this is not valid, case desiredSizeHigh")
            return false
        }
        guard desiredSizeMedium >= desiredSizeHigh else {
            print("valid - this is not valid, case desiredSizeMedium")
            return false
        }
        guard desiredSizeLow >= desiredSizeMedium else {
            print("valid - this is not valid, case desiredSizeLow")
            return false
        }
        guard desiredSizeFinally >= desiredSizeLow else {
            print("valid - this is not valid, case desiredSizeFinally")
            return false
        }
        
        return true
    }
    
    func getTargetSize(layoutPriority: LayoutPriority) -> Int {
        switch layoutPriority {
        case .required:
            return desiredSizeRequired
        case .high:
            return desiredSizeHigh
        case .medium:
            return desiredSizeMedium
        case .low:
            return desiredSizeLow
        case .finally:
            return desiredSizeFinally
        }
    }
    
}
