//
//  FramedLongIconPack.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/17/25.
//

import Foundation

public struct FramedLongIconPack: TextIconPackable {
    
    let planePad_0: IconPlane
    let planePhoneLandscape_0: IconPlane
    let planePhonePortrait_0: IconPlane
    
    public init(planePad_0: IconPlane,
                planePhoneLandscape_0: IconPlane,
                planePhonePortrait_0: IconPlane) {
        self.planePad_0 = planePad_0
        self.planePhoneLandscape_0 = planePhoneLandscape_0
        self.planePhonePortrait_0 = planePhonePortrait_0
    }
    
    public func getTextIcon(orientation: Orientation,
                            layoutSchemeFlavor: LayoutSchemeFlavor,
                            numberOfLines: Int,
                            isDarkModeEnabled: Bool,
                            isEnabled: Bool) -> (any TextIconable) {
        if Device.isPad {
            return planePad_0.getTextIcon(isDarkModeEnabled: isDarkModeEnabled, isEnabled: isEnabled)
        } else {
            if orientation.isLandscape {
                return planePhoneLandscape_0.getTextIcon(isDarkModeEnabled: isDarkModeEnabled, isEnabled: isEnabled)
            } else {
                return planePhonePortrait_0.getTextIcon(isDarkModeEnabled: isDarkModeEnabled, isEnabled: isEnabled)
            }
        }
    }
}
