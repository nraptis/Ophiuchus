//
//  TextIconable.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/17/25.
//

import UIKit

public protocol TextIconable {
    var fileName: String { get }
    var width: Int { get }
    var height: Int { get }
    var device: TextIconDevice { get }
    var orientation: Orientation? { get }
    func getImage() -> UIImage
}
