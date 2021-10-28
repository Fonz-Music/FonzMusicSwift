//
//  YourTopPlaylists.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct YourTopPlaylists: View {
    
    // hostCoaster details passed in and will update view when changed
    @StateObject var hostCoaster:HostCoasterInfo
    
    // object that stores the songs from the api
    @StateObject var tracksFromPlaylist: TracksFromPlaylist
    
    @StateObject var guestTopPlaylists: GuestTopPlaylists
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    @Environment(\.colorScheme) var colorScheme
    
    @State var connectedToSpotify : Bool = false
    
    
    var body: some View {
        VStack {
            HStack{
                Text(connectedToSpotify ? "your top playlists" : "fonz top playlists")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzParagraphTwo()
                    .padding(.horizontal, .subHeadingFrontIndent)
                    .padding(.bottom, 10)
                    .padding(.top, 25)
                    
                Spacer()
            }
            
                ZStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(guestTopPlaylists.products, id: \.self) { playlist in
                                TopPlaylistsView(hostCoaster: hostCoaster, playlistIn: playlist.toPlaylist(),  tracksFromPlaylist: tracksFromPlaylist, userAttributes: userAttributes)
                            }
                            if connectedToSpotify {
                //                .padding(.horizontal, 5)
                                Button(action: {
                                    guestTopPlaylists.loadMorePlaylists()
                                }, label: {
                                    
                                        
                                    // load more
                                    VStack(alignment: .center) {
                                        Spacer()
                                        Image(systemName: "arrow.clockwise")
                                            .padding(.horizontal, 10)
                                            .padding(.top, 10)
                                            .foregroundColor(.amber)
                                        Spacer()
                                        Text("load more")
                                            .foregroundColor(.amber)
                                            .fonzParagraphThree()
                                        Spacer()
                                    }
                                    .frame(width: UIScreen.screenWidth * 0.35, height: UIScreen.screenWidth * 0.35)
                                    .animation(.easeIn)
                                })
                                .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber, selectedOption: true))
                                
                                .padding(.trailing, 5)
                            }
//                            ForEach(0..<guestTopPlaylists.products.count) {
//
//                                TopPlaylistsView(hostCoaster: hostCoaster, playlistIn: guestTopPlaylists.products[$0],  tracksFromPlaylist: tracksFromPlaylist)
//                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical)
                }
                .background(
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                        .fill(colorScheme == .light ? Color.white: Color.darkButton)
                        .padding(.horizontal, .subHeadingFrontIndent)
                        .frame(width: UIScreen.screenWidth, height: 200, alignment: .center)
                        .fonzShadow()
                    , alignment: .top
                )
                .padding(.horizontal)
        }
        .onAppear {
           connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                guestTopPlaylists.loadTopPlaylists()
            }
        }
    }
}

