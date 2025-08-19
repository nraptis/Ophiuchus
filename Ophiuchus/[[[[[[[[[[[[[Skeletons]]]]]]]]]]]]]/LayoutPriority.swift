//
//  LayoutPriority.swift
//  It's You
//
//  Created by Nick on 7/2/25.
//

import Foundation

@frozen public enum LayoutPriority: UInt8 {
    case required // For example, getting to "squeezed" padding.
    case high // For example, getting to "standard" padding.
    case medium // For example, getting segment buttons all to the same size.
    case low // For example, getting to "relaxed" padding.
    case finally // For example, the remaining space, which a spacer will fill.
    
    static let allCases: [LayoutPriority] = [.required, .high, .medium, .low, .finally]
    
    func gte(layoutPriority: LayoutPriority) -> Bool {
        switch self {
        case .required:
            switch layoutPriority {
            case .required:
                return true
            case .high:
                return true
            case .medium:
                return true
            case .low:
                return true
            case .finally:
                return true
            }
        case .high:
            switch layoutPriority {
            case .required:
                return false
            case .high:
                return true
            case .medium:
                return true
            case .low:
                return true
            case .finally:
                return true
            }
        case .medium:
            switch layoutPriority {
            case .required:
                return false
            case .high:
                return false
            case .medium:
                return true
            case .low:
                return true
            case .finally:
                return true
            }
        case .low:
            switch layoutPriority {
            case .required:
                return false
            case .high:
                return false
            case .medium:
                return false
            case .low:
                return true
            case .finally:
                return true
            }
        case .finally:
            switch layoutPriority {
            case .required:
                return false
            case .high:
                return false
            case .medium:
                return false
            case .low:
                return false
            case .finally:
                return true
            }
        }
    }
    
    func toString() -> String {
        
        switch self {
        case .required:
            "LayoutPriority.required"
        case .high:
            "LayoutPriority.high"
        case .medium:
            "LayoutPriority.medium"
        case .low:
            "LayoutPriority.low"
        case .finally:
            "LayoutPriority.finally"
        }
    }
    
    static var random: LayoutPriority {
        let number = Int.random(in: 0...4)
        if number == 0 {
            return LayoutPriority.required
        } else if number == 1 {
            return LayoutPriority.high
        }else if number == 2 {
            return LayoutPriority.medium
        }else if number == 3 {
            return LayoutPriority.low
        } else {
            return LayoutPriority.finally
        }
    }
    
    
    static var all: [LayoutPriority] {
        let result = [LayoutPriority.required, LayoutPriority.high, LayoutPriority.medium, LayoutPriority.low, LayoutPriority.finally]
        return result
    }
    
}
