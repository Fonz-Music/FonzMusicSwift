//
//  SongSuggestionsView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI

struct SongSuggestionsView: View {
    
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // track object to update the song to queue
    @Binding var currentTune : GlobalTrack
    // bool that will launch nfc when pressed
    @Binding var pressedSongToLaunchNfc : Bool
    // object that stores the songs from the api
    @ObservedObject var tracksFromPlaylist: TracksFromPlaylist
    // object that stores the songs from the api
    @ObservedObject var tracksFromArtist: TracksFromArtist
    // determines if current user has an account
    @Binding var hasAccount : Bool
    
    @Binding var connectedToSpotify : Bool
    
    
    
    @State var throwCreateAccountModal = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: .cornerRadiusBlocks)
                .fill(colorScheme == .light ? Color.white: Color.darkBackground)
                .frame(height: 900, alignment: .center)
                .fonzShadow()
                .padding(.top, 30)
            VStack{
                
                if !hasAccount || !connectedToSpotify {
                    Spacer()
                        .frame(height: 30)
                    ConnectSpotifySearch(throwCreateAccountModal: $throwCreateAccountModal, hasAccount: $hasAccount, connectedToSpotify: $connectedToSpotify)
                }
                YourTopSongs(hostCoaster: hostCoaster, currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
                YourFavoriteArtists(hostCoaster: hostCoaster,  tracksFromArtist: tracksFromArtist)
                YourTopPlaylists(hostCoaster: hostCoaster,  tracksFromPlaylist: tracksFromPlaylist)
                Spacer()
                    .frame(height: 30)
            }
            .padding(.top, 30)
            .sheet(isPresented: $throwCreateAccountModal) {
                    CreateAccountPrompt(hasAccount: $hasAccount, showModal: $throwCreateAccountModal)
               
            }
        }
    }
}

