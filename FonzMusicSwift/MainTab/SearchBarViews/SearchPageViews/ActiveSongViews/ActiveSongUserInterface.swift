//
//  ActiveSongUserInterface.swift
//  FonzMusicSwift
//
//  Created by didi on 7/28/21.
//

import SwiftUI

struct ActiveSongUserInterface : View {
    
    @Environment(\.colorScheme) var colorScheme
//    @Binding var activeSong : Track
    // object that stores the songs from the api
    @StateObject var trackfromNowPlaying: TrackFromNowPlaying
    
   
    
//    @ObservedObject var currentImage : ImageLoader
    
    var hostName : String
    
    @State var activeSongPlace: Double = 1.32
    @State var activeSongLength: Double = 4.00
    
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                HStack(spacing: 5) {
                    // album art
                    //                                    activeSong.albumArt
//                    AsyncImage(url: (URL(string:activeSong.albumArt))!,
//                               placeholder: { Text("...").fonzParagraphTwo() },
//                               image: { Image(uiImage: $0).resizable() })
                    if (trackfromNowPlaying.currentSong[0].albumArt == "") {
                        HStack{
                            Spacer()
                            Image("spotifyIconAmber")
                            Spacer()
                        }
                        .frame( width: 80 ,height: 80, alignment: .leading)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                    }
                    else {
                        AsyncImage(url: (URL(string:trackfromNowPlaying.currentSong[0].albumArt))!,
                            placeholder: {
                                HStack{
                                    Spacer()
                                    Image("spotifyIconAmber")
                                    Spacer()
                                }
                            },
                            image: { Image(uiImage: $0).resizable() }
                        )
                        
                        .frame( width: 100 ,height: 100, alignment: .leading)
                        .cornerRadius(.cornerRadiusTasks)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                    }
                    
                    // title & artist
                    VStack(alignment: .leading, spacing: 5) {
                        if (trackfromNowPlaying.currentSong[0].trackName != ""){
                            Text(verbatim: trackfromNowPlaying.currentSong[0].trackName)
                                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                .fonzParagraphOne()
                                .lineLimit(2)
                                
                                .allowsTightening(true)
                            Text(verbatim: trackfromNowPlaying.currentSong[0].artistName)
                                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                                .fonzParagraphTwo()
                            Text("\(hostName)'s Fonz")
                                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                                .fonzParagraphThree()
                        }
                        else {
                            Text("\(hostName) is not currently playing Spotify")
                                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                .fonzParagraphTwo()
                        }
                        
                    }
                    Spacer()
                    
                }
//                .padding(.top, 5)
                Spacer()
            }
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
