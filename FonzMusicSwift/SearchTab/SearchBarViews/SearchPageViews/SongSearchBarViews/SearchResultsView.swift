//
//  SearchResultsView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

// list view from searching song
struct SearchResultsView: View {
// --------------------- inherited in view -------------------------------------------
        // so the button can only be pressed once
    // object that stores the songs from the api
    @ObservedObject var tracksFromSearch: TracksFromSearch
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // track object to update the song to queue
    @Binding var currentTune : GlobalTrack
    // bool that will launch nfc when pressed
    @Binding var pressedSongToLaunchNfc : Bool
    
    
// --------------------- created in view -------------------------------------------



    
    @Environment(\.colorScheme) var colorScheme
    
    let layout = [
            GridItem(.flexible())
        ]
    
    var body: some View {
        
        
        if tracksFromSearch.products.count > 0 {
            ZStack {
                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                    .fill(colorScheme == .light ? Color.white: Color.darkButton)
                ScrollView() {
                    LazyVGrid(columns: layout, spacing: 8) {
                        ForEach(tracksFromSearch.products, id: \.self) { item in
                            Button(action: {
                                FirebaseAnalytics.Analytics.logEvent("guestSelectedSearchedSong", parameters: ["user":"guest", "tab":"search"])

                                // sets the current song to song chosen
                                if !pressedSongToLaunchNfc {
                                    // bool to launch queueSongSheet set to true
                                    self.pressedSongToLaunchNfc = true
                                    // sets temp tune attributes to pass into sheet
                                    currentTune.albumArt = item.albumArt
                                    currentTune.songId = item.songId
                                    currentTune.songName = item.songName
                                    currentTune.artistName = item.artistName
                                    currentTune.songLoaded = true
                                    currentTune.spotifyUrl = item.spotifyUrl
                                }
                            }, label: {
                                SongResultFromSearchItemView(item: item)
                                    
                            })
                            
                        }
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                }
                .padding(.vertical, 10)
            }
            .frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenHeight * 0.6)
        }
    }
    
}
