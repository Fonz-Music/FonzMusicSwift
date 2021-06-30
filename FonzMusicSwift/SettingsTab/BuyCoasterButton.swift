//
//  BuyCoasterButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
import Foundation
import Firebase

struct BuyCoasterButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    
    var body: some View {
        Button(action: {
            guard let url = URL(string: "https://www.fonzmusic.com/buy") else {
                return
            }
            openURL(url)
            print("pressed button")
            FirebaseAnalytics.Analytics.logEvent("userPressedBuyCoaster", parameters: ["user":"user", "tab": "settings"])
        }, label: {
            HStack {
                HStack(spacing: 5) {
                    Image("coasterIconAmber").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                        
                    Text("buy a coaster")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphTwo()
                        .padding(.horizontal)                        }
                Spacer()
            }.frame(width: UIScreen.screenWidth * 0.8, height: 20)
            .padding()
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
//        .buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
    }
}
