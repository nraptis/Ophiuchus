//
//  AnyTextIcon.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/17/25.
//

import UIKit

public class AnyTextIcon: TextIconable, CustomStringConvertible {
    
    public let fileName: String
    private var _image: UIImage?
    public func getImage() -> UIImage {
        if let image = _image {
            return image
        } else if let image = UIImage(named: fileName) {
            _image = image
            return image
        } else {
            let image = UIImage()
            _image = image
            return image
        }
    }
    
    public let width: Int
    public let height: Int
    public var device: TextIconDevice
    public var orientation: Orientation?
    public init(fileName: String,
                device: TextIconDevice,
                orientation: Orientation?,
                width: Int,
                height: Int) {
        self.fileName = fileName
        self.device = device
        self.orientation = orientation
        self.width = width
        self.height = height
    }
    
    //TODO: Eventially Remove Thiz...
    public var description: String {
        let image = getImage()
        let _atlasWidth = Int(image.size.width + 0.5)
        let _atlasHeight = Int(image.size.height + 0.5)
        let isValid = _atlasWidth > 4 && _atlasHeight > 4
        let result = "TextIcon {\(fileName)} V: \(isValid), SIZE: [\(width) x \(height)]"
        return result
    }
    
}
