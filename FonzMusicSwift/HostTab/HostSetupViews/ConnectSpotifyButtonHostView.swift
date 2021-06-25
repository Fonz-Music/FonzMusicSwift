//
//  ConnectSpotifyButtonHostView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/24/21.
//

import SwiftUI
import Foundation
import Firebase

struct ConnectSpotifyButtonHomeView: View {
// ---------------------------------- created in view -----------------------------------------------

    @Binding var connectedToSpotify : Bool
//
//    @Binding var showHomeButtons: Bool
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.openURL) var openURL
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
    //                selectedTab = 1
//                    pressedButtonToLaunchSpotifySignIn = true
                    connectedToSpotify = true
                   
                }
                guard let user = Auth.auth().currentUser else {
                    print("there was an error getting the user")
                    return
                }
                user.getIDToken(){ (idToken, error) in
                    if error == nil, let token = idToken {
                        let userToken = token

                        guard let url = URL(string: "https://api.fonzmusic.com/auth/spotify?token=\(userToken)") else {
                            return
                        }
                        openURL(url)
                    }
                }
                
            }, label: {
                Image("spotifyIcon").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width: 125, height: 125)
            })
            .buttonStyle(NeumorphicButtonStyleCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .successGreen))
            Text("connect your spotify")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzParagraphTwo()
        }
    }
}
