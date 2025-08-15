//
//  GenerateNodex.swift
//  OphiuchusTests
//
//  Created by Nick on 7/6/25.
//

import Foundation
@testable import Ophiuchus

struct GenerateNodes {
    
    static func generate() -> WiseLayoutNode {
        generate(flexers: [])
    }
    
    static func generate_piece() -> WiseLayoutNode {
        let piece = SkeletonPiece.generate(size: 10)
        let result = WiseLayoutNode.generate(pieces: [piece])
        return result
    }
    
    
    static func generate_flexer() -> WiseLayoutNode {
        let flexer = GenerateFlexers.generate_two_stepper()
        let result = WiseLayoutNode.generate(flexers: [flexer])
        return result
    }
    
    static func generate(size: Int) -> WiseLayoutNode {
        let piece = SkeletonPiece.generate(size: size)
        let result = WiseLayoutNode.generate(pieces: [piece])
        return result
    }
    
    static func generate(currentSize: Int, flexers: [Flexer]) -> WiseLayoutNode {
        let result = generate(flexers: flexers)
        var childrenSize = 0
        for flexer in flexers {
            childrenSize += flexer.currentSize
        }
        result.childrenSize = childrenSize
        result.currentSize = currentSize
        return result
    }
    
    static func generate(currentSize: Int) -> WiseLayoutNode {
        let result = generate()
        result.childrenSize = 0
        result.currentSize = currentSize
        return result
    }
    
    static func generate(currentSize: Int, pieceSizes: [Int]) -> WiseLayoutNode {
        
        var pieces = [SkeletonPiece]()
        for pieceIndex in 0..<pieceSizes.count {
            let piece = GeneratePieces.generate(size: pieceSizes[pieceIndex])
            pieces.append(piece)
        }
        let result = generate_currentSizeAccumulate(pieces: pieces)
        result.currentSize = currentSize
        return result
    }
    
    static func generate_growing_pieces(childrenSize: Int,
                               currentSize: Int,
                               growCount: Int,
                               amount: Int) -> (WiseLayoutNode, SkeletonLinkageRule_Pieces) {
        var pieces = [SkeletonPiece]()
        let numberOfPieces = (growCount + 1)
        for _ in 0..<numberOfPieces {
            let piece = GeneratePieces.generate(size: 1)
            pieces.append(piece)
        }
        if numberOfPieces > 0 {
            pieces[numberOfPieces - 1].currentSize += amount
        }
        let node = generate_currentSizeAccumulate(pieces: pieces)
        node.currentSize = currentSize
        node.childrenSize = childrenSize
        let rule = SkeletonLinkageRule_Pieces(pieces: pieces,
                                              layoutPriority: .required)
        return (node, rule)
    }
    
    static func generate_growing_flexers_group_rules(childrenSize: Int,
                                   currentSize: Int,
                                   growCount: Int,
                                   amount: Int) -> (WiseLayoutNode, SkeletonLinkageRule_Flexers) {
            var flexers = [Flexer]()
            let numberOfFlexers = (growCount + 1)
            for _ in 0..<numberOfFlexers {
                let flexer = GenerateFlexers.generate(currentSize: currentSize,
                                                      targetSizeCurrentPriority: currentSize)
                flexers.append(flexer)
            }
            if numberOfFlexers > 0 {
                flexers[numberOfFlexers - 1].currentSize += amount
            }
            let node = generate_currentSizeAccumulate(flexers: flexers)
            node.currentSize = currentSize
            node.childrenSize = childrenSize
            let rule = SkeletonLinkageRule_Flexers(flexers: flexers,
                                                  layoutPriority: .required)
            return (node, rule)
        }
    
    static func generate_growing_flexers_mono_ubiquitous(childrenSize: Int,
                                              currentSize: Int,
                                              growCount: Int,
                                              amount: Int) -> WiseLayoutNode {
        var flexers = [Flexer]()
        let numberOfFlexers = growCount
        for _ in 0..<numberOfFlexers {
            let flexer = GenerateFlexers.generate(currentSize: currentSize,
                                                  targetSizeCurrentPriority: currentSize + amount)
            flexers.append(flexer)
        }
        let node = generate_currentSizeAccumulate(flexers: flexers)
        node.currentSize = currentSize
        node.childrenSize = childrenSize
        return node
    }
    
