//
//  SongSuggestionsView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI

struct SongSuggestionsView: View {
 
// ---------------------------------- inherited from parent -----------------------------------------
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // track object to update the song to queue
    @StateObject var currentTune : GlobalTrack
    // bool that will launch nfc when pressed
    @Binding var pressedSongToLaunchNfc : Bool
    // object that stores the songs from the api
    @ObservedObject var tracksFromPlaylist: TracksFromPlaylist
    // object that stores the songs from the api
    @ObservedObject var tracksFromArtist: TracksFromArtist
    // object that stores the songs from the api
    @ObservedObject var tracksFromTopSongs: TracksFromTopSongs
    // object that stores the songs from the api
    @ObservedObject var guestTopArtists: GuestTopArtists
    
    @ObservedObject var guestTopPlaylists: GuestTopPlaylists
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
// ---------------------------------- created in view -----------------------------------------------
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: .cornerRadiusBlocks)
                
                .fill(colorScheme == .light ? Color.white: Color.darkBackground)
                .frame(height: determineSongSugsSize(), alignment: .center)
//                .frame(width: UIScreen.screenWidth * 0.95, height: 900, alignment: .center)
                .fonzShadow()
                .padding(.top, 30)
            VStack{
                Spacer()
                    .frame(height: 30)
                // if the user doesnt have spotify connected, show spot button
                if !userAttributes.getHasAccount() || !userAttributes.getConnectedToSpotify() {
                    ConnectSpotifySearch(userAttributes: userAttributes)
                    Spacer()
                        .frame(height: 30)
                }
                YourTopSongs(hostCoaster: hostCoaster, currentTune: currentTune, tracksFromTopSongs: tracksFromTopSongs, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
                YourTopArtists(hostCoaster: hostCoaster, tracksFromArtist: tracksFromArtist, guestTopArtists: guestTopArtists)
                YourTopPlaylists(hostCoaster: hostCoaster,  tracksFromPlaylist: tracksFromPlaylist, guestTopPlaylists: guestTopPlaylists)
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
            return 850.0
            #else
            return 820.0
            #endif
            
        }
        else {
            #if !APPCLIP
            return 890.0
            #else
            return 840.0
            #endif
            
        }
    }
}

