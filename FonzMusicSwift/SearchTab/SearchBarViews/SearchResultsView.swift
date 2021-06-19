//
//  SearchResultsView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI

// list view from searching song
struct SearchResultsView: View {
// --------------------- inherited in view -------------------------------------------
        // so the button can only be pressed once
    // object that stores the songs from the api
    @ObservedObject var tracksFromSearch: TracksFromSearch
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    
    
// --------------------- created in view -------------------------------------------
    // so the button can only be pressed once
    @State var queuePopupPresent = false
    // temp track object that is filled when user taps on a song, is then
    // sent to the queueSongSheet to add to host's queue
    var tempTune = GlobalTrack()
    
    @Environment(\.colorScheme) var colorScheme
    
    let layout = [
            GridItem(.flexible())
        ]
    
    var body: some View {
        
        
        if tracksFromSearch.products.count > 0 {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorScheme == .light ? Color.white: Color.darkButton)
                ScrollView() {
                    LazyVGrid(columns: layout, spacing: 8) {
                        ForEach(tracksFromSearch.products, id: \.self) { item in
                            Button(action: {
                                print("button pressed: \(queuePopupPresent)" )
                                // temp button to send the song to a mate
    //                                    shareButton(urlToShare: item.spotifyUrl)
                                // sets the current song to song chosen
                                if !queuePopupPresent {
                                    // bool to launch queueSongSheet set to true
                                    self.queuePopupPresent = true
                                    // sets temp tune attributes to pass into sheet
                                    self.tempTune.albumArt = item.albumArt
                                    self.tempTune.songId = item.songId
                                    self.tempTune.songName = item.songName
                                    self.tempTune.artistName = item.artistName
                                    self.tempTune.songLoaded = true
                                self.tempTune.spotifyUrl = item.spotifyUrl
                                }
                            }, label: {
                                SongResultItemView(item: item)
                            })
                            // launches queueSongSheet after song is selected
                            .sheet(isPresented: $queuePopupPresent, onDismiss: {
                                print("test")
    //                                    self.currentTune.songLoaded = false
    //                                    self.queuesLeft += 1
                            }) {
                                QueueSongSheet(currentTune: tempTune, hostCoaster: hostCoaster, queuePopupPresent: $queuePopupPresent)
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
            }
            .frame(width: UIScreen.screenWidth * 0.9, height: 450)
        }
    }
    
}
