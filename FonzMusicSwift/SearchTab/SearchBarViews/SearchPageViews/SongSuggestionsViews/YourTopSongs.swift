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
    
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var yourTopSongs = [
        Track(songName: "Tom Sawyer", songId: "3QZ7uX97s82HFYSmQUAN1D", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/3QZ7uX97s82HFYSmQUAN1D"),
        Track(songName: "The Scientist", songId: "75JFxkI2RXiU7L9VXzMkle", artistName: " Coldplay", albumArt: "https://i.scdn.co/image/ab67616d0000b27390afd8e4ec6d787114ed6c40", spotifyUrl: "https://open.spotify.com/track/75JFxkI2RXiU7L9VXzMkle"),
        Track(songName: "Rush (feat. Jessie Reyez)", songId: "7tTRP2vA00uScZ4SjB3ZQZ", artistName: " Lewis Capaldi Jessie Reyez", albumArt: "https://i.scdn.co/image/ab67616d0000b273e8937101e6dc8ea504c6b546", spotifyUrl: "https://open.spotify.com/track/7tTRP2vA00uScZ4SjB3ZQZ"),
        Track(songName: "Limelight", songId: "0K6yUnIKNsFtfIpTgGtcHm", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm")
    ]
    
    var body: some View {
        VStack{
            Text("your top songs")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzParagraphTwo()
                .padding(25)
                .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    TopSongButtonView(hostCoaster: hostCoaster, topSong: yourTopSongs[0], currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
                    TopSongButtonView(hostCoaster: hostCoaster, topSong: yourTopSongs[1], currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)

                }
                HStack(spacing: 10) {
                    TopSongButtonView(hostCoaster: hostCoaster, topSong: yourTopSongs[2], currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
                    TopSongButtonView(hostCoaster: hostCoaster, topSong: yourTopSongs[3], currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc)
                    

                }
            }
            .padding()
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
                        Text(verbatim: topSong.artistName)
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
    }
}


