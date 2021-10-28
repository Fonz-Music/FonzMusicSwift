//
//  SongSuggestionsView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI
import UIKit
import MessageUI

struct SongSuggestionsView: View {
 
// ---------------------------------- inherited from parent -----------------------------------------
    // hostCoaster details passed in and will update view when changed
    @StateObject var hostCoaster:HostCoasterInfo
    // track object to update the song to queue
    @StateObject var currentTune : GlobalTrack
    // object that stores the songs from the api
    @StateObject var tracksFromPlaylist: TracksFromPlaylist
    // object that stores the songs from the api
    @StateObject var tracksFromArtist: TracksFromArtist
    // object that stores the songs from the api
    @StateObject var tracksFromTopSongs: TracksFromTopSongs
    // object that stores the songs from the api
    @StateObject var guestTopArtists: GuestTopArtists

    @StateObject var guestTopPlaylists: GuestTopPlaylists
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    // statusCode from queueing song
    @Binding var statusCodeQueueSong : Int
    // boolean to change when views should be showed w animation
    @Binding var showQueueResponse : Bool
    
// ---------------------------------- created in view -----------------------------------------------
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: .cornerRadiusBlocks)
//                .background(
//                    ZStack{
//                        VStack{
//        //                        Spacer()
//                            Image("newColorfulBg")
//        //                            .opacity(0.4)
//                                .frame(width: UIScreen.screenWidth)
//                        }
//
//                    }, alignment: .top)
                .fill(colorScheme == .light ? Color.white: Color.darkBackground)
//                .foregroundColor(.lilac)
//                .foregroundColor(.clear)
                .frame(height: determineSongSugsSize(), alignment: .center)
//                .frame(width: UIScreen.screenWidth * 0.95, height: 900, alignment: .center)
                .fonzShadow()
                .padding(.top, 30)
            
                
            VStack{
                Spacer()
                    .frame(height: 30)
                // if the user doesnt have spotify connected, show spot button
                if !userAttributes.getConnectedToSpotify() {
                    ConnectSpotifySearch(userAttributes: userAttributes)
                    Spacer()
                        .frame(height: 30)
                }
                else {
                    Spacer()
                        .frame(height: 0)
                        .onAppear {
                            if userAttributes.updateUserTops {
                                print("grabbing new tops")
//                                tracksFromTopSongs.loadTracksAfterSpotConnect()
//                                guestTopArtists.loadTopArtistsAfterSpotSignIn()
//                                guestTopPlaylists.loadTopPlaylistsAfterSpotSignIn()
                                
                                
                                userAttributes.updateUserTops = false
                            }
                            else {
                                print("not grabbing new tops")
                            }
                        }
                }
                YourTopSongs(hostCoaster: hostCoaster, currentTune: currentTune, tracksFromTopSongs: tracksFromTopSongs,  statusCodeQueueSong: $statusCodeQueueSong, showQueueResponse: $showQueueResponse)
//                YourTopSongs(hostCoaster: hostCoaster, currentTune: currentTune, statusCodeQueueSong: $statusCodeQueueSong, showQueueResponse: $showQueueResponse)
                YourTopArtists(hostCoaster: hostCoaster, tracksFromArtist: tracksFromArtist, userAttributes: userAttributes, guestTopArtists: guestTopArtists)
                YourTopPlaylists(hostCoaster: hostCoaster,  tracksFromPlaylist: tracksFromPlaylist, guestTopPlaylists: guestTopPlaylists, userAttributes: userAttributes)
                Spacer()
                    .frame(height: 20)
                // if the user can send mail & the user has an account
                if MFMailComposeViewController.canSendMail() && !userAttributes.getHasAccount() {
                    SendDevFeedback(widthInherited: .outerContainerFrameWidthSettings, userAttributes: userAttributes)
                }
                #if !APPCLIP
                Spacer()
                    .frame(minHeight: 50)
                #else
                Spacer()
                #endif
            }
            
            .padding(.top, 30)
            .frame(width: UIScreen.screenWidth * 0.95)
            
        }
        
    }
    
    func determineSongSugsSize() -> CGFloat {
        if userAttributes.getConnectedToSpotify() {
            #if !APPCLIP
            return 880.0
            #else
            return 850.0
            #endif
            
        }
        else {
            #if !APPCLIP
            if MFMailComposeViewController.canSendMail() && !userAttributes.getHasAccount() {
                return 960.0
            }
            else {
                return 940.0
            }
            
            #else
            return 870.0
            #endif
            
        }
    }
}

