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
// ------------------------------- inherited from parent -----------------------------------------------

    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    // has user create an account
    @Binding var throwCreateAccountModal : Bool

// ---------------------------------- created in view -----------------------------------------------
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    let sideGraphicHeight = UIScreen.screenHeight * 0.08
    
    var body: some View {
        VStack {
            Button(action: {
                if userAttributes.getHasAccount() {
                    FirebaseAnalytics.Analytics.logEvent("userTappedConnectSpotify", parameters: ["user":"user", "tab":"host"])
                    // open browser
                    SpotifySignInFunctions().launchSpotifyInBrowser()
                    // only for testing
//                    withAnimation {
//                        connectedToSpotify = true
//                    }
                    
                }
                else {
                    throwCreateAccountModal = true
                }
                
                
            }, label: {
                Image("spotifyIconGreen").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .frame(width: 150, height: 150)
            })
            .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .spotifyGreen))
            Text("connect your spotify")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzParagraphOne()
        }
        
    }
    
    
    
}
