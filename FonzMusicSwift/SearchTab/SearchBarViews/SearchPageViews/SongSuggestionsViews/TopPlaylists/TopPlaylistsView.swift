//
//  TopPlaylistsView.swift
//  FonzMusicSwift
//
//  Created by didi on 7/31/21.
//

import SwiftUI
import FirebaseAnalytics

struct TopPlaylistsView: View {
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // the song passed in
    let playlistIn: Playlist
    // object that stores the songs from the api
    @ObservedObject var tracksFromPlaylist: TracksFromPlaylist
    
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var launchPlaylistSongsModal = false
    
    
    var body: some View {
        Button {
            launchPlaylistSongsModal = true
            tracksFromPlaylist.playlist = playlistIn.playlistName
            FirebaseAnalytics.Analytics.logEvent("guestSelectedPlaylist", parameters: ["user":"guest", "tab":"search"])
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
//            PlaylistSongListModal(hostCoaster: hostCoaster, resultsTitle: playlistIn.playlistName, resultsType: "\(playlistIn.amountOfTracks) tracks", resultsImage: playlistIn.playlistImage, currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc, tracksFromEntry: tracksFromPlaylist)
            PlaylistSongListModal(hostCoaster: hostCoaster, resultsTitle: playlistIn.playlistName, resultsType: "\(playlistIn.amountOfTracks) tracks", resultsImage: playlistIn.playlistImage, tracksFromEntry: tracksFromPlaylist)
        }
        
    }
}
