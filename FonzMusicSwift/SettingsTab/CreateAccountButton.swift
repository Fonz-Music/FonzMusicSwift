//
//  CreateAccountButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct CreateAccountButton: View {

    // has user create an account
    @Binding var throwCreateAccountModal : Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
            throwCreateAccountModal = true
            print("pressed button")
            FirebaseAnalytics.Analytics.logEvent("userPressedCreateAccountSettings", parameters: ["user":"user", "tab": "settings"])
        }, label: {
            HStack {
                HStack(spacing: 5) {
                    Image("spotifyIconAmber").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                        
                    Text("create account")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzButtonText()
                        .padding(.horizontal)
                }
                Spacer()
            }.frame(width: UIScreen.screenWidth * 0.8, height: 20)
            .padding()
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
    }
}
