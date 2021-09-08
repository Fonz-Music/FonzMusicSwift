//
//  SongListModalSongButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/28/21.
//

import SwiftUI

struct SongListModalSongButton: View {
    
    // hostCoaster details passed in and will update view when changed
    @StateObject var hostCoaster:HostCoasterInfo
    
    @Binding var statusCodeQueueSong : Int

    
    var trackToQueue : Track
    
    // track object to update the song to queue
    @StateObject var currentTune : GlobalTrack
    // bool that will launch nfc when pressed
    @Binding var pressedSongToLaunchNfc : Bool
    // boolean to change when views should be showed w animation
    @Binding var showQueueResponse : Bool
    
    
    var body: some View {
        Button {
            DispatchQueue.main.async {
            
                currentTune.songId = trackToQueue.songId
                currentTune.artistName = trackToQueue.artistName
                currentTune.albumArt = trackToQueue.albumArt
                currentTune.spotifyUrl = trackToQueue.spotifyUrl
                currentTune.songName = trackToQueue.songName
                if (currentTune.songId != "") {
                    withAnimation{
                        showQueueResponse = true
                        statusCodeQueueSong = GuestApi().queueSong(sessionId: hostCoaster.sessionId, trackId: trackToQueue.songId)
                    }
                }
            }
//            currentTune.songId = trackToQueue.songId
//            currentTune.artistName = trackToQueue.artistName
//            currentTune.albumArt = trackToQueue.albumArt
//            currentTune.spotifyUrl = trackToQueue.spotifyUrl
//            currentTune.songName = trackToQueue.songName
//            pressedSongToLaunchNfc = true
            hideKeyboard()
        } label: {
            SongResultFromSearchItemView(item: trackToQueue)
        }

    }
    
}
