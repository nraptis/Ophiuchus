//
//  ExploderConforming.swift
//  Ophiuchus
//
//  Created by Nick on 7/4/25.
//

import Foundation

public protocol ExploderConforming: AnyObject {
    
    var id: Int { get }
    var currentSize: Int { get }
    
}
