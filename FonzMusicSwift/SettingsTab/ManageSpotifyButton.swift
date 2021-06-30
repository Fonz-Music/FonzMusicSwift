//
//  ManageSpotifyButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/25/21.
//

import SwiftUI
import Firebase

struct ManageSpotifyButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {

            print("pressed button")
            FirebaseAnalytics.Analytics.logEvent("userPressedManageSpotify", parameters: ["user":"user", "tab": "settings"])
        }, label: {
            HStack {
                HStack(spacing: 5) {
                    Image("spotifyIconAmber").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                        
                    Text("spotify account")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphTwo()
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
