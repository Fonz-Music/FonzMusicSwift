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
            SpotifySignInFunctions().launchSpotifyInBrowser()
            #if !APPCLIP
            FirebaseAnalytics.Analytics.logEvent("userTappedConnectSpotify", parameters: ["user":"user", "tab":"settings", "fullOrClip":"full"])
            #else
            FirebaseAnalytics.Analytics.logEvent("userTappedConnectSpotify", parameters: ["user":"user", "tab":"settings", "fullOrClip":"clip"])
            #endif
            
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
