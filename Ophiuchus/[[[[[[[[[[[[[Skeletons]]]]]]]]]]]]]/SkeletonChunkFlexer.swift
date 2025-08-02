//
//  SkeletonChunkFlexer.swift
//  Ophiuchus
//
//  Created by Nick on 7/4/25.
//

import Foundation

public class SkeletonChunkFlexer: SkeletonChunkConforming {
    
    public let id: Int
    public let chunkIdentifier: ChunkIdentifier
    public var currentSize = 0
    public var children_size = 0
    public var didGrowOnCurrentPass = false
    
    public let flexer: Flexer
    public let alignment: LayoutAlignment
    
    public unowned var node: SkeletonNode!
    public unowned var section: SkeletonSection!
    public unowned var row: SkeletonRow!
    public unowned var group_unsafe: ExploderGroupChunks!
    public unowned var group: ExploderGroupChunks!
    
    public let pieces: [SkeletonPiece]
    public let flexers: [Flexer]
    
    public var x = 0
    public var width = 0
    
    init(id: Int,
         chunkIdentifier: ChunkIdentifier,
         flexer: Flexer,
         alignment: LayoutAlignment) {
        self.id = id
        self.chunkIdentifier = chunkIdentifier
        self.flexer = flexer
        self.alignment = alignment
        self.pieces = []
        self.flexers = [flexer]
    }
    
}
