//
//  SearchBar.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//


import SwiftUI

struct SearchBar: View {
// ---------------------------------- inherited from parent -----------------------------------------

    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    
// ---------------------------------- created inside view -------------------------------------------
    // checks to see if currently typing in searchbar
    @State private var isEditing = false
    // so the button can only be pressed once
    @State var queuePopupPresent = false
    // temp track object that is filled when user taps on a song, is then
    // sent to the queueSongSheet to add to host's queue
    var tempTune = GlobalTrack()
    // object that stores the songs from the api
    @ObservedObject var tracksFromSearch: TracksFromSearch = TracksFromSearch()
    // for the results of the search bar
    let layout = [
            GridItem(.flexible())
        ]
    
        var body: some View {
            
            VStack {
                // search bar & results
                HStack {
                    // search bar
                    TextField("queue a song", text: $tracksFromSearch.searchText)
                        .foregroundColor(Color(.systemGray))
                        .fonzParagraphTwo()
                        .padding()
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color(.systemGray))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 16)
                                // if actively editing, show x button to clear
                                if isEditing {
                                    Button(action: {
                                        self.tracksFromSearch.searchText = ""
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        ).padding(.horizontal, 10)
                        .onTapGesture {
                            self.isEditing = true
                        }
                    // if actively editing, show cancel button
                    if isEditing {
                        Button(action: {
                            self.isEditing = false
                            self.tracksFromSearch.searchText = ""
         
                        }) {
                            Text("cancel")
                        }
                        .padding(.trailing, 10)
                        .transition(.opacity)
                        .animation(.easeOut)
                    }
                    Spacer()
                }.padding(.vertical, 10)
                .padding(.horizontal, 20)
                
                // list view from searching song
                if tracksFromSearch.products.count > 0 {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: layout, spacing: 12) {
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
                                    ItemView(item: item)
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
                    }.frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                // what is shown if nothing has been searched
                else {
                    Spacer()
                }
                
            }
            .background(Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255))
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // passes the sessionId from the host into the results return
                tracksFromSearch.tempSession = hostCoaster.sessionId
                // sets the page number to 1 so that the nav button works
//                guestPageNumber = 1
        }
    }
}
