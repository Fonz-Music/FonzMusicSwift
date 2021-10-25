//
//  PavCoreContent.swift
//  FonzMusicSwift
//
//  Created by didi on 10/25/21.
//

import SwiftUI

struct PavCoreContent: View {
    // hostCoaster details passed in and will update view when changed
    @StateObject var hostCoaster:HostCoasterInfo
    // checks if guest has a host
    @Binding var hasHostVar : Bool
    
    
    // object that stores the songs from the api
    @ObservedObject var trackFromNowPlaying: TrackFromNowPlaying = TrackFromNowPlaying()
    
    // gets dark/light mode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack{
            PavHeader(hasHostVar: $hasHostVar)
            Button {
                print("pressed")
            } label: {
                HStack{
                    Image("pavPic")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .padding(10)
                    Text("Menu")
                        .foregroundColor(.darkButton)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .fonzParagraphOne()
                        .lineLimit(2)
                    Spacer()
                }
            }
            .background(
                RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                    .fill(.white)
                    .padding(.horizontal, .subHeadingFrontIndent)
                    .frame(width: UIScreen.screenWidth, height: 200, alignment: .center)
                    .fonzShadow()
            )
            .padding(40)
            Spacer()
                .frame(height: 40)
            ActiveSongUserInterface( trackfromNowPlaying: trackFromNowPlaying,
                hostName: hostCoaster.hostName)
                .padding(.subHeadingFrontIndent)
                .frame(width: UIScreen.screenWidth, height: 120, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                        .fill(colorScheme == .light ? Color.white: Color.darkButton)
                        .padding(.horizontal, .subHeadingFrontIndent)
                        .frame(width: UIScreen.screenWidth, height: 120, alignment: .center)
                        .fonzShadow()

                )
                .onAppear {
                    if trackFromNowPlaying.currentSong[0].trackName == "" {
                        trackFromNowPlaying.getActiveSong(sessionId: hostCoaster.sessionId)
                    }
                }
           
            
            Spacer()
                .frame(height: 30)
        }
        
        .ignoresSafeArea()
    }
}
