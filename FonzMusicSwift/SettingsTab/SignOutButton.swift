//
//  SignOutButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct SignOutButton: View {
    // determines if current user has an account
    @Binding var hasAccount : Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
            FirebaseAnalytics.Analytics.logEvent("userPressedSignOut", parameters: ["user":"user", "tab": "settings"])
//                    pressedButtonToLaunchNfc = true
            print("pressed button")
            UserDefaults.standard.set(false, forKey: "hasAccount")
            hasAccount = false
        }, label: {
            HStack {
                HStack(spacing: 5) {
                    Image("signOutIcon").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                        
                    Text("sign out")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzButtonText()
                        .padding(.horizontal)
                }
                Spacer()
            }.frame(width: UIScreen.screenWidth * 0.8, height: 20)
            .padding()
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
//        .buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
    }
}
