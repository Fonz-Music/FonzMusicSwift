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
    @StateObject var hostCoaster:HostCoasterInfo
    // track object to update the song to queue
    @StateObject var currentTune : GlobalTrack
    // object that stores the songs from the api
    @StateObject var tracksFromTopSongs: TracksFromTopSongs
    // bool that will launch nfc when pressed
    @Binding var pressedSongToLaunchNfc : Bool
    
    // statusCode from queueing song
    @Binding var statusCodeQueueSong : Int
    // boolean to change when views should be showed w animation
    @Binding var showQueueResponse : Bool
    
    @State var connectedToSpotify : Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    

    var body: some View {
        VStack{
            HStack{
                Text(connectedToSpotify ? "your top songs" : "fonz top songs")
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzParagraphTwo()
                    .padding(.horizontal, .subHeadingFrontIndent)
//                    .padding(.bottom, 10)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack(spacing: 10) {
                            // from first song to halfway thru
                            ForEach(tracksFromTopSongs.topProducts, id: \.self) { track in
                                TopSongButtonView(hostCoaster: hostCoaster, topSong: track.toTrack(), currentTune: currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc, statusCodeQueueSong: $statusCodeQueueSong, showQueueResponse: $showQueueResponse)
                                    .padding(.top, 5)
                            }.padding(.trailing, 5)
                        }
                        .padding(.bottom, 5)
                                  
                        HStack(spacing: 10) {
                            // from halfway thru to last song
                            ForEach(tracksFromTopSongs.bottomProducts, id: \.self) { track in
                                TopSongButtonView(hostCoaster: hostCoaster, topSong: track.toTrack(), currentTune: currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc, statusCodeQueueSong: $statusCodeQueueSong, showQueueResponse: $showQueueResponse)
                                    .padding(.bottom, 10)
                            }.padding(.trailing, 5)

                            
                        }
                        
                        
                    }
                    if connectedToSpotify {
        //                .padding(.horizontal, 5)
                        Button(action: {
                            tracksFromTopSongs.loadMoreTracks()
                        }, label: {
                            
                                
                            // load more
                            VStack(alignment: .center) {
                                Spacer()
                                Image(systemName: "arrow.clockwise")
                                    .padding(.horizontal, 10)
                                    .padding(.top, 10)
                                    .foregroundColor(.amber)
                                Spacer()
                                Text("load more")
                                    .foregroundColor(.amber)
                                    .fonzParagraphThree()
                                Spacer()
                            }
                            .frame(width: UIScreen.screenWidth * 0.25, height: UIScreen.screenWidth * 0.25)
                            .animation(.easeIn)
                        })
                        .buttonStyle(BasicFonzButton(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber, selectedOption: true))
                        .padding(.trailing, 5)
                    }
                }
            }
            
            .padding(.horizontal, .subHeadingFrontIndent)
            .frame(width: UIScreen.screenWidth, alignment: .center)
        }
        .onAppear {
           connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
           
        }
        
    }
}


