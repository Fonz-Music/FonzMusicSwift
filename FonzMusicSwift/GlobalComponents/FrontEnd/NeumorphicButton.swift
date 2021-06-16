//
//  NeumorphicButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//

import SwiftUI

struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color
    var selectedOption : Bool?
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .shadow(color: colorScheme == .light ? Color.dropShadowLight: .dropShadow, radius: configuration.isPressed ? 2: 4, x: configuration.isPressed ? -2: 2, y: configuration.isPressed ? -2: 2)
                        .shadow(color: colorScheme == .light ? .dropLightLight: .dropLight, radius: configuration.isPressed ? 2: 4, x: configuration.isPressed ? 2: -2, y: configuration.isPressed ? 2: -2)
                        .blendMode(colorScheme == .light ? .darken: .overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous).overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.amber, lineWidth: selectedOption ?? false ? 1:0)
                    )
//                        .stroke(Color.amber, lineWidth: selectedOption ?? false ? 1:0)
//                        .fill(bgColor)
                }
        )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
//            .foregroundColor(Color(red: 235 / 255, green: 139 / 255, blue: 55 / 255))
            .foregroundColor(bgColor)
            .animation(.spring())
    }
}
