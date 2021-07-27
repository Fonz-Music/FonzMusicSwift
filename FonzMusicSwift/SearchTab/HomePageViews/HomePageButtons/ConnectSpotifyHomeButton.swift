//
//  ConnectSpotifyHomeButton.swift
//  FonzMusicSwift
//
//  Created by didi on 7/17/21.
//

import SwiftUI
import Foundation
//import Firebase
import FirebaseAnalytics

struct ConnectSpotifyHomeButton: View {
// ---------------------------------- created in view -----------------------------------------------

//    @Binding var connectedToSpotify : Bool
    // determines if current user has an account
    @Binding var hasAccount : Bool
    // has user create an account
    @State var throwCreateAccountModal = false
    // has user download full app if on app clip
    @State var throwDownlaodFullAppModal = false
//
//    @Binding var showHomeButtons: Bool
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    let sideGraphicHeight = UIScreen.screenHeight * 0.04
    
    var body: some View {
        VStack {
            Button(action: {
                

//
                #if !APPCLIP
                if hasAccount {
//                    HostFonzSessionApi().getAllSessions()

                    FirebaseAnalytics.Analytics.logEvent("userTappedConnectSpotify", parameters: ["user":"user", "tab":"host"])
                    SpotifyInBrowser().launchSpotifyInBrowser()
                }
                else {
                    throwCreateAccountModal = true
                }
                #else
                throwDownlaodFullAppModal = true
                #endif
            }, label: {
                Image("spotifyIconGreen").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width: 75, height: 75)
            })
            .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .spotifyGreen))
            Text("connect to spotify")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
//                .fonzRoundButtonText()
                .fonzParagraphTwo()
        }
        .sheet(isPresented: $throwCreateAccountModal) {
            CreateAccountPrompt(hasAccount: $hasAccount, showModal: $throwCreateAccountModal)
        }
        .sheet(isPresented: $throwDownlaodFullAppModal) {
            DownloadFullAppPrompt()
        }
    }
}
