//
//  ActiveSongView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI

struct ActiveSongView: View {
    
    @Binding var hostName : String
    @State var activeSongPlace: Double = 1.32
    @State var activeSongLength: Double = 4.00
    
    @State var activeSong : Track = Track(songName: "Rush Hour", songId: "09VACB0akCnPueTFnjN5Pn", artistName: "Mac Miller", albumArt: "https://i.scdn.co/image/ab67616d0000b273ee0f38410382a255e4fb15f4", spotifyUrl: "https://open.spotify.com/track/09VACB0akCnPueTFnjN5Pn")
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("now playing")
                .foregroundColor(Color.white)
                .fonzParagraphTwo()
                .padding(25)
                .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
//            Button {
//                print("pressed me")
//            } label: {
                ZStack {
                    VStack{
                        HStack(spacing: 5) {
                            // album art
                            AsyncImage(url: URL(string: activeSong.albumArt)!,
                                       placeholder: { Text("...").fonzParagraphTwo() },
                                           image: { Image(uiImage: $0).resizable() })
                                .frame( width: 80 ,height: 80, alignment: .leading).cornerRadius(5)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 15)
                            // title & artist
                            VStack(alignment: .leading, spacing: 5) {
                        
                                Text(verbatim: activeSong.songName)
                                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                                    .fonzParagraphOne()
                                Text(verbatim: activeSong.artistName)
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
                    RoundedRectangle(cornerRadius: 10)
                    .fill(colorScheme == .light ? Color.white: Color.darkButton)
//                        .padding(.vertical, 10)
                    .frame(width: UIScreen.screenWidth * 0.9, height: 150, alignment: .center)
                )
//            }
            .frame(width: UIScreen.screenWidth * 0.9, alignment: .center)
//            .buttonStyle(NeumorphicButtonStyle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))

            
           
           
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
            }.cornerRadius(10.0)
        }
}
