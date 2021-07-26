//
//  ViewExtensions.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import Foundation
import SwiftUI
//
//  View.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//


extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                withAnimation{
                    self.hidden()
                }
               
            }
        } else {
            self
        }
    }
    
    @ViewBuilder func addOpacity(_ needOpacity: Bool) -> some View {
        if needOpacity {
            self.opacity(0.5)
        } else {
            self
        }
    }
    
    @ViewBuilder func darkenView(_ darken: Bool) -> some View {
        if darken {
            self.brightness(-0.3)
        } else {
            self
        }
    }
    
    @ViewBuilder func fonzShadow() -> some View {
        self.shadow(radius: 3, x: 3, y: 3)
    }
    
    @ViewBuilder func determineHostButtonSize(connectedToSpotify : Bool) -> some View {
        if connectedToSpotify {
            self.frame(width: 250, height: 250)
        }
        else {
            self.frame(width: 75, height: 75)
        }
    }
    
    
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
