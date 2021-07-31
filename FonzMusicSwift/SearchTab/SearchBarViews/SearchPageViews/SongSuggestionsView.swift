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
//    @Binding var hasAccount : Bool
//    // determines if current user is connected to Spotify
//    @Binding var connectedToSpotify : Bool
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    
    @State var throwCreateAccountModal = false
    
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
//                if !connectedToSpotify {
//                    Spacer()
//                        .frame(height: 20)
//                }
//                else {
//                    Spacer()
//                        .frame(height: 40)
//                }
                Spacer()
                    .frame(height: 20)
                
                if !userAttributes.getHasAccount() || !userAttributes.getConnectedToSpotify() {
                    
                    ConnectSpotifySearch(throwCreateAccountModal: $throwCreateAccountModal, userAttributes: userAttributes)
                }
                YourTopSongs(hostCoaster: hostCoaster, currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
                YourTopArtists(hostCoaster: hostCoaster,  tracksFromArtist: tracksFromArtist)
                YourTopPlaylists(hostCoaster: hostCoaster,  tracksFromPlaylist: tracksFromPlaylist)
                Spacer()
                    .frame(minHeight: 50)
            }
            .padding(.top, 30)
            .frame(width: UIScreen.screenWidth * 0.95)
            .sheet(isPresented: $throwCreateAccountModal) {
                CreateAccountPrompt(userAttributes: userAttributes, showModal: $throwCreateAccountModal)
               
            }
        }
    }
    
    func determineSongSugsSize() -> CGFloat {
        if userAttributes.getConnectedToSpotify() {
            return 850.0
        }
        else {
            return 910.0
        }
    }
}

