//
//  HostPage.swift
//  Fonz Music App Clip
//
//  Created by didi on 1/31/21.
//

import SwiftUI
import StoreKit

struct HostPage: View {
    let imageHeight = UIScreen.screenHeight * 0.15
    @State private var showAppStoreOverlay = true
    
    @Environment(\.openURL) var openURL
    
    
    var body: some View {
        ZStack {
            Color(red: 235 / 255, green: 139 / 255, blue: 55 / 255).ignoresSafeArea()
            VStack{
                Spacer()
                Image("coasterIcon").resizable()
                    .frame(width: imageHeight * 1.2, height: imageHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("host").fonzHeading()
                Text("you need to download the full version to be a host").fonzParagraphOne()
                Spacer()
                Link(destination: URL(string: "https://apps.apple.com/us/app/fonz-music/id1537308329")!,
                label: {
                    Text("take me there")
                        .fonzSubheading()
                }).buttonStyle(NeumorphicButtonStyle(bgColor: .amber))
                Spacer()
                Text("App Store Overlay")
                        .hidden()
                        .appStoreOverlay(isPresented: $showAppStoreOverlay) {
//                            return SKOverlay.AppConfiguration(appIdentifier: "1537308329", position: .bottom)
                            return SKOverlay.AppClipConfiguration(position: .bottom)
                        }
            }
        }
    }
}

struct HostPage_Previews: PreviewProvider {
    static var previews: some View {
        HostPage()
    }
}

struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .shadow(color: Color(red: 209 / 255, green: 209 / 255, blue: 214 / 255), radius: configuration.isPressed ? 5: 5, x: configuration.isPressed ? -5: -5, y: configuration.isPressed ? -5: -5)
                        .shadow(color: Color(red: 72 / 255, green: 72 / 255, blue: 74 / 255), radius: configuration.isPressed ? 5: 5, x: configuration.isPressed ? 5: 5, y: configuration.isPressed ? 5: 5)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
        )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
//            .foregroundColor(Color(red: 235 / 255, green: 139 / 255, blue: 55 / 255))
            .foregroundColor(bgColor)
            .animation(.spring())
    }
}
