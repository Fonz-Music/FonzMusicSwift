//
//  ChangeDisplayNameButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct ChangeDisplayNameButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
//                    pressedButtonToLaunchNfc = true
            print("pressed button")
            FirebaseAnalytics.Analytics.logEvent("userPressedChangeName", parameters: ["user":"user", "tab": "settings"])
        }, label: {
            HStack {
                HStack(spacing: 5) {
                    Image("changeNameIcon").resizable().frame(width: 27 ,height: 27, alignment: .leading)
                        
                    Text("change your name")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzButtonText()
                        .padding(.horizontal)
                }
                Spacer()
            }
            .frame(width: UIScreen.screenWidth * 0.8, height: 20)
            .padding()
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
//        .buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
    }
}
