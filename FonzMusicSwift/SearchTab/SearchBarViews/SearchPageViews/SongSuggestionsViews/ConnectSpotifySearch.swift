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
    @Binding var throwCreateAccountModal : Bool
    
    @Binding var hasAccount : Bool
    
    @Binding var connectedToSpotify : Bool
    
    // has user download full app if on app clip
    @State var throwDownlaodFullAppModal = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
            #if !APPCLIP
            if hasAccount {
                HostFonzSessionApi().createSession()
                SpotifyInBrowser().launchSpotifyInBrowser()
                
            }
            else {
                throwCreateAccountModal = true
            }
            
            print("pressed button")
            FirebaseAnalytics.Analytics.logEvent("guestPressedConnectSpotify", parameters: ["user":"user", "tab": "search"])
            
            #else
            throwDownlaodFullAppModal = true
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
                
            }.frame(width: UIScreen.screenWidth * 0.9, height: 60)
            
            
        })
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
        .padding()
        .sheet(isPresented: $throwDownlaodFullAppModal) {
            DownloadFullAppPrompt()
        }
    }
}
