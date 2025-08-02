//
//  InterfaceProviderHero.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/22/25.
//

import Foundation

public protocol InterfaceProviderHero: InterfaceProviderIconPack {
    func getElementName(interfaceProviderType: InterfaceProviderType, line: Int) -> String?
}

public final class AnyInterfaceProviderHero {
    private let wrapped: any InterfaceProviderHero

    public init(_ wrapped: some InterfaceProviderHero) {
        self.wrapped = wrapped
    }

    public func getElementIconPack(interfaceProviderType: InterfaceProviderType) -> AnyTextIconPackable {
        return wrapped.getElementIconPack(interfaceProviderType: interfaceProviderType)
    }
    
    public func getElementName(interfaceProviderType: InterfaceProviderType, line: Int) -> String? {
        return wrapped.getElementName(interfaceProviderType: interfaceProviderType, line: line)
    }
}
