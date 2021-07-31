//
//  ActiveSongView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct ActiveSongView: View {

    var hostName : String
    var currentSessionId : String
    // object that stores the songs from the api
    @ObservedObject var trackfromNowPlaying: TrackFromNowPlaying
    
    @State var activeSongPlace: Double = 1.32
    @State var activeSongLength: Double = 4.00
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            HStack{
                Text("now playing")
                    .foregroundColor(Color.white)
                    .fonzParagraphTwo()
                    .padding(.horizontal, .subHeadingFrontIndent)
                    .padding(.vertical, 15)
                Spacer()
            }
            Button {
//                reloadSong = trackfromNowPlaying.reloadSong()
                trackfromNowPlaying.resetImage()
                trackfromNowPlaying.getActiveSong(sessionId: currentSessionId)
                FirebaseAnalytics.Analytics.logEvent("guestReloadedActiveSong", parameters: ["user":"guest"])
            } label: {
                ActiveSongUserInterface(trackfromNowPlaying: trackfromNowPlaying,  hostName: hostName)
                .onAppear{
                    print(trackfromNowPlaying.currentSong[0].albumArt)
                    print(trackfromNowPlaying.currentSong[0].trackName)
                    print(trackfromNowPlaying.currentSong[0].artistName)
                   
                }
            }
            .padding(.horizontal, .subHeadingFrontIndent)
            .frame(width: UIScreen.screenWidth, height: 140, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                    .fill(colorScheme == .light ? Color.white: Color.darkButton)
                    .padding(.horizontal, .subHeadingFrontIndent)
                    .frame(width: UIScreen.screenWidth, height: 140, alignment: .center)
                    .fonzShadow()
                    
            )
            
//            .frame(width: UIScreen.screenWidth, alignment: .center)
//            .padding(.horizontal, 10)
            .onAppear {
                print("this is the active song img \(trackfromNowPlaying.currentSong[0].albumArt)")
                trackfromNowPlaying.getActiveSong(sessionId: currentSessionId)
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


