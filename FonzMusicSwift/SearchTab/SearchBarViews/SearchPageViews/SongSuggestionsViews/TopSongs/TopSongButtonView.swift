//
//  TopSongButtonView.swift
//  FonzMusicSwift
//
//  Created by didi on 7/31/21.
//

import SwiftUI
import FirebaseAnalytics
import Firebase

struct TopSongButtonView: View {
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // the song passed in
    let topSong: Track
    // track object to update the song to queue
    @StateObject var currentTune : GlobalTrack
    // bool that will launch nfc when pressed
    @Binding var pressedSongToLaunchNfc : Bool
    
    // statusCode from queueing song
    @Binding var statusCodeQueueSong : Int
    // boolean to change when views should be showed w animation
    @Binding var showQueueResponse : Bool
    
    @Environment(\.colorScheme) var colorScheme
    
  
    var body: some View {
        Button {
            withAnimation{
                showQueueResponse = true
//                statusCodeQueueSong =
            }
            DispatchQueue.main.async {
            
                currentTune.songId = topSong.songId
                currentTune.artistName = topSong.artistName
                currentTune.albumArt = topSong.albumArt
                currentTune.spotifyUrl = topSong.spotifyUrl
                currentTune.songName = topSong.songName
                if (currentTune.songId != "") {
                    withAnimation{
//                        showQueueResponse = true
                        statusCodeQueueSong = GuestApi().queueSong(sessionId: hostCoaster.sessionId, trackId: currentTune.songId)
                    }
                }
                Analytics.logEvent("guestSelectedTopSong", parameters: ["user":"guest", "tab":"search"])
//                FirebaseAnalytics.Analytics.logEvent("guestSelectedTopSong", parameters: ["user":"guest", "tab":"search"])
            }
                
//            }

//            pressedSongToLaunchNfc = true
           
//            FirebaseAnalytics.Analytics.logEvent("guestSelectedTopSong", parameters: ["user":"guest", "tab":"search"])
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
        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
        .frame(width: UIScreen.screenWidth * 0.4, height: 60, alignment: .center)
        
    }
}

