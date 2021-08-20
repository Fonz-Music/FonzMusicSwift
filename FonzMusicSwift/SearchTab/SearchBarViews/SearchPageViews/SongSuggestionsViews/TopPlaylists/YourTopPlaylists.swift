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
    @ObservedObject var hostCoaster:HostCoasterInfo
    
    // object that stores the songs from the api
    @ObservedObject var tracksFromPlaylist: TracksFromPlaylist
    
    @ObservedObject var guestTopPlaylists: GuestTopPlaylists
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var connectedToSpotify : Bool = false
    
//    var topPlaylists =
//    [
//        Playlist(playlistName:  "This Is Rush",  playlistId: "37i9dQZF1DX9E92APFiTvV", playlistImage: "https://i.scdn.co/image/ab67706f0000000336834b90af842ac737f7dac3", amountOfTracks: 50),
//        Playlist(playlistName: "memoryLane",  playlistId: "3sRM90oyy8Zul8iF3Cg3RF", playlistImage: "https://i.scdn.co/image/ab67706c0000bebbbbb8672f1afbe3add6554550", amountOfTracks: 83),
//        Playlist(playlistName: "beautifulEscape",  playlistId: "4d2ObNuTa7AIMJY8TGvLDB", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb12bc8c494507c2f6550b919b", amountOfTracks: 23),
//        Playlist(playlistName:   "manifest destiny", playlistId: "4TOUWjjIiwBNXj82cLnltq", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb802a02183d45115fc2639cb6", amountOfTracks: 234),
//        Playlist(playlistName:  "malibuNinetyTwo", playlistId: "6rqm7IuR0DRbktih6FV9jm", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb0e65fceaffd297b0f3f14756", amountOfTracks: 212)
//
//    ]
    
    var body: some View {
        VStack {
            HStack{
                Text(connectedToSpotify ? "your top playlists" : "spotify top playlists")
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
                            ForEach(0..<guestTopPlaylists.products.count) {
                                
                                TopPlaylistsView(hostCoaster: hostCoaster, playlistIn: guestTopPlaylists.products[$0],  tracksFromPlaylist: tracksFromPlaylist)
                            }
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
           
        }
    }
}

