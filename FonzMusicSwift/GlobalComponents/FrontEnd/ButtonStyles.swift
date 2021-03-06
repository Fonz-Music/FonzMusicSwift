//
//  NeumorphicButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//

import SwiftUI


struct CircleButtonGradiant: ButtonStyle {
    var bgColorTopLeft: Color
    var bgColorBottomRight: Color
    var secondaryColor: Color
//    var selectedOption : Bool?
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    Circle()
                        .fill(configuration.isPressed ? LinearGradient(
                                gradient: .init(colors: [secondaryColor, secondaryColor]),
                                startPoint: .topLeading,
                                  endPoint: .bottomTrailing
                        ) : LinearGradient(
                            gradient: .init(colors: [bgColorTopLeft, bgColorBottomRight]),
                            startPoint: .topLeading,
                              endPoint: .bottomTrailing
                            ) )
                        .shadow(radius: 5)
                        .overlay(
                        Circle().stroke(secondaryColor, lineWidth: 3)
                    )
                }
        )
            .animation(.spring())
    }
}


struct BasicFonzButtonCircle: ButtonStyle {
    var bgColor: Color
    var secondaryColor: Color
//    var selectedOption : Bool?
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    Circle()
                        .fill(configuration.isPressed ? secondaryColor : bgColor )
                        .fonzShadow()
                        .overlay(
                        Circle().stroke(secondaryColor, lineWidth: 3)
                    )
                }
        )
            .animation(.spring())
    }
}
struct BasicFonzButtonCircleNoBorder: ButtonStyle {
    var bgColor: Color
    var secondaryColor: Color
//    var selectedOption : Bool?
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    Circle()
                        .fill(configuration.isPressed ? secondaryColor : bgColor )
                        .fonzShadow()
//                        .overlay(
//                        Circle().stroke(secondaryColor, lineWidth: 3)
//                    )
                }
        )
            .animation(.spring())
    }
}
struct BasicFonzButtonCircleNoBorderGradiant: ButtonStyle {
    var bgColor: Color
    var secondaryColor: Color
//    var selectedOption : Bool?
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    Circle()
//                        .fill(LinearGradient(
//                              gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
//                              startPoint: .init(x: 0.5, y: 0),
//                              endPoint: .init(x: 0.5, y: 0.6)
//                            ))
                        .fill(LinearGradient(gradient: .init(colors: [.purple ,.lilacDark, .amber, .red]), startPoint: .init(x: 0.25, y: 0.25), endPoint: .init(x: 1.0, y: 1.0)))
//                        .fill(configuration.isPressed ? secondaryColor : bgColor )
                        .fonzShadow()
//                        .overlay(
//                        Circle().stroke(secondaryColor, lineWidth: 3)
//                    )
                }
        )
            .animation(.spring())
    }
}


struct BasicFonzButton: ButtonStyle {
    var bgColor: Color
    var secondaryColor: Color
    var selectedOption : Bool?
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                        .fill(configuration.isPressed ? secondaryColor : bgColor )
                        .fonzShadow()
                        
                        .overlay(
                            RoundedRectangle(cornerRadius: .cornerRadiusTasks).stroke(secondaryColor, lineWidth: selectedOption ?? false ? 1:0)
                    )
                }
        )
            .animation(.spring())
    }
}


struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color
    var secondaryColor: Color
    var selectedOption : Bool?
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
//            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks, style: .continuous)
                        .shadow(color: colorScheme == .light ? Color.dropShadowLight: .dropShadow, radius: configuration.isPressed ? 0: 4, x: configuration.isPressed ? 0: -2, y: configuration.isPressed ? 0: -2)
                        .shadow(color: colorScheme == .light ? .dropLightLight: .dropLight, radius: configuration.isPressed ? 0: 4, x: configuration.isPressed ? 0: 2, y: configuration.isPressed ? 0: 2)
                        .blendMode(colorScheme == .light ? .darken: .overlay)
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks, style: .continuous).overlay(
                        RoundedRectangle(cornerRadius: .cornerRadiusTasks, style: .continuous).stroke(secondaryColor, lineWidth: selectedOption ?? false ? 1:0)
                    )
//                        .stroke(Color.amber, lineWidth: selectedOption ?? false ? 1:0)
//                        .fill(bgColor)
                }
        )
//            .scaleEffect(configuration.isPressed ? 0.95: 1)
//            .foregroundColor(Color(red: 235 / 255, green: 139 / 255, blue: 55 / 255))
            .foregroundColor(configuration.isPressed ? secondaryColor : bgColor)
            .animation(.spring())
    }
}

struct NeumorphicButtonStyleCircle: ButtonStyle {
    var bgColor: Color
    var secondaryColor: Color
//    var selectedOption : Bool?
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    Circle()
                        .shadow(color: colorScheme == .light ? Color.dropShadowLight: .dropShadow, radius: configuration.isPressed ? 0: 8, x: configuration.isPressed ? 0: -4, y: configuration.isPressed ? 0: -4)
                        .shadow(color: colorScheme == .light ? .dropLightLight: .dropLight, radius: configuration.isPressed ? 0: 8, x: configuration.isPressed ? 0: 4, y: configuration.isPressed ? 0: 4)
                        .blendMode(colorScheme == .light ? .darken: .overlay)
                    Circle().overlay(
                        Circle().stroke(secondaryColor, lineWidth: 3)
                    )
//                        .stroke(Color.amber, lineWidth: selectedOption ?? false ? 1:0)
//                        .fill(bgColor)
                }
        )
//            .scaleEffect(configuration.isPressed ? 0.9: 1)
//            .foregroundColor(Color(red: 235 / 255, green: 139 / 255, blue: 55 / 255))
            .foregroundColor(configuration.isPressed ? secondaryColor : bgColor)
            .animation(.spring())
    }
}
