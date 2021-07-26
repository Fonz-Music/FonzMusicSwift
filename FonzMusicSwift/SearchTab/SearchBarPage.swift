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
    // bool that determines if the user is connected to spot
    @Binding var connectedToSpotify : Bool
    // track object inherited from song search
    @State var currentTune:GlobalTrack = GlobalTrack()
    
    
// ---------------------------------- created inside view -------------------------------------------
   
    
    // boolean to change when views should be showed w animation
    @State var showQueueResponse = false
    
    // checks to see if currently typing in searchbar
    @State var isEditingSearchBar = false
   

    // init var that keeps status code
    @State var statusCodeQueueSong = 0
    
    
    
    var body: some View {
        ZStack {
           // song page 
            SearchPageView(hostCoaster: hostCoaster, hasHostVar: $hasHostVar, hasAccount: $hasAccount, connectedToSpotify: $connectedToSpotify, showQueueResponse: $showQueueResponse, statusCodeQueueSong: $statusCodeQueueSong, isEditingSearchBar: $isEditingSearchBar, currentTune: $currentTune)
                
//                .padding(.horizontal, 30)
   
            // resps
            LaunchSongResponsePopup(statusCodeQueueSong: statusCodeQueueSong, showQueueResponse: $showQueueResponse, songSelected: currentTune.songName, currentHost: hostCoaster.hostName)
                .padding(.horizontal)
                .padding(.top, 30)
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
//                    .darkenView(isEditingSearchBar)
                VStack{
                    Spacer()
                    Image("mountainProfile")
                        .opacity(0.4)
                        .frame(maxWidth: UIScreen.screenWidth)
                }
            }, alignment: .bottom)
    }
}
