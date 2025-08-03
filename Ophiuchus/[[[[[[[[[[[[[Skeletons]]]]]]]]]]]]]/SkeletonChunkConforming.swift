//
//  SkeletonChunkConforming.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

@frozen public enum ChunkIdentifier: UInt8 {
    case unknown
    
    case heroStacked
    case heroLong
    
    case accent
    case slave
    
    case value
}

public protocol SkeletonChunkConforming: AnyObject, ExploderConforming {
    
    var id: Int { get }
    var chunkIdentifier: ChunkIdentifier { get }
    
    var currentSize: Int { get set }
    var children_size: Int { get set }
    var didGrowOnCurrentPass: Bool { get set }
    
    var alignment: LayoutAlignment { get }
    
    var row: SkeletonRow! { get set }
    var section: SkeletonSection! { get set }
    var node: SkeletonNode! { get set }
    
    var x: Int { get set }
    var width: Int { get set }
    
    var pieces: [SkeletonPiece] { get }
    var flexers: [Flexer] { get }
    
    var group: ExploderGroupChunks! { get set }
    
    func canGrowByOne() -> Bool
}

public extension SkeletonChunkConforming {
    
    
    func growChildrenByOne_Unsafe_Bubble() {
        if children_size < currentSize {
            children_size += 1
        } else {
            growByOne_Unsafe_Bubble()
            children_size = currentSize
        }
        didGrowOnCurrentPass = true
    }
    
    func growByOne_Unsafe_Bubble() {
        currentSize += 1
        node.growChildrenByOne_Unsafe_Bubble()
        didGrowOnCurrentPass = true
    }
    
    func computeSize(layoutPriority: LayoutPriority) -> Int {
        var result = 0
        for piece in pieces {
            result += piece.currentSize
        }
        for flexer in flexers {
            result += flexer.getDesiredSize(layoutPriority: layoutPriority)
        }
        return result
    }
    
    func getFlexer(flexerIdentifier: FlexerIdentifier) -> Flexer? {
        for flexer in flexers {
            if flexer.flexerIdentifier == flexerIdentifier {
                return flexer
            }
        }
        return nil
    }
    
    func getPiece(pieceIdentifier: PieceIdentifier) -> SkeletonPiece? {
        for piece in pieces {
            if piece.pieceIdentifier == pieceIdentifier {
                return piece
            }
        }
        return nil
    }
    
    func canGrowByOne() -> Bool {
        if node.childrenSize < node.currentSize {
            return true
        }
        if section.childrenSize < section.currentSize {
            return true
        }
        if row.canGrowByOne(section: section) {
            return true
        }
        return false
    }
}


