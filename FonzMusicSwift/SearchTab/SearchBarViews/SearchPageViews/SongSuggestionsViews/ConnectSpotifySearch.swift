//
//  ConnectSpotifySearch.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct ConnectSpotifySearch: View {
    
    // has user create an account
//    @Binding var throwCreateAccountModal : Bool
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    // has user download full app if on app clip
    @State var throwDownlaodFullAppModal = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
            
            
            #if !APPCLIP
            SpotifySignInFunctions().launchSpotifyInBrowser()
            FirebaseAnalytics.Analytics.logEvent("userTappedConnectSpotify", parameters: ["user":"user", "tab":"search", "fullOrClip":"full"])
            #else
            throwDownlaodFullAppModal = true
            FirebaseAnalytics.Analytics.logEvent("userTappedConnectSpotify", parameters: ["user":"user", "tab":"search", "fullOrClip":"clip"])
            #endif
            
        }, label: {
            HStack {
                HStack{
                    ZStack{
                        
                        Image("spotifyIcon").resizable().frame(width: 30 ,height: 30, alignment: .leading)
                    }.background(
                        RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                            .fill(Color.amber)
                            .frame(width: 60, height: 60)
                    )
                    .frame(width: 60, height: 60)
                    
                        
                    Text("want access to your favorite playlists, artists, & songs?")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphThree()
                        .padding(.horizontal, 5)
                    Spacer()
                }.padding(.vertical)
                
            }
            .frame(height: 60)
            
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
        .padding(.horizontal, .subHeadingFrontIndent)
        .frame(width: UIScreen.screenWidth, alignment: .center)
        .sheet(isPresented: $throwDownlaodFullAppModal) {
            DownloadFullAppPrompt()
        }
    }
}
