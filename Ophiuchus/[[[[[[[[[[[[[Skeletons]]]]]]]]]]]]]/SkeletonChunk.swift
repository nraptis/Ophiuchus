//
//  SkeletonChunkMany.swift
//  Ophiuchus
//
//  Created by Nick on 8/3/25.
//

import Foundation

@frozen public enum ChunkIdentifier: UInt8 {
    case unknown
    
    case outsideBoxPaddingLeft
    case outsideBoxPaddingRight
    
    case heroStacked
    case heroLong
    
    case accent
    case slave
    
    case spacer
    
    case value
}

public class SkeletonChunk: InterfaceContainerSupplier {
    
    static func contains(list: [SkeletonChunk], chunk: SkeletonChunk) -> Bool {
        for _chunk in list {
            if _chunk === chunk {
                return true
            }
        }
        return false
    }
    
    func contains(piece: SkeletonPiece) -> Bool {
        for _piece in pieces {
            if _piece === piece {
                return true
            }
        }
        return false
    }
    
    func contains(flexer: Flexer) -> Bool {
        for _flexer in flexers {
            if _flexer === flexer {
                return true
            }
        }
        return false
    }
    
    
    
    public let id: Int
    public let chunkIdentifier: ChunkIdentifier
    public var currentSize = 0
    public var childrenSize = 0
    public var didGrowOnCurrentPass = false
    public let alignment: LayoutAlignment
    public unowned var node: SkeletonNode!
    public unowned var section: SkeletonSection!
    public unowned var row: SkeletonRow!
    public unowned var group: ExploderGroup<SkeletonChunk>!
    public let pieces: [SkeletonPiece]
    public let flexers: [Flexer]
    public var x = 0
    public var width = 0
    
    init(id: Int,
         chunkIdentifier: ChunkIdentifier,
         pieces: [SkeletonPiece],
         flexers: [Flexer],
         alignment: LayoutAlignment) {
        self.id = id
        self.chunkIdentifier = chunkIdentifier
        self.alignment = alignment
        self.pieces = pieces
        self.flexers = flexers
        for piece in pieces {
            piece.chunk = self
        }
        for flexer in flexers {
            flexer.chunk = self
        }
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     pieces: [SkeletonPiece],
                     flexers: [Flexer]) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: pieces,
                  flexers: flexers,
                  alignment: .left)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     piece: SkeletonPiece,
                     flexers: [Flexer],
                     alignment: LayoutAlignment) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: [piece],
                  flexers: flexers,
                  alignment: alignment)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     pieces: [SkeletonPiece],
                     flexer: Flexer,
                     alignment: LayoutAlignment) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: pieces,
                  flexers: [flexer],
                  alignment: alignment)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     piece: SkeletonPiece,
                     flexer: Flexer,
                     alignment: LayoutAlignment) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: [piece],
                  flexers: [flexer],
                  alignment: alignment)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     flexer: Flexer,
                     alignment: LayoutAlignment) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: [],
                  flexers: [flexer],
                  alignment: alignment)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     flexers: [Flexer],
                     alignment: LayoutAlignment) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: [],
                  flexers: flexers,
                  alignment: alignment)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     pieces: [SkeletonPiece],
                     alignment: LayoutAlignment) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: pieces,
                  flexers: [],
                  alignment: alignment)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     piece: SkeletonPiece,
                     alignment: LayoutAlignment) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: [piece],
                  flexers: [],
                  alignment: alignment)
    }
    
    
    
    
    
    
    
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     piece: SkeletonPiece,
                     flexers: [Flexer]) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: [piece],
                  flexers: flexers,
                  alignment: .left)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     pieces: [SkeletonPiece],
                     flexer: Flexer) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: pieces,
                  flexers: [flexer],
                  alignment: .left)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     piece: SkeletonPiece,
                     flexer: Flexer) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: [piece],
                  flexers: [flexer],
                  alignment: .left)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     flexer: Flexer) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: [],
                  flexers: [flexer],
                  alignment: .left)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     flexers: [Flexer]) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: [],
                  flexers: flexers,
                  alignment: .left)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     pieces: [SkeletonPiece]) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: pieces,
                  flexers: [],
                  alignment: .left)
    }
    
    convenience init(id: Int,
                     chunkIdentifier: ChunkIdentifier,
                     piece: SkeletonPiece) {
        self.init(id: id,
                  chunkIdentifier: chunkIdentifier,
                  pieces: [piece],
                  flexers: [],
                  alignment: .left)
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
    
    func growChildrenByOne_Unsafe_Bubble() {
        if childrenSize < currentSize {
            childrenSize += 1
        } else {
            growByOne_Unsafe_Bubble()
            childrenSize = currentSize
        }
        didGrowOnCurrentPass = true
    }
    
    func growByOne_Unsafe_Bubble() {
        currentSize += 1
        node.growChildrenByOne_Unsafe_Bubble()
        didGrowOnCurrentPass = true
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
