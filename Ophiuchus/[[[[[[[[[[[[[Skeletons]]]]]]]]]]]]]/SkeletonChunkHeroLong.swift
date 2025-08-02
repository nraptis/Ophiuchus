//
//  SkeletonChunkHeroLong.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

public class SkeletonChunkHeroLong: SkeletonChunkConforming {
    
    public let id: Int
    public let chunkIdentifier: ChunkIdentifier
    public var currentSize = 0
    public var children_size = 0
    public var didGrowOnCurrentPass = false
    
    let left: Flexer
    let icon: SkeletonPiece
    let spacing: Flexer
    let label: SkeletonPiece
    let right: Flexer
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
         left: Flexer,
         icon: SkeletonPiece,
         spacing: Flexer,
         label: SkeletonPiece,
         right: Flexer,
         alignment: LayoutAlignment) {
        self.id = id
        self.chunkIdentifier = chunkIdentifier
        self.left = left
        self.icon = icon
        self.spacing = spacing
        self.label = label
        self.right = right
        self.alignment = alignment
        self.pieces = [icon, label]
        self.flexers = [left, spacing, right]
    }
    
}