    static func generate_growing_flexers_mono_mixed(childrenSize: Int,
                                              currentSize: Int,
                                              growCount: Int,
                                              amount: Int) -> WiseLayoutNode {
        var flexers = [Flexer]()
        let numberOfFlexers = growCount
        let numberOfExtraFlexers = Int.random(in: 0...10)
        for _ in 0..<numberOfFlexers {
            let flexer = GenerateFlexers.generate(currentSize: currentSize,
                                                  targetSizeCurrentPriority: currentSize + amount)
            flexers.append(flexer)
        }
        for _ in 0..<numberOfExtraFlexers {
            let flexer = GenerateFlexers.generate(currentSize: currentSize,
                                                  targetSizeCurrentPriority: currentSize)
            flexers.append(flexer)
        }
        flexers.shuffle()
        let node = generate_currentSizeAccumulate(flexers: flexers)
        node.currentSize = currentSize
        node.childrenSize = childrenSize
        return node
    }
    
    static func generate_currentSizeAccumulate(pieces: [SkeletonPiece]) -> WiseLayoutNode {
        let result = generate(pieces: pieces)
        var currentSize = 0
        for piece in pieces {
            currentSize += piece.currentSize
        }
        result.childrenSize = currentSize
        result.currentSize = currentSize
        return result
    }
    
    static func generate_currentSizeAccumulate(flexers: [Flexer]) -> WiseLayoutNode {
        let result = generate(flexers: flexers)
        var currentSize = 0
        for flexer in flexers {
            currentSize += flexer.currentSize
        }
        result.childrenSize = currentSize
        result.currentSize = currentSize
        return result
    }
    
    static func generate_currentSizeAccumulate(pieces: [SkeletonPiece], flexers: [Flexer]) -> WiseLayoutNode {
        let result = generate(pieces: pieces)
        var currentSize = 0
        for piece in pieces {
            currentSize += piece.currentSize
        }
        for flexer in flexers {
            currentSize += flexer.currentSize
        }
        result.childrenSize = currentSize
        result.currentSize = currentSize
        return result
    }
    
    static func generate_n(_ n: Int) -> [WiseLayoutNode] {
        var result = [WiseLayoutNode]()
        var index = 0
        while index < n {
            let node = generate()
            result.append(node)
            index += 1
        }
        return result
    }
    
    static func filterRandomly(nodes: [WiseLayoutNode]) -> [WiseLayoutNode] {
        var result = [WiseLayoutNode]()
        for node in nodes {
            if Bool.random() {
                result.append(node)
            }
        }
        return result
    }
    
    static func generate(gap: Int) -> WiseLayoutNode {
        let base = Int.random(in: 0...20)
        let result = GenerateNodes.generate(base: base, gap: gap)
        return result
    }
    
    static func generate(base: Int, gap: Int) -> WiseLayoutNode {
        let result = GenerateNodes.generate(size: base + gap)
        result.childrenSize = base
        result.currentSize = base + gap
        return result
    }
    
    static func generate(pieces: [SkeletonPiece], flexers: [Flexer]) -> WiseLayoutNode {
        let result = WiseLayoutNode.generate(pieces: pieces, flexers: flexers)
        return result
    }
    
    static func generate(pieces: [SkeletonPiece]) -> WiseLayoutNode {
        let result = WiseLayoutNode.generate(pieces: pieces)
        return result
    }
    
    static func generate(piece: SkeletonPiece) -> WiseLayoutNode {
        let result = WiseLayoutNode.generate(pieces: [piece])
        return result
    }
    
    static func generate(flexers: [Flexer]) -> WiseLayoutNode {
        let result = WiseLayoutNode.generate(flexers: flexers)
        return result
    }
    
    static func generate(flexer: Flexer) -> WiseLayoutNode {
        let result = WiseLayoutNode.generate(flexers: [flexer])
        return result
    }
    
    static func smallest(nodes: [WiseLayoutNode]) -> [WiseLayoutNode] {
        
        if nodes.count <= 1 {
            return [WiseLayoutNode]()
        }
        
        var smallestValue = Int.max
        var secondSmallestValue = Int.max
        
        for node in nodes {
            let currentSize = node.currentSize
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
            return [WiseLayoutNode]()
        }
        var result = [WiseLayoutNode]()
        for node in nodes {
            if node.currentSize == smallestValue {
                result.append(node)
            }
        }
        return result
    }
    
}
