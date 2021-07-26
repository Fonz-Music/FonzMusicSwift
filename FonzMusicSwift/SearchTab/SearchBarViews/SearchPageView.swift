//
//  SearchPageView.swift
//  FonzMusicSwift
//
//  Created by didi on 7/1/21.
//

import SwiftUI

struct SearchPageView: View {
// ---------------------------------- inherited from parent -----------------------------------------

    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // checks if guest has a host
    @Binding var hasHostVar : Bool
    // determines if current user has an account
    @Binding var hasAccount : Bool
    // bool that determines if the user is connected to spot
    @Binding var connectedToSpotify : Bool
    // boolean to change when views should be showed w animation
    @Binding var showQueueResponse : Bool
    // init var that keeps status code
    @Binding var statusCodeQueueSong : Int
    // checks to see if currently typing in searchbar
    @Binding var isEditingSearchBar : Bool
    
    // track object inherited from song search
    @Binding var currentTune:GlobalTrack
    
    
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
    @State var hideSearchViews = true
    // bool auto set to false, set to true if song is selected
    @State var pressedSongToLaunchNfc = false
    

    
    
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
                            .padding(.headingFrontIndent)
                            
                        Spacer()
                    }.padding(.top, .headingTopIndent)
                    HStack{
                        Spacer()
                        Button {
                            withAnimation {
                                hasHostVar = false
                            }
                        } label: {
                            Text("leave party")
                                .fonzParagraphTwo()
                                .padding(.headingFrontIndent)

                        }
                    }.padding(.top, .headingTopIndent)
                    
                    
                }
                .simultaneousGesture(
                    DragGesture().onChanged { value in
                        hideKeyboard()
                        withAnimation {
                            isEditingSearchBar = false
                        }
                        
                    }
                )
                // search bar widget
                SearchBarView(tracksFromSearch: tracksFromSearch, isEditing: $isEditingSearchBar)
                ZStack {
                    // now playing + song suggestions
                    VStack{
                        
                        ActiveSongView(hostName: hostCoaster.hostName, currentSessionId: hostCoaster.sessionId, trackfromNowPlaying: trackFromNowPlaying)
                        SongSuggestionsView(hostCoaster: hostCoaster, currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc, tracksFromPlaylist: tracksFromPlaylist, tracksFromArtist: tracksFromArtist, hasAccount: $hasAccount, connectedToSpotify: $connectedToSpotify)
                        #if !APPCLIP
                        Spacer()
                            .frame(height: 50)
                        #endif
                            
                    }
                    .isHidden(hideSearchViews)
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
                    LaunchQueueSongNfcSessionSheet(tempCoaster: hostCoaster, songInfo: currentTune, statusCode: $statusCodeQueueSong, launchedNfc: $showQueueResponse, pressedButtonToLaunchNfc: $pressedSongToLaunchNfc)
                        .frame(width: 0, height: 0)
                }
            
        }
        .onAppear {
            // disables bounce
            UIScrollView.appearance().bounces = false
//            // passes the sessionId from the host into the results return
//            print("sessionid os \(hostCoaster.sessionId)")
//            tracksFromSearch.tempSession = hostCoaster.sessionId
//            tracksFromPlaylist.tempSession = hostCoaster.sessionId
//            tracksFromArtist.tempSession = hostCoaster.sessionId
//            trackFromNowPlaying.tempSession = hostCoaster.sessionId
//            // launches now playing check
//            trackFromNowPlaying.nowPlaying = "mac"
            // waits .5 seconds before showing views
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    hideSearchViews = false
                }
            }
        }
    }
        .simultaneousGesture(
            DragGesture().onChanged { value in
                hideKeyboard()
//                withAnimation {
//                    isEditingSearchBar = false
//                }
                
            }
        )
    }
}

