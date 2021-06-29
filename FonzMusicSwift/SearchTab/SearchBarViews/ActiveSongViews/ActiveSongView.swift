//
//  ActiveSongView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI

struct ActiveSongView: View {
    
    
    
    var hostName : String
    var currentSessionId : String
    // object that stores the songs from the api
    @ObservedObject var trackfromNowPlaying: TrackFromNowPlaying
    
    @State var activeSongPlace: Double = 1.32
    @State var activeSongLength: Double = 4.00
    
//    @ObservedObject var activeSong : Track = Track(songName: "Rush Hour", songId: "09VACB0akCnPueTFnjN5Pn", artistName: "Mac Miller", albumArt: "https://i.scdn.co/image/ab67616d0000b273ee0f38410382a255e4fb15f4", spotifyUrl: "https://open.spotify.com/track/09VACB0akCnPueTFnjN5Pn")
    
//    @Binding var activeSong : Track
    
//    @ObservedObject var currentImage = ImageLoader(url: URL(string: "https://i.scdn.co/image/ab67616d0000b273ee0f38410382a255e4fb15f4")!)
    
    
    var body: some View {
        VStack {
            Text("now playing")
                .foregroundColor(Color.white)
                .fonzParagraphTwo()
                .padding(25)
                .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
            Button {
//                print(trackfromNowPlaying.currentSong)
//                print(trackfromNowPlaying.nowPlaying)
                trackfromNowPlaying.getActiveSong(sessionId: currentSessionId)
            
            } label: {
                ActiveSongUserInterface(trackfromNowPlaying: trackfromNowPlaying,  hostName: hostName)
                .onAppear{
                    print(trackfromNowPlaying.currentSong[0].albumArt)
                    print(trackfromNowPlaying.currentSong[0].trackName)
                    print(trackfromNowPlaying.currentSong[0].artistName)
                   
                }
            }
            .frame(width: UIScreen.screenWidth * 0.9, alignment: .center)
        }
    }
    
    func convertSongPositionToString(songPosition : Double) -> String {
        // make double only 2 decimals
        let twoDecimals = Double(round(100*songPosition)/100)
        // creates a string
        var newSongString = String(twoDecimals)
        // replaces all periods w colons for time
        newSongString = newSongString.replacingOccurrences(of: ".", with: ":")
        // creates a sub string of the seconds
        let substring = newSongString.split(separator: ":")
        // if the seconds is 1 digit, adds a zero so time is 4:00 & not 4:0
        if (substring[1].count < 2) {
            newSongString = newSongString + "0"
        }
         
        return newSongString
    }
}

struct ProgressBar: View {
    @Binding var value: Double
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        let progressLength = ((CGFloat(self.value) / 10 ) * (UIScreen.screenWidth * 0.6))
        
            ZStack(alignment: .leading) {
                // background bar
                Rectangle().frame(width: UIScreen.screenWidth * 0.6, height: 5)
                    .opacity(0.3)
                    .foregroundColor(colorScheme == .light ? Color.gray: Color.white)
                // active bar
                Rectangle().frame(width: progressLength, height: 5)
                    .foregroundColor(.lilac)
                    .animation(.linear)
            }.cornerRadius(.cornerRadiusTasks)
        }
}

struct ActiveSongUserInterface : View {
    
    @Environment(\.colorScheme) var colorScheme
//    @Binding var activeSong : Track
    // object that stores the songs from the api
    @ObservedObject var trackfromNowPlaying: TrackFromNowPlaying
    
//    @ObservedObject var currentImage : ImageLoader
    
    var hostName : String
    
    @State var activeSongPlace: Double = 1.32
    @State var activeSongLength: Double = 4.00
    
    var body: some View {
        ZStack {
            VStack{
                HStack(spacing: 5) {
                    // album art
                    //                                    activeSong.albumArt
//                    AsyncImage(url: (URL(string:activeSong.albumArt))!,
//                               placeholder: { Text("...").fonzParagraphTwo() },
//                               image: { Image(uiImage: $0).resizable() })
                    AsyncImage(url: (URL(string:trackfromNowPlaying.currentSong[0].albumArt))!,
                               placeholder: { Text("...").fonzParagraphTwo() },
                               image: { Image(uiImage: $0).resizable() })
//                    AsyncImage(url: currentImage.url,
//                               placeholder: { Text("...").fonzParagraphTwo() },
//                               image: { Image(uiImage: $0).resizable() })
                        .frame( width: 80 ,height: 80, alignment: .leading).cornerRadius(.cornerRadiusTasks)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                    // title & artist
                    VStack(alignment: .leading, spacing: 5) {
                
//                        Text(verbatim: activeSong.songName)
                                Text(verbatim: trackfromNowPlaying.currentSong[0].trackName)
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzParagraphOne()
//                        Text(verbatim: activeSong.artistName)
                                Text(verbatim: trackfromNowPlaying.currentSong[0].artistName)
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzParagraphTwo()
                        Text("playing on \(hostName)'s Fonz")
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzParagraphThree()
                    }
                    Spacer()
                }
                .padding(.top, 5)
                HStack(spacing: 5){
                    Text("\(convertSongPositionToString(songPosition: activeSongPlace))")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphThree()
                    ProgressBar(value: $activeSongPlace)
                    Text("\(convertSongPositionToString(songPosition: activeSongLength))")
                        .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                        .fonzParagraphThree()
                }.padding(.vertical, 3)
                Spacer()
            }
        }
        
        .background(
            RoundedRectangle(cornerRadius: .cornerRadiusTasks)
            .fill(colorScheme == .light ? Color.white: Color.darkButton)
//                        .padding(.vertical, 10)
            .frame(width: UIScreen.screenWidth * 0.9, height: 150, alignment: .center)
                .fonzShadow()
                
        )
    }
    func convertSongPositionToString(songPosition : Double) -> String {
        // make double only 2 decimals
        let twoDecimals = Double(round(100*songPosition)/100)
        // creates a string
        var newSongString = String(twoDecimals)
        // replaces all periods w colons for time
        newSongString = newSongString.replacingOccurrences(of: ".", with: ":")
        // creates a sub string of the seconds
        let substring = newSongString.split(separator: ":")
        // if the seconds is 1 digit, adds a zero so time is 4:00 & not 4:0
        if (substring[1].count < 2) {
            newSongString = newSongString + "0"
        }
         
        return newSongString
    }
}
