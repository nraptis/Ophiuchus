//
//  SkeletonNodeCarrier.swift
//  InterfaceKit
//
//  Created by Nick on 7/8/25.
//

import Foundation

@frozen public enum SkeletonNodeCarrier {
    case invalid
    case convertible(SkeletonNodeCarrierDataConvertible)
    case `static`(SkeletonNode)
}
