//
//  InterfaceProviderIcon.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/22/25.
//

import Foundation

public protocol InterfaceProviderIconPack {
    func getElementIconPack(interfaceProviderType: InterfaceProviderType) -> AnyTextIconPackable
}

public final class AnyInterfaceProviderIconPack: InterfaceProviderIconPack {
    private let wrapped: any InterfaceProviderIconPack

    public init(_ wrapped: some InterfaceProviderIconPack) {
        self.wrapped = wrapped
    }

    public func getElementIconPack(interfaceProviderType: InterfaceProviderType) -> AnyTextIconPackable {
        return wrapped.getElementIconPack(interfaceProviderType: interfaceProviderType)
    }
}
