//
//  YourTopSongs.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct YourTopSongs: View {
    
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // track object to update the song to queue
    @Binding var currentTune : GlobalTrack
    // bool that will launch nfc when pressed
    @Binding var pressedSongToLaunchNfc : Bool
    
    @State var connectedToSpotify : Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var yourTopSongs = [
        Track(songName: "Prune, You Talk Funny", songId: "6sHCvZe1PHrOAuYlwTLNH4", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ba8dea5129b6e43b59fadad7", spotifyUrl: "https://open.spotify.com/track/6sHCvZe1PHrOAuYlwTLNH4"),
        Track(songName: "Supalonely", songId: "0Cp8WN4V8Tu4QJQwCN5Md4", artistName: " BENEE", albumArt: "https://i.scdn.co/image/ab67616d0000b2734bd20e01d00de4b35b61f5f7", spotifyUrl: "https://open.spotify.com/track/0Cp8WN4V8Tu4QJQwCN5Md4"),
        Track(songName: "Post Humorous", songId: "0yb9DKhu0xA0h0qvKOHVwu", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b", spotifyUrl: "https://open.spotify.com/track/0yb9DKhu0xA0h0qvKOHVwu"),
        Track(songName: "I\'m Just Snacking", songId: "6413UUgINHbZsCJeJBFlmT", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b27303c5191d01d37d5c795697df", spotifyUrl: "https://open.spotify.com/track/6413UUgINHbZsCJeJBFlmT"),
        Track(songName: "Palms (with Channel Tres)", songId: "0Lskej1hiep1PKXoz7KhyO", artistName: " Gus Dapperton Channel Tres", albumArt: "https://i.scdn.co/image/ab67616d0000b273fd9c5111af2d35d22fb4a512", spotifyUrl: "https://open.spotify.com/track/0Lskej1hiep1PKXoz7KhyO"),
        Track(songName: "Somewhere (feat. Gus Dapperton)", songId: "0bmQ5H9mHFzRnJ4ZntylFg", artistName: " Surf Mesa Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ba3286704e1aec6a762ab144", spotifyUrl: "https://open.spotify.com/track/0bmQ5H9mHFzRnJ4ZntylFg"),
        Track(songName: "Medicine", songId: "7lLtAjBc4Fkaw0FkBQWlSX", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b", spotifyUrl: "https://open.spotify.com/track/7lLtAjBc4Fkaw0FkBQWlSX"),
        Track(songName: "I\'m On Fire", songId: "0lhcKPk0fppMAnFUt3QNy7", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ada32af03830941f2b510bd9", spotifyUrl: "https://open.spotify.com/track/0lhcKPk0fppMAnFUt3QNy7"),
        Track(songName: "Tom Sawyer", songId: "3QZ7uX97s82HFYSmQUAN1D", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/3QZ7uX97s82HFYSmQUAN1D"),
        Track(songName: "The Scientist", songId: "75JFxkI2RXiU7L9VXzMkle", artistName: " Coldplay", albumArt: "https://i.scdn.co/image/ab67616d0000b27390afd8e4ec6d787114ed6c40", spotifyUrl: "https://open.spotify.com/track/75JFxkI2RXiU7L9VXzMkle"),
        Track(songName: "Rush (feat. Jessie Reyez)", songId: "7tTRP2vA00uScZ4SjB3ZQZ", artistName: " Lewis Capaldi Jessie Reyez", albumArt: "https://i.scdn.co/image/ab67616d0000b273e8937101e6dc8ea504c6b546", spotifyUrl: "https://open.spotify.com/track/7tTRP2vA00uScZ4SjB3ZQZ"),
        Track(songName: "Limelight", songId: "0K6yUnIKNsFtfIpTgGtcHm", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
        
    ]
    
    var body: some View {
        VStack{
            HStack{
                Text(connectedToSpotify ? "your top songs" : "spotify top songs")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzParagraphTwo()
                    .padding(.horizontal, .subHeadingFrontIndent)
//                    .padding(.bottom, 10)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    HStack(spacing: 10) {
                        ForEach(0..<yourTopSongs.count / 2) {
                            TopSongButtonView(hostCoaster: hostCoaster, topSong: yourTopSongs[$0], currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
                                .padding(.top, 5)
                               
                        }
                    }
                    .padding(.bottom, 5)
                    
                    HStack(spacing: 10) {
                        ForEach(yourTopSongs.count / 2..<yourTopSongs.count) {
                       
                            TopSongButtonView(hostCoaster: hostCoaster, topSong: yourTopSongs[$0], currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
                                .padding(.bottom, 10)
                            
                                
                        }
                    }
                    
                }
                .padding(.horizontal, 5)
                
            }
            .padding(.horizontal, 10)
//            .padding(10)
//            VStack(spacing: 10) {
//                HStack(spacing: 10) {
//                    TopSongButtonView(hostCoaster: hostCoaster, topSong: yourTopSongs[0], currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
//                    TopSongButtonView(hostCoaster: hostCoaster, topSong: yourTopSongs[1], currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
//
//                }
//                HStack(spacing: 10) {
//                    TopSongButtonView(hostCoaster: hostCoaster, topSong: yourTopSongs[2], currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
//                    TopSongButtonView(hostCoaster: hostCoaster, topSong: yourTopSongs[3], currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
//                }
//            }
//            .frame(width: UIScreen.screenWidth * outerContainerFrameWidth)
            
            
        }
        .onAppear {
           connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
           
        }
        
    }
}


struct TopSongButtonView: View {
    
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // the song passed in
    let topSong: Track
    // track object to update the song to queue
    @Binding var currentTune : GlobalTrack
    // bool that will launch nfc when pressed
    @Binding var pressedSongToLaunchNfc : Bool
    
    
   
    
    @Environment(\.colorScheme) var colorScheme
    
  
    var body: some View {
        Button {
            currentTune.songId = topSong.songId
            currentTune.artistName = topSong.artistName
            currentTune.albumArt = topSong.albumArt
            currentTune.spotifyUrl = topSong.spotifyUrl
            currentTune.songName = topSong.songName
            pressedSongToLaunchNfc = true
    
            FirebaseAnalytics.Analytics.logEvent("guestSelectedTopSong", parameters: ["user":"guest", "tab":"search"])
        } label: {
            ZStack {
                HStack(spacing: 5) {
                    // album art
                    AsyncImage(url: URL(string: topSong.albumArt)!,
                               placeholder: { Text("...").fonzParagraphTwo() },
                                   image: { Image(uiImage: $0).resizable() })
                        .frame( width: 60 ,height: 60, alignment: .leading).cornerRadius(.cornerRadiusTasks)
                    // title & artist
                    VStack(alignment: .leading, spacing: 5) {
                        Text(verbatim: topSong.songName)
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzParagraphThree()
                        Text(verbatim: topSong.artistName.removeSpaceBefore())
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .font(Font.custom("MuseoSans-100", size: 10))
                            .fonzParagraphThree()
                    }
                    Spacer()
                }
            }
            .frame(height: 60)
            .animation(.easeIn)
        }
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
        .frame(width: UIScreen.screenWidth * 0.4, height: 60, alignment: .center)
        
    }
}


