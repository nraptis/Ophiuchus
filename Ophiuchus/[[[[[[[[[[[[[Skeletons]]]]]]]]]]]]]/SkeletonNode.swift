//
//  SkeletonNode.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

public class SkeletonNode: InterfaceContainerSupplier {
    
    
    
    static func contains(list: [SkeletonNode], node: SkeletonNode) -> Bool {
        for _node in list {
            if _node === node {
                return true
            }
        }
        return false
    }
    
    func contains(chunk: SkeletonChunk) -> Bool {
        for _chunk in chunks {
            if _chunk === chunk {
                return true
            }
        }
        return false
    }
    
    func contains(piece: SkeletonPiece) -> Bool {
        for _chunk in chunks {
            for _piece in _chunk.pieces {
                if _piece === piece {
                    return true
                }
            }
        }
        return false
    }
    
    func contains(flexer: Flexer) -> Bool {
        for _chunk in chunks {
            for _flexer in _chunk.flexers {
                if _flexer === flexer {
                    return true
                }
            }
        }
        return false
    }
    
    func countPieces() -> Int {
        var result = 0
        
                for chunk in chunks {
                    result += chunk.pieces.count
                }
        
        return result
    }
    
    func countFlexers() -> Int {
        var result = 0
        
                for chunk in chunks {
                    result += chunk.flexers.count
                }
        
        return result
    }
    
    public static func quick(size: Int, flex: Int) -> SkeletonNode {
        
        let piece_id = SkeletonIdentifierFactory.get_id()
        let piece = SkeletonPiece(id: piece_id, pieceIdentifier: .unknown, size: size)
        
        let chunk_1_id = SkeletonIdentifierFactory.get_id()
        
        let chunk_1 = SkeletonChunk(id: chunk_1_id,
                                    chunkIdentifier: .unknown,
                                    pieces: [piece],
                                    flexers: [],
                                    alignment: .center)
        
        let flexer_id = SkeletonIdentifierFactory.get_id()
        let flexer = Flexer(id: flexer_id,
                            flexerIdentifier: .unknown,
                            flex / 4,
                            flex / 3,
                            flex / 2,
                            flex)
        
        let chunk_2_id = SkeletonIdentifierFactory.get_id()
        let chunk_2 = SkeletonChunk(id: chunk_2_id,
                                    chunkIdentifier: .unknown,
                                    pieces: [],
                                    flexers: [flexer],
                                    alignment: .center)
        let id = SkeletonIdentifierFactory.get_id()
        let result = SkeletonNode(id: id, chunks: [chunk_1, chunk_2],
                                  alignment: .center)
        return result
    }
    
    public static func generate(chunks: [SkeletonChunk], alignment: LayoutAlignment) -> SkeletonNode {
        let id = SkeletonIdentifierFactory.get_id()
        let result = SkeletonNode(id: id, chunks: chunks,
                                  alignment: alignment)
        return result
    }
    
    public var currentSize = 0
    public var childrenSize = 0
    public var didGrowOnCurrentPass = false
    
    public let id: Int
    let chunks: [SkeletonChunk]
    let alignment: LayoutAlignment
    
    unowned var section: SkeletonSection!
    unowned var row: SkeletonRow!
    unowned var group: ExploderGroup<SkeletonNode>!
    var didGrowOnCurrentPadd = false
    
    var x = 0
    var width = 0
    
    init(id: Int,
         chunks: [SkeletonChunk],
         alignment: LayoutAlignment) {
        self.id = id
        self.chunks = chunks
        self.alignment = alignment
    }
    
    func growChildrenByOne_Unsafe_Bubble() {
        if childrenSize < currentSize {
            childrenSize += 1
        } else {
            currentSize += 1
            childrenSize = currentSize
        }
        section.growChildrenByOne_Unsafe_Bubble()
        didGrowOnCurrentPass = true
    }
    
    func computeSize(layoutPriority: LayoutPriority) -> Int {
        var result = 0
        for chunk in chunks {
            result += chunk.computeSize(layoutPriority: layoutPriority)
        }
        return result
    }
    
    func validateAssumingLargeRow_test(layoutPriority: LayoutPriority) -> Bool {
        
        
        return true
    }
    
    func getFlexer(flexerIdentifier: FlexerIdentifier) -> Flexer? {
        for chunk in chunks {
            for flexer in chunk.flexers {
                if flexer.flexerIdentifier == flexerIdentifier {
                    return flexer
                }
            }
        }
        return nil
    }
    
    static func getFlexer(skeletonNodes: [SkeletonNode],
                          flexerIdentifier: FlexerIdentifier) -> Flexer? {
        for skeletonNode in skeletonNodes {
            for chunk in skeletonNode.chunks {
                for flexer in chunk.flexers {
                    if flexer.flexerIdentifier == flexerIdentifier {
                        return flexer
                    }
                }
            }
        }
        return nil
    }
    
    func getPiece(pieceIdentifier: PieceIdentifier) -> SkeletonPiece? {
        for chunk in chunks {
            for piece in chunk.pieces {
                if piece.pieceIdentifier == pieceIdentifier {
                    return piece
                }
            }
        }
        return nil
    }
    
    static func getPiece(skeletonNodes: [SkeletonNode],
                         pieceIdentifier: PieceIdentifier) -> SkeletonPiece? {
        for skeletonNode in skeletonNodes {
            for chunk in skeletonNode.chunks {
                for piece in chunk.pieces {
                    if piece.pieceIdentifier == pieceIdentifier {
                        return piece
                    }
                }
            }
        }
        return nil
    }
    
    func getChunk(chunkIdentifier: ChunkIdentifier) -> SkeletonChunk? {
        for chunk in chunks {
            if chunk.chunkIdentifier == chunkIdentifier {
                return chunk
            }
        }
        return nil
        
    }
    
    static func getChunk(skeletonNodes: [SkeletonNode],
                         chunkIdentifier: ChunkIdentifier) -> SkeletonChunk? {
        for skeletonNode in skeletonNodes {
            for chunk in skeletonNode.chunks {
                if chunk.chunkIdentifier == chunkIdentifier {
                    return chunk
                }
            }
        }
        return nil
    }
    
    func position_content_after_size_computation() {
        
        
        var width_of_all_chunks = 0
        for chunk in chunks {
            width_of_all_chunks += chunk.currentSize
        }
        
        var layout_x = 0
        switch alignment {
        case .none, .left:
            for chunk in chunks {
                chunk.x = layout_x
                layout_x += chunk.currentSize
            }
        case .center:
            layout_x = currentSize / 2 - width_of_all_chunks / 2
            if layout_x < 0 { layout_x = 0 }
            for chunk in chunks {
                chunk.x = layout_x
                layout_x += chunk.currentSize
            }
        case .right:
            layout_x = currentSize - width_of_all_chunks
            if layout_x < 0 { layout_x = 0 }
            for chunk in chunks {
                chunk.x = layout_x
                layout_x += chunk.currentSize
            }
        }
        
    }
    
    func canGrowByOne() -> Bool {
        if section.childrenSize < section.currentSize {
            return true
        }
        if row.canGrowByOne(section: section) {
            return true
        }
        return false
    }
    
}
