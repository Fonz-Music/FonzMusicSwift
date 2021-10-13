////
////  SearchPageView.swift
////  FonzMusicSwift
////
////  Created by didi on 7/1/21.
////
//
//import SwiftUI
//
//@available(iOS 15.0, *)
//struct SearchPageView15: View {
//// ---------------------------------- inherited from parent -----------------------------------------
//
//    // hostCoaster details passed in and will update view when changed
//    @ObservedObject var hostCoaster:HostCoasterInfo
//    // checks if guest has a host
//    @Binding var hasHostVar : Bool
//    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
//    @StateObject var userAttributes : CoreUserAttributes
//    // boolean to change when views should be showed w animation
//    @Binding var showQueueResponse : Bool
//    // init var that keeps status code
//    @Binding var statusCodeQueueSong : Int
//    // checks to see if currently typing in searchbar
//    @Binding var isEditingSearchBar : Bool
//    // track object inherited from song search
//    @StateObject var currentTune:GlobalTrack
//
//
//// ---------------------------------- created inside view -------------------------------------------
//    // object that stores the songs from the api
//    @ObservedObject var tracksFromSearch: TracksFromSearch
//    // object that stores the songs from the api
//    @ObservedObject var tracksFromPlaylist:  TracksFromPlaylist
//    // object that stores the songs from the api
//    @ObservedObject var tracksFromArtist: TracksFromArtist
//    // object that stores the songs from the api
//    @ObservedObject var trackFromNowPlaying: TrackFromNowPlaying
//    // object that stores the songs from the api
//    @ObservedObject var tracksFromTopSongs: TracksFromTopSongs
//    // object that stores the songs from the api
//    @ObservedObject var guestTopArtists: GuestTopArtists
//
//    @ObservedObject var guestTopPlaylists: GuestTopPlaylists
//
//    @State var scale: CGFloat = 1
//    @Environment(\.colorScheme) var colorScheme
//
//    // boolean to change when views should be showed w animation
//    @State var hideSearchViews = true
//    // bool auto set to false, set to true if song is selected
//    @State var pressedSongToLaunchNfc = false
//
//    var body: some View {
//        // entire page is a scrollView
//        if #available(iOS 15.0, *) {
//            ScrollView(showsIndicators: false) {
//
//                VStack {
//                    // top search headar & quit part button
//                    ZStack {
//                        HStack{
//                            Text("search")
//                                .foregroundColor(Color.white)
//                                .fonzParagraphOne()
//                                .padding(.headingFrontIndent)
//
//                            Spacer()
//                        }.padding(.top, .headingTopIndent)
//                        HStack{
//                            Spacer()
//                            Button {
//                                withAnimation {
//                                    hasHostVar = false
//                                }
//                                var userSessionId : String = UserDefaults.standard.string(forKey: "userAccountSessionId") ?? ""
//                                var hostSessionId : String = UserDefaults.standard.string(forKey: "hostSessionId") ?? ""
//                                print("user sess is " + userSessionId)
//                            } label: {
//                                Image(systemName: "arrow.up.and.person.rectangle.portrait")
//                                //                            Image("leaveParty")
//                                    .resizable()
//                                    .frame(width: 20, height: 17, alignment: .center)
//                                //                                .foregroundColor(.white)
//                                    .foregroundColor(colorScheme == .light ? Color.gray: Color.white)
//
//                                    .padding(10)
//
//                            }
//                            .buttonStyle(BasicFonzButtonCircleNoBorder(bgColor: colorScheme == .light ? Color.white: Color.darkBackground, secondaryColor: .amber))
//                            //                        .buttonStyle(BasicFonzButtonCircleNoBorder(bgColor: Color.white, secondaryColor: .amber))
//                            .padding(.headingFrontIndent)
//                        }.padding(.top, .headingTopIndent)
//
//
//                    }
//                    .simultaneousGesture(
//                        DragGesture().onChanged { value in
//                            hideKeyboard()
//                            withAnimation {
//                                isEditingSearchBar = false
//                            }
//
//                        }
//                    )
//                    // search bar widget
//                    SearchBarView(tracksFromSearch: tracksFromSearch, isEditing: $isEditingSearchBar)
//                    ZStack {
//                        // now playing + song suggestions
//                        VStack{
//                            ActiveSongView(hostName: hostCoaster.hostName, currentSessionId: hostCoaster.sessionId, trackfromNowPlaying: trackFromNowPlaying)
//                            SongSuggestionsView(hostCoaster: hostCoaster, currentTune: currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc, tracksFromPlaylist: tracksFromPlaylist, tracksFromArtist: tracksFromArtist, tracksFromTopSongs: tracksFromTopSongs, guestTopArtists: guestTopArtists, guestTopPlaylists: guestTopPlaylists, userAttributes: userAttributes, statusCodeQueueSong: $statusCodeQueueSong, showQueueResponse: $showQueueResponse)
//                            //                        #if !APPCLIP
//                            //                        Spacer()
//                            //                            .frame(height: 50)
//                            //                        #endif
//
//                        }
//                        .isHidden(hideSearchViews)
//                        .addOpacity(isEditingSearchBar)
//                        .simultaneousGesture(
//                            DragGesture().onChanged { value in
//                                hideKeyboard()
//                                withAnimation{
//                                    isEditingSearchBar = false
//                                }
//
//                            }
//                        )
//
//                        // search results
//                        if isEditingSearchBar {
//                            VStack {
//                                SearchResultsView(tracksFromSearch: tracksFromSearch, hostCoaster: hostCoaster, currentTune: currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc, isEditing: $isEditingSearchBar, statusCodeQueueSong: $statusCodeQueueSong, showQueueResponse: $showQueueResponse)
//                                Spacer()
//                            }
//                        }
//
//                    }
//                    //                if pressedSongToLaunchNfc {
//                    //                    LaunchQueueSongNfcSessionSheet(tempCoaster: hostCoaster, songInfo: currentTune, statusCode: $statusCodeQueueSong, launchedNfc: $showQueueResponse, pressedButtonToLaunchNfc: $pressedSongToLaunchNfc)
//                    //                        .frame(width: 0, height: 0)
//                    //                }
//
//                }
//                .onAppear {
//                    // disables bounce
//                    UIScrollView.appearance().bounces = false
//                    // waits .5 seconds before showing views
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        withAnimation {
//                            hideSearchViews = false
//                        }
//                    }
//                }
//            }
//            .refreshable {
//                trackFromNowPlaying.resetImage()
//                trackFromNowPlaying.getActiveSong(sessionId: hostCoaster.sessionId)
//            }
//            .simultaneousGesture(
//                DragGesture().onChanged { value in
//                    hideKeyboard()
//
//                }
//            )
//            //        if #available(iOS 15.0, *) {
//
//        } else {
//            // Fallback on earlier versions
//            Text("hey")
//        }
////        }
//
//
//    }
//}
//
