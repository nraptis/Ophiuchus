//
//  SkeletonIdentifierFactory.swift
//  InterfaceKit
//
//  Created by Nick on 7/8/25.
//

import Foundation

public struct SkeletonIdentifierFactory {
    static let id_queue = DispatchQueue(label: "skeleton_id_queue")
    nonisolated(unsafe) private static var __id = 0
    public static func get_id() -> Int {
        let result = id_queue.sync {
            let id = SkeletonIdentifierFactory.__id
            SkeletonIdentifierFactory.__id += 1
            if SkeletonIdentifierFactory.__id > 1_000_000_000 { SkeletonIdentifierFactory.__id = 0 }
            return id
        }
        return result
    }
}
