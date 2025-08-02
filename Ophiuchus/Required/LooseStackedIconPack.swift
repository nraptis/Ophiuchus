//
//  LooseStackedIconPack.swift
//  It's You
//
//  Created by Nicholas Raptis on 6/17/25.
//

import Foundation

public struct LooseStackedIconPack: TextIconPackable {
    
    let planePad_1: IconPlane
    let planePhoneLandscape_1: IconPlane
    let planePhonePortrait_1: IconPlane
    
    let planePad_2: IconPlane
    let planePhoneLandscape_2: IconPlane
    let planePhonePortrait_2: IconPlane
    
    public init(planePad_1: IconPlane,
                planePhoneLandscape_1: IconPlane,
                planePhonePortrait_1: IconPlane,
                
                planePad_2: IconPlane,
                planePhoneLandscape_2: IconPlane,
                planePhonePortrait_2: IconPlane) {
        
        self.planePad_1 = planePad_1
        self.planePhoneLandscape_1 = planePhoneLandscape_1
        self.planePhonePortrait_1 = planePhonePortrait_1
        
        self.planePad_2 = planePad_2
        self.planePhoneLandscape_2 = planePhoneLandscape_2
        self.planePhonePortrait_2 = planePhonePortrait_2
    }
    
    public func getTextIcon(orientation: Orientation,
                            layoutSchemeFlavor: LayoutSchemeFlavor,
                            numberOfLines: Int,
                            isDarkModeEnabled: Bool,
                            isEnabled: Bool) -> (any TextIconable) {
        if numberOfLines >= 2 {
            if Device.isPad {
                return planePad_2.getTextIcon(isDarkModeEnabled: isDarkModeEnabled, isEnabled: isEnabled)
            } else {
                if orientation.isLandscape {
                    return planePhoneLandscape_2.getTextIcon(isDarkModeEnabled: isDarkModeEnabled, isEnabled: isEnabled)
                } else {
                    return planePhonePortrait_2.getTextIcon(isDarkModeEnabled: isDarkModeEnabled, isEnabled: isEnabled)
                }
            }
        } else {
            if Device.isPad {
                return planePad_1.getTextIcon(isDarkModeEnabled: isDarkModeEnabled, isEnabled: isEnabled)
            } else {
                if orientation.isLandscape {
                    return planePhoneLandscape_1.getTextIcon(isDarkModeEnabled: isDarkModeEnabled, isEnabled: isEnabled)
                } else {
                    return planePhonePortrait_1.getTextIcon(isDarkModeEnabled: isDarkModeEnabled, isEnabled: isEnabled)
                }
            }
        }
    }
    
}
