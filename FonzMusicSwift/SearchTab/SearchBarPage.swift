//
//  SearchBar.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//


import SwiftUI

struct SearchBarPage: View {
// ---------------------------------- inherited from parent -----------------------------------------

    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // checks if guest has a host
    @Binding var hasHostVar : Bool
    // determines if current user has an account
    @Binding var hasAccount : Bool
    
    @Binding var connectedToSpotify : Bool
    // track object inherited from song search
    @State var currentTune:GlobalTrack = GlobalTrack()
    
    
// ---------------------------------- created inside view -------------------------------------------
    // object that stores the songs from the api
    @ObservedObject var tracksFromSearch: TracksFromSearch = TracksFromSearch()
    // object that stores the songs from the api
    @ObservedObject var tracksFromPlaylist: TracksFromPlaylist = TracksFromPlaylist()
    // object that stores the songs from the api
    @ObservedObject var tracksFromArtist: TracksFromArtist = TracksFromArtist()
    // object that stores the songs from the api
    @ObservedObject var trackFromNowPlaying: TrackFromNowPlaying = TrackFromNowPlaying()
    
    @State var scale: CGFloat = 1
    @Environment(\.colorScheme) var colorScheme
    
    // boolean to change when views should be showed w animation
    @State var hideViews = true
    
    // checks to see if currently typing in searchbar
    @State var isEditingSearchBar = false
    // bool auto set to false, set to true if nfc is launched
    @State var launchedNfc = false
    // bool auto set to false, set to true if song is selected
    @State var pressedSongToLaunchNfc = false
    // init var that keeps status code
    @State var statusCodeQueueSong = 0
    
    
    
        var body: some View {
            // entire page is a scrollView
            ScrollView(showsIndicators: false) {
                
                VStack {
                    // top search headar & quit part button
                    ZStack {
                        HStack{
                            Text("search")
                                .foregroundColor(Color.white)
                                .fonzParagraphOne()
                                .padding(25)
                            Spacer()
                        }.padding(.top, 40)
                        HStack{
                            Spacer()
                            Button {
                                withAnimation {
                                    hasHostVar = false
                                }
                            } label: {
                                Text("leave party")
                                    .fonzParagraphTwo()
                                    .padding(25)

                            }
                        }.padding(.top, 40)
                        
                        
                    }
                    // search bar widget
                    SearchBarView(tracksFromSearch: tracksFromSearch, isEditing: $isEditingSearchBar)
                    ZStack {
                        // now playing + song suggestions
                        VStack{
                            
                            ActiveSongView(hostName: hostCoaster.hostName, currentSessionId: hostCoaster.sessionId, trackfromNowPlaying: trackFromNowPlaying)
                            SongSuggestionsView(hostCoaster: hostCoaster, currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc, tracksFromPlaylist: tracksFromPlaylist, tracksFromArtist: tracksFromArtist, hasAccount: $hasAccount, connectedToSpotify: $connectedToSpotify)
                                
                        }
                        .isHidden(hideViews)
                        .addOpacity(isEditingSearchBar)
                        
                        
                        // search results
                        if isEditingSearchBar {
                            VStack {
                                SearchResultsView(tracksFromSearch: tracksFromSearch, hostCoaster: hostCoaster, currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
                                Spacer()
                            }
                        }
                        
                    }
                    if pressedSongToLaunchNfc {
                        LaunchQueueSongNfcSessionSheet(tempCoaster: hostCoaster, songInfo: currentTune, statusCode: $statusCodeQueueSong, launchedNfc: $launchedNfc, pressedButtonToLaunchNfc: $pressedSongToLaunchNfc)
                            .frame(width: 0, height: 0)
                    }
                
            }
            .onAppear {
                // disables bounce
                UIScrollView.appearance().bounces = false
                // passes the sessionId from the host into the results return
                tracksFromSearch.tempSession = hostCoaster.sessionId
                tracksFromPlaylist.tempSession = hostCoaster.sessionId
                tracksFromArtist.tempSession = hostCoaster.sessionId
                trackFromNowPlaying.tempSession = hostCoaster.sessionId
            
                trackFromNowPlaying.nowPlaying = "mac"
                // waits .5 seconds before showing views
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        hideViews = false
                    }
                }
            }
        }
            .background(
                ZStack{
                    Rectangle()
                        .fill(LinearGradient(
                            gradient: .init(colors: [.amber, .lilac]),
                            startPoint: .topLeading,
                              endPoint: .bottomTrailing
                            ))
                        // darkens background when typing
                        .darkenView(isEditingSearchBar)
                    Image("mountainProfile")
                        .opacity(0.4)
                        .frame(maxWidth: UIScreen.screenWidth, alignment: .bottom)
                }, alignment: .bottom)
            
//        .background(
//            Image("mountainProfile")
//                .opacity(0.4)
//                .frame(maxWidth: UIScreen.screenWidth), alignment: .bottom)
        
    }
}
