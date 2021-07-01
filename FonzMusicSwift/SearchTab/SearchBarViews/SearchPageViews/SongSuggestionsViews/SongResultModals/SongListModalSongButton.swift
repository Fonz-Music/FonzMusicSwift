//
//  SongListModalSongButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/28/21.
//

import SwiftUI

struct SongListModalSongButton: View {
    
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    

    
    var trackToQueue : Track
    
    // track object to update the song to queue
    @Binding var currentTune : GlobalTrack
    // bool that will launch nfc when pressed
    @Binding var pressedSongToLaunchNfc : Bool
    
    
    var body: some View {
        Button {
            currentTune.songId = trackToQueue.songId
            currentTune.artistName = trackToQueue.artistName
            currentTune.albumArt = trackToQueue.albumArt
            currentTune.spotifyUrl = trackToQueue.spotifyUrl
            currentTune.songName = trackToQueue.songName
            pressedSongToLaunchNfc = true
        } label: {
            SongResultFromSearchItemView(item: trackToQueue)
        }

    }
    
}
