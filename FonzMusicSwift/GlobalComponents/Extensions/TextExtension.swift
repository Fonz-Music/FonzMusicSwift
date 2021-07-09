//
//  TextExtension.swift
//  FonzMusicSwift
//
//  Created by didi on 7/8/21.
//

import Foundation
import SwiftUI

extension Text {
    func addUnderline(active: Bool, color: Color) -> some View {
        if active {
            return self.underline(color: color)
        } else {
            return self
        }
    }
}
