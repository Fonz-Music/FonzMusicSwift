//
//  LinkSpotifySettingsButton.swift
//  FonzMusicSwift
//
//  Created by didi on 7/20/21.
//

import SwiftUI
import FirebaseAnalytics

struct LinkSpotifySettingsButton: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    
    var body: some View {
        Button(action: {
//            HostFonzSessionApi().getAllSessions()
            SpotifySignInFunctions().launchSpotifyInBrowser()
                
            
            
            print("pressed button")
            FirebaseAnalytics.Analytics.logEvent("userPressedLinkSpotify", parameters: ["user":"user", "tab": "settings"])
        }, label: {
            HStack {
                HStack(spacing: 5) {
                    Image("spotifyIconAmber").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                        
                    Text("connect Spotify")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzButtonText()
                        .padding(.horizontal)
                }
                Spacer()
            }.frame(width: UIScreen.screenWidth * .outerContainerFrameWidthSettings, height: 20)
            .padding()
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
//        .buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
    }
}
