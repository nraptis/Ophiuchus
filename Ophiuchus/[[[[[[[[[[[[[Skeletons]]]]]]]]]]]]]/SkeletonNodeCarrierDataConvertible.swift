//
//  SkeletonNodeCarrierDataConvertible.swift
//  InterfaceKit
//
//  Created by Nick on 7/8/25.
//

import Foundation

public struct SkeletonNodeCarrierDataConvertible {
    public let nodeStacked: SkeletonNode
    public let nodeLong: SkeletonNode
    public init(nodeStacked: SkeletonNode, nodeLong: SkeletonNode) {
        self.nodeStacked = nodeStacked
        self.nodeLong = nodeLong
    }
}
