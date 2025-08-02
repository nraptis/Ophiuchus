//
//  InterfaceProviderHeroWithCheckBox.swift
//  It's You
//
//  Created by Nick on 7/3/25.
//

import Foundation
import Foundation

public protocol InterfaceProviderHeroWithCheckBox: InterfaceProviderHero {
    func getCheckBoxBoxIconPack(interfaceProviderType: InterfaceProviderType) -> AnyTextIconPackable
    func getCheckBoxCheckIconPack(interfaceProviderType: InterfaceProviderType) -> AnyTextIconPackable
}

public final class AnyInterfaceProviderHeroWithCheckBox {
    private let wrapped: any InterfaceProviderHeroWithCheckBox

    public init(_ wrapped: some InterfaceProviderHeroWithCheckBox) {
        self.wrapped = wrapped
    }

    public func getElementIconPack(interfaceProviderType: InterfaceProviderType) -> AnyTextIconPackable {
        return wrapped.getElementIconPack(interfaceProviderType: interfaceProviderType)
    }
    
    public func getElementName(interfaceProviderType: InterfaceProviderType, line: Int) -> String? {
        return wrapped.getElementName(interfaceProviderType: interfaceProviderType, line: line)
    }
    
    public func getCheckBoxBoxIconPack(interfaceProviderType: InterfaceProviderType) -> AnyTextIconPackable {
        return wrapped.getCheckBoxBoxIconPack(interfaceProviderType: interfaceProviderType)
    }
    
    func getCheckBoxCheckIconPack(interfaceProviderType: InterfaceProviderType) -> AnyTextIconPackable {
        return wrapped.getCheckBoxCheckIconPack(interfaceProviderType: interfaceProviderType)
    }
    
}
