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
    @StateObject var tracksFromSearch: TracksFromSearch
    // hostCoaster details passed in and will update view when changed
    @StateObject var hostCoaster:HostCoasterInfo
    // track object to update the song to queue
    @StateObject var currentTune : GlobalTrack
    // checks to see if currently typing in searchbar
    @Binding var isEditing : Bool
    // int of queue sogn return
    @Binding var statusCodeQueueSong : Int
    // boolean to change when views should be showed w animation
    @Binding var showQueueResponse : Bool
    
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
                                    // sets temp tune attributes to pass into sheet
                                    currentTune.albumArt = item.albumArt
                                    currentTune.songId = item.songId
                                    currentTune.songName = item.songName
                                    currentTune.artistName = item.artistName
                                    currentTune.spotifyUrl = item.spotifyUrl
                                if (currentTune.songId != "") {
                                    withAnimation{
                                        showQueueResponse = true
                                        statusCodeQueueSong = queueSongToHostSession(sessionId: hostCoaster.sessionId, trackId: currentTune.songId)
                                    }
                                }
                                hideKeyboard()
                            }, label: {
                                SongResultFromSearchItemView(item: item.toTrack())
                                    .onAppear {
                                        
                                        print("index is \(item.index)")
                                        
                                        if item.index == (tracksFromSearch.resultsPerSearch - 3) {
                                            print("should be updating")
                                            tracksFromSearch.offset += 25
                                            tracksFromSearch.updateSearch = true
                                        }
                                    }
                                    
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
