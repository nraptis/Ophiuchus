//
//  SkeletonPiecesAndFlexers.swift
//  InterfaceKit
//
//  Created by Nick on 8/9/25.
//

import Foundation

class SkeletonPiecesAndFlexers {
    var pieces: [SkeletonPiece]
    var flexers: [Flexer]
    
    init(pieces: [SkeletonPiece], flexers: [Flexer]) {
        self.pieces = pieces
        self.flexers = flexers
    }
    
    init() {
        self.pieces = []
        self.flexers = []
    }
    
    func intake(_ piecesAndFlexers: SkeletonPiecesAndFlexers) {
        self.pieces.append(contentsOf: piecesAndFlexers.pieces)
        self.flexers.append(contentsOf: piecesAndFlexers.flexers)
    }
    
    func intake(pieces: [SkeletonPiece]) {
        self.pieces.append(contentsOf: pieces)
    }
    
    func intake(piece: SkeletonPiece) {
        self.pieces.append(piece)
    }
    
    func intake(flexers: [Flexer]) {
        self.flexers.append(contentsOf: flexers)
    }
    
    func intake(flexer: Flexer) {
        self.flexers.append(flexer)
    }
    
    static func getPieces(list: [SkeletonPiecesAndFlexers]) -> [SkeletonPiece] {
        var size = 0
        for item in list {
            size += item.pieces.count
        }
        var result = [SkeletonPiece]()
        result.reserveCapacity(size)
        for item in list {
            result.append(contentsOf: item.pieces)
        }
        return result
    }
    
    static func getFlexers(list: [SkeletonPiecesAndFlexers]) -> [Flexer] {
        var size = 0
        for item in list {
            size += item.flexers.count
        }
        var result = [Flexer]()
        result.reserveCapacity(size)
        for item in list {
            result.append(contentsOf: item.flexers)
        }
        return result
    }
    
}
