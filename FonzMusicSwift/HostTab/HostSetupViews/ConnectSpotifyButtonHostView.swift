//
//  ConnectSpotifyButtonHostView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/24/21.
//

import SwiftUI
import Foundation
//import Firebase
import FirebaseAnalytics

struct ConnectSpotifyButtonHomeView: View {
// ---------------------------------- created in view -----------------------------------------------

    @Binding var connectedToSpotify : Bool
    // determines if current user has an account
    @Binding var hasAccount : Bool
    // has user create an account
    @Binding var throwCreateAccountModal : Bool
//
//    @Binding var showHomeButtons: Bool
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        VStack {
            Button(action: {
                if hasAccount {
                    withAnimation {
        //                selectedTab = 1
    //                    pressedButtonToLaunchSpotifySignIn = true
                        connectedToSpotify = true

                        UserDefaults.standard.set(true, forKey: "connectedToSpotify")
                    }
                    FirebaseAnalytics.Analytics.logEvent("userTappedConnectSpotify", parameters: ["user":"user", "tab":"host"])
                    SpotifyInBrowser().launchSpotifyInBrowser()
                }
                else {
                    throwCreateAccountModal = true
                }
                
                
            }, label: {
                Image("spotifyIconGreen").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width: 125, height: 125)
            })
            .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .spotifyGreen))
            Text("connect your spotify")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzRoundButtonText()
        }
    }
}
