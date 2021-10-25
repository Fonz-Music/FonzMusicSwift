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
    
    // gets dark/light mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView{
            VStack {
                
                
                PavCoreContent(hostCoaster: hostCoaster, hasHostVar: $hasHostVar)
                
                SearchContentForPubs(hostCoaster: hostCoaster, hasHostVar: $hasHostVar, userAttributes: userAttributes)
                Spacer()
                    
            }
//            .background(
//                ZStack{
//    //                Rectangle()
//    //                    .fill(Color.amber)
//                        // darkens background when typing
//    //                    .darkenView(isEditingSearchBar)
//                    VStack{
//
//                        Image("pavHalfBg")
//                            .opacity(0.6)
//                            .frame(maxWidth: UIScreen.screenWidth)
//                        Spacer()
//                    }
//                }, alignment: .top)
            
        }
    }
}
