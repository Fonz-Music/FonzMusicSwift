//
//  PavRoute.swift
//  FonzMusicSwift
//
//  Created by didi on 10/25/21.
//

import SwiftUI

struct PavRoute: View {
    // hostCoaster details passed in and will update view when changed
    @StateObject var hostCoaster:HostCoasterInfo
    // checks if guest has a host
    @Binding var hasHostVar : Bool
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    // object that stores the songs from the api
    @ObservedObject var trackFromNowPlaying: TrackFromNowPlaying = TrackFromNowPlaying()
    
    @State var showQueuePage : Bool = false
    
    // gets dark/light mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
            if !showQueuePage {
                ScrollView{
                    VStack {
                        PavCoreContent(hostCoaster: hostCoaster, hasHostVar: $hasHostVar)
                        
//                        Spacer()
//                            .frame(height: 40)
//                        if trackFromNowPlaying.songPlaying {
                            ActiveSongView(hostName: hostCoaster.hostName, currentSessionId: hostCoaster.sessionId, trackfromNowPlaying: trackFromNowPlaying)
//                        }
                        
                        QueueASongPubButton(showQueuePage: $showQueuePage)
                        Spacer()
                            
                    }
                }
                .ignoresSafeArea()
                .background(
                   
                            Image("pavHalfBg")
                                .resizable()
                                .opacity(0.6)
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
//                            Spacer()
                       , alignment: .top)
//                .transition(.move(edge: .top))
                .transition(.opacity)
            }
            else {
                SearchBarPage(hostCoaster: hostCoaster, hasHostVar: $showQueuePage, userAttributes: userAttributes)
//                    .transition(.slide)
                    .transition(.opacity)
                    .transition(.move(edge: .bottom))
            }
            
        
    }
}
