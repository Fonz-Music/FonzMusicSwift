////
////  SearchContentForPubs.swift
////  FonzMusicSwift
////
////  Created by didi on 10/25/21.
////
//
//import SwiftUI
//
//struct SearchContentForPubs: View {
//// ---------------------------------- inherited from parent -----------------------------------------
//
//    // hostCoaster details passed in and will update view when changed
//    @StateObject var hostCoaster:HostCoasterInfo
//    // checks if guest has a host
//    @Binding var hasHostVar : Bool
//    // determines if current user has an account
////    @Binding var hasAccount : Bool
////    // bool that determines if the user is connected to spot
////    @Binding var connectedToSpotify : Bool
//    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
//    @StateObject var userAttributes : CoreUserAttributes
//
//
//
//// ---------------------------------- created inside view -------------------------------------------
//
//    // track object inherited from song search
//    @StateObject var currentTune:GlobalTrack = GlobalTrack()
//    // object that stores the songs from the api
//    @StateObject var tracksFromSearch: TracksFromSearch = TracksFromSearch()
//    // object that stores the songs from the api
//    @StateObject var tracksFromPlaylist: TracksFromPlaylist = TracksFromPlaylist()
//    // object that stores the songs from the api
//    @StateObject var tracksFromArtist: TracksFromArtist = TracksFromArtist()
//    // object that stores the songs from the api
//    @StateObject var trackFromNowPlaying: TrackFromNowPlaying = TrackFromNowPlaying()
//    // object that stores the songs from the api
//    @StateObject var tracksFromTopSongs: TracksFromTopSongs = TracksFromTopSongs()
//    // object that stores the songs from the api
//    @StateObject var guestTopArtists: GuestTopArtists = GuestTopArtists()
//    // object that stores the songs from the api
//    @StateObject var guestTopPlaylists: GuestTopPlaylists = GuestTopPlaylists()
//
//    // boolean to change when views should be showed w animation
//    @State var showQueueResponse = false
//
//    // checks to see if currently typing in searchbar
//    @State var isEditingSearchBar = false
//
//
//    // init var that keeps status code
//    @State var statusCodeQueueSong = 0
//
//    @State var scale: CGFloat = 1
//    @Environment(\.colorScheme) var colorScheme
//
//        var body: some View {
//            // entire page is a scrollView
//
//                ScrollView(showsIndicators: false) {
//
//                    VStack {
//
////                        .simultaneousGesture(
////                            DragGesture().onChanged { value in
////                                hideKeyboard()
////                                withAnimation {
////                                    isEditingSearchBar = false
////                                }
////
////                            }
////                        )
//                        // search bar widget
//                        SearchBarView(tracksFromSearch: tracksFromSearch, isEditing: $isEditingSearchBar)
//                        ZStack {
//                            // now playing + song suggestions
//                            VStack{
////                                ActiveSongView(hostName: hostCoaster.hostName, currentSessionId: hostCoaster.sessionId, trackfromNowPlaying: trackFromNowPlaying)
//                                SongSuggestionsView(hostCoaster: hostCoaster, currentTune: currentTune, tracksFromPlaylist: tracksFromPlaylist, tracksFromArtist: tracksFromArtist, tracksFromTopSongs: tracksFromTopSongs, guestTopArtists: guestTopArtists, guestTopPlaylists: guestTopPlaylists, userAttributes: userAttributes, statusCodeQueueSong: $statusCodeQueueSong, showQueueResponse: $showQueueResponse)
//                                //                        #if !APPCLIP
//                                //                        Spacer()
//                                //                            .frame(height: 50)
//                                //                        #endif
//
//                            }
////                            .isHidden(hideSearchViews)
//                            .addOpacity(isEditingSearchBar)
//                            .simultaneousGesture(
//                                DragGesture().onChanged { value in
//                                    hideKeyboard()
//                                    withAnimation{
//                                        isEditingSearchBar = false
//                                    }
//
//                                }
//                            )
//
//                            // search results
//                            if isEditingSearchBar {
//                                VStack {
//                                    SearchResultsView(tracksFromSearch: tracksFromSearch, hostCoaster: hostCoaster, currentTune: currentTune,  isEditing: $isEditingSearchBar, statusCodeQueueSong: $statusCodeQueueSong, showQueueResponse: $showQueueResponse)
//                                    Spacer()
//                                }
//                            }
//
//                        }
//                        //                if pressedSongToLaunchNfc {
//                        //                    LaunchQueueSongNfcSessionSheet(tempCoaster: hostCoaster, songInfo: currentTune, statusCode: $statusCodeQueueSong, launchedNfc: $showQueueResponse, pressedButtonToLaunchNfc: $pressedSongToLaunchNfc)
//                        //                        .frame(width: 0, height: 0)
//                        //                }
//
//                    }
//                    .onAppear {
//                        // disables bounce
//                        UIScrollView.appearance().bounces = false
//                        // waits .5 seconds before showing views
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            withAnimation {
////                                hideSearchViews = false
//                            }
//                        }
//                    }
//                    .background(
//                        Color(.clear)
//                    )
//                }
//                .simultaneousGesture(
//                    DragGesture().onChanged { value in
//                        hideKeyboard()
//                    }
//                )
//
//
//    //        }
//
//
//        }
//    }
//
