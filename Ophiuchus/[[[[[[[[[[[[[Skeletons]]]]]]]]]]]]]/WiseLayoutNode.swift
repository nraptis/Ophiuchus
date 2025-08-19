//
//  WiseLayoutNode.swift
//  InterfaceKit
//
//  Created by Nicholas Raptis on 6/21/25.
//

import Foundation

public class WiseLayoutNode: ExploderConforming {
    
    
    static func generate(id: Int, pieces: [SkeletonPiece], flexers: [Flexer]) -> WiseLayoutNode {
        let result = WiseLayoutNode(id: id,
                                    pieces: pieces,
                                    flexers: flexers)
        result.currentSize = 0
        for flexer in result.flexers {
            result.currentSize += flexer.currentSize
        }
        for piece in result.pieces {
            result.currentSize += piece.currentSize
        }
        result.childrenSize = result.currentSize
        return result
    }
    
    static func generate(pieces: [SkeletonPiece], flexers: [Flexer]) -> WiseLayoutNode {
        let id = SkeletonIdentifierFactory.get_id()
        let result = generate(id: id,
                              pieces: pieces,
                              flexers: flexers)
        
        return result
    }
    
    static func generate(pieces: [SkeletonPiece]) -> WiseLayoutNode {
        let id = SkeletonIdentifierFactory.get_id()
        let result = generate(id: id,
                              pieces: pieces,
                              flexers: [])
        return result
    }
    
    static func generate(flexers: [Flexer]) -> WiseLayoutNode {
        let id = SkeletonIdentifierFactory.get_id()
        let result = generate(id: id,
                              pieces: [],
                              flexers: flexers)
        return result
    }
    
    public var currentSize = 0
    public var childrenSize = 0
    
    var __snapshotCurrentSize = 0
    var __expectedCurrentSize = 0
    
    
    var didGrowOnCurrentPass = false
    var requestedGrowthFromChildren = 0
    
    var requestedGrowthFromChildrenMax = 0
    var requestedGrowthFromChildrenMin = 0
    
    
    var didChildRequestGrowthOnCurrentPass = false
    //var didGrowOnCurrentPass = false
    
    //var requestedGrowthFromChildrenMaximum = 0
    
    //var bubble = 0
    //var bubbleMin = 0
    //var bubbleMax = 0
    var gap = 0
    
    var name = ""
    
    //var requestedGrowthForParent = 0
    var temp = 0
    //var proposedGrowthAmount = 0
    
    var isLockedAtEveryPriority = false
    var isLockedAtCurrentPriority = false
    
    public let id: Int
    public let toolInterfaceElement: ToolInterfaceElement
    public let toolInterfaceElementType: ToolInterfaceElementType
    public let interfaceProvider: InterfaceProvider
    public let configuration: Any
    public let isStacked: Bool
    public let layoutScheme: LayoutScheme.Type
    public let layoutSchemeFlavor: LayoutSchemeFlavor
    public var x = 0
    public var width = 0
    let pieces: [SkeletonPiece]
    let flexers: [Flexer]
    var segmentedPiecesAndFlexers: [SkeletonPiecesAndFlexers]?
    
    var isLeftOfCenter = false
    
    //TODO: Back to unowned..
    var section: SkeletonSection!
    //TODO: Back to unowned..
    var row: SkeletonRow!
    
    unowned var group: ExploderGroup<WiseLayoutNode>!
    
    
    public init(id: Int,
                toolInterfaceElement: ToolInterfaceElement,
                toolInterfaceElementType: ToolInterfaceElementType,
                interfaceProvider: InterfaceProvider,
                configuration: Any,
                isStacked: Bool,
                layoutScheme: LayoutScheme.Type,
                layoutSchemeFlavor: LayoutSchemeFlavor,
                pieces: [SkeletonPiece],
                flexers: [Flexer]) {
        
        self.id = id
        self.toolInterfaceElement = toolInterfaceElement
        self.toolInterfaceElementType = toolInterfaceElementType
        self.interfaceProvider = interfaceProvider
        self.configuration = configuration
        self.isStacked = isStacked
        self.layoutScheme = layoutScheme
        self.layoutSchemeFlavor = layoutSchemeFlavor
        self.flexers = flexers
        self.pieces = pieces
        for _piece in pieces {
            _piece.node = self
        }
        for _flexer in flexers {
            _flexer.node = self
        }
        
    }
    
    public convenience init(id: Int,
                            pieces: [SkeletonPiece],
                            flexers: [Flexer]) {
        let layoutSchemeFlavor = LayoutSchemeFlavor(stackingFormat: .invalid,
                                                    fontScale: .large)
        self.init(id: id,
                  toolInterfaceElement: .invalid,
                  toolInterfaceElementType: .invalid,
                  interfaceProvider: .invalid,
                  configuration: 0,
                  isStacked: true,
                  layoutScheme: EmptyLayoutScheme.self,
                  layoutSchemeFlavor: layoutSchemeFlavor,
                  pieces: pieces,
                  flexers: flexers)
    }
    
    public convenience init(id: Int,
                            flexers: [Flexer]) {
        let layoutSchemeFlavor = LayoutSchemeFlavor(stackingFormat: .invalid,
                                                    fontScale: .large)
        self.init(id: id,
                  toolInterfaceElement: .invalid,
                  toolInterfaceElementType: .invalid,
                  interfaceProvider: .invalid,
                  configuration: 0,
                  isStacked: true,
                  layoutScheme: EmptyLayoutScheme.self,
                  layoutSchemeFlavor: layoutSchemeFlavor,
                  pieces: [],
                  flexers: flexers)
    }
    
    public convenience init(id: Int,
                            pieces: [SkeletonPiece]) {
        let layoutSchemeFlavor = LayoutSchemeFlavor(stackingFormat: .invalid,
                                                    fontScale: .large)
        self.init(id: id,
                  toolInterfaceElement: .invalid,
                  toolInterfaceElementType: .invalid,
                  interfaceProvider: .invalid,
                  configuration: 0,
                  isStacked: true,
                  layoutScheme: EmptyLayoutScheme.self,
                  layoutSchemeFlavor: layoutSchemeFlavor,
                  pieces: pieces,
                  flexers: [])
    }
    
    func getFlexer(flexerIdentifier: FlexerIdentifier) -> Flexer? {
        
        for _flexer in flexers {
            if _flexer.flexerIdentifier == flexerIdentifier {
                return _flexer
            }
        }
        
        return nil
    }
    
    func getPiece(pieceIdentifier: PieceIdentifier) -> SkeletonPiece? {
        
        for _piece in pieces {
            if _piece.pieceIdentifier == pieceIdentifier {
                return _piece
            }
        }
        
        return nil
    }
    
    func childrenSizeMatchesChildren() -> Bool {
        var sum = 0
        for flexer in flexers {
            sum += flexer.currentSize
        }
        for piece in pieces {
            sum += piece.currentSize
        }
        if (sum == childrenSize) {
            return true
        } else {
            return false
        }
    }
    
}
