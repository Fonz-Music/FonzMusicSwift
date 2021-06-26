//
//  YourTopPlaylists.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI

struct YourTopPlaylists: View {
    
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // track object to update the song to queue
    @Binding var currentTune : GlobalTrack
    // bool that will launch nfc when pressed
    @Binding var pressedSongToLaunchNfc : Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var topPlaylists =
    [
        Playlist(playlistName:  "This Is Rush",  playlistId: "37i9dQZF1DX9E92APFiTvV", playlistImage: "https://i.scdn.co/image/ab67706f0000000336834b90af842ac737f7dac3", amountOfTracks: 50),
        Playlist(playlistName: "memoryLane",  playlistId: "3sRM90oyy8Zul8iF3Cg3RF", playlistImage: "https://i.scdn.co/image/ab67706c0000bebbbbb8672f1afbe3add6554550", amountOfTracks: 83),
        Playlist(playlistName: "beautifulEscape",  playlistId: "4d2ObNuTa7AIMJY8TGvLDB", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb12bc8c494507c2f6550b919b", amountOfTracks: 23),
        Playlist(playlistName:   "manifest destiny", playlistId: "4TOUWjjIiwBNXj82cLnltq", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb802a02183d45115fc2639cb6", amountOfTracks: 234),
        Playlist(playlistName:  "malibuNinetyTwo", playlistId: "6rqm7IuR0DRbktih6FV9jm", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb0e65fceaffd297b0f3f14756", amountOfTracks: 212)

    ]
    
    var body: some View {
        VStack {
            Text("your top playlists")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzParagraphTwo()
                .padding(25)
                .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                .padding(.bottom, 30)
            
                ZStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<topPlaylists.count) {
                                
                                TopPlaylistsView(hostCoaster: hostCoaster, playlistIn: topPlaylists[$0], currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
                            }
                        }
                    }
                    .padding(20)
                }
                .background(
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                    .fill(colorScheme == .light ? Color.white: Color.darkButton)
                    .frame(width: UIScreen.screenWidth * 0.9, height: 220, alignment: .center)
                        .fonzShadow()
                )
                .padding(.horizontal)
        }
    }
}

struct TopPlaylistsView: View {
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // the song passed in
    let playlistIn: Playlist
    // track object to update the song to queue
    @Binding var currentTune : GlobalTrack
    // bool that will launch nfc when pressed
    @Binding var pressedSongToLaunchNfc : Bool
    
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var launchPlaylistSongsModal = false
    
    
    var body: some View {
        Button {
            launchPlaylistSongsModal = true
        } label: {
            VStack {
                AsyncImage(url: URL(string: playlistIn.playlistImage)!,
                           placeholder: { Text("...").fonzParagraphTwo() },
                               image: { Image(uiImage: $0).resizable() })
                    .frame( width: 120 ,height: 120, alignment: .leading).cornerRadius(.cornerRadiusTasks)
                Text(playlistIn.playlistName)
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzParagraphTwo()
                    .frame(width: 120, alignment: .topLeading)
                Text("\(playlistIn.amountOfTracks) tracks")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzParagraphThree()
                    .frame(width: 120, alignment: .topLeading)
            }
            .frame(width: 120, height: 165, alignment: .center)
        }
        .sheet(isPresented: $launchPlaylistSongsModal, onDismiss: {
            print("test")
//                                    self.currentTune.songLoaded = false
//                                    self.queuesLeft += 1
        }) {
            SongListModal(hostCoaster: hostCoaster, resultsTitle: playlistIn.playlistName, resultsType: "\(playlistIn.amountOfTracks) tracks", resultsImage: playlistIn.playlistImage, currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
        }
        
    }
}
