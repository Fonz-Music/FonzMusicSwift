//
//  SongListModal.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI

struct SongListModal: View {
    
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    
     var resultsTitle : String
     var resultsType : String
     var resultsImage : String
    
    @Environment(\.colorScheme) var colorScheme
    
    let layout = [
            GridItem(.flexible())
        ]
    
    @State var tracksFromEntry =
        [Track(songName: "Rushing Back", songId: "2zoNNEAyPK2OGDfajardlY", artistName: " Flume Vera Blue", albumArt: "https://i.scdn.co/image/ab67616d0000b273683d659e308221da35d3c0ca", spotifyUrl: "https://open.spotify.com/track/2zoNNEAyPK2OGDfajardlY"),
         Track(songName: "Borderline", songId: "5hM5arv9KDbCHS0k9uqwjr", artistName: " Tame Impala", albumArt: "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", spotifyUrl: "https://open.spotify.com/track/5hM5arv9KDbCHS0k9uqwjr"),
         Track(songName: "Rush Hour", songId: "09VACB0akCnPueTFnjN5Pn", artistName: " Mac Miller", albumArt: "https://i.scdn.co/image/ab67616d0000b273ee0f38410382a255e4fb15f4", spotifyUrl: "https://open.spotify.com/track/09VACB0akCnPueTFnjN5Pn"),
         Track(songName: "Tom Sawyer", songId: "3QZ7uX97s82HFYSmQUAN1D", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/3QZ7uX97s82HFYSmQUAN1D"),
         Track(songName: "Rush Over Me", songId: "6BDLcvvtyJD2vnXRDi1IjQ", artistName: " Seven Lions ILLENIUM Said The Sky HALIENE", albumArt: "https://i.scdn.co/image/ab67616d0000b273d60e5cac1691f8b02a6351e7", spotifyUrl: "https://open.spotify.com/track/6BDLcvvtyJD2vnXRDi1IjQ"),
         Track(songName: "gold rush", songId: "5BK0uqwY9DNfZ630STAEaq", artistName: " Taylor Swift", albumArt: "https://i.scdn.co/image/ab67616d0000b27333b8541201f1ef38941024be", spotifyUrl: "https://open.spotify.com/track/5BK0uqwY9DNfZ630STAEaq"),
         Track(songName: "The Scientist", songId: "75JFxkI2RXiU7L9VXzMkle", artistName: " Coldplay", albumArt: "https://i.scdn.co/image/ab67616d0000b27390afd8e4ec6d787114ed6c40", spotifyUrl: "https://open.spotify.com/track/75JFxkI2RXiU7L9VXzMkle"),
         Track(songName: "Rush (feat. Jessie Reyez)", songId: "7tTRP2vA00uScZ4SjB3ZQZ", artistName: " Lewis Capaldi Jessie Reyez", albumArt: "https://i.scdn.co/image/ab67616d0000b273e8937101e6dc8ea504c6b546", spotifyUrl: "https://open.spotify.com/track/7tTRP2vA00uScZ4SjB3ZQZ"),
         Track(songName: "Don\'t Rush (feat. DaBaby)", songId: "3AMxuq6id3YGB57eWeheZQ", artistName: " Young T & Bugsey DaBaby", albumArt: "https://i.scdn.co/image/ab67616d0000b273844c78f23e38f2cf04df4ae1", spotifyUrl: "https://open.spotify.com/track/3AMxuq6id3YGB57eWeheZQ"),
         Track(songName: "Limelight", songId: "0K6yUnIKNsFtfIpTgGtcHm", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
         Track(songName: "Rush Rush", songId: "015qd1I4v00JIoK7yOUgKC", artistName: " Paula Abdul", albumArt: "https://i.scdn.co/image/ab67616d0000b2734cca3a496c860b0558a11e02", spotifyUrl: "https://open.spotify.com/track/015qd1I4v00JIoK7yOUgKC"),
         Track(songName: "Rush", songId: "4gTMIyJJlSuB5BOhbMri6B", artistName: " Big Audio Dynamite", albumArt: "https://i.scdn.co/image/ab67616d0000b27336acf9e921c97613536b4174", spotifyUrl: "https://open.spotify.com/track/4gTMIyJJlSuB5BOhbMri6B"),
         Track(songName: "Clocks", songId: "0BCPKOYdS2jbQ8iyB56Zns", artistName: " Coldplay", albumArt: "https://i.scdn.co/image/ab67616d0000b27390afd8e4ec6d787114ed6c40", spotifyUrl: "https://open.spotify.com/track/0BCPKOYdS2jbQ8iyB56Zns"),
         Track(songName: "Boyfriend", songId: "1rKBOL9kJfX1Y4C3QaOvRH", artistName: " Big Time Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129", spotifyUrl: "https://open.spotify.com/track/1rKBOL9kJfX1Y4C3QaOvRH"),
         Track(songName: "Rush E", songId: "7CBN7Kwx1g8SBJZyUbhHc6", artistName: " Sheet Music Boss", albumArt: "https://i.scdn.co/image/ab67616d0000b2736071dea28090ff26dea3cf66", spotifyUrl: "https://open.spotify.com/track/7CBN7Kwx1g8SBJZyUbhHc6"),
         Track(songName: "Rush", songId: "1dpXikU9kSyxm1mKulwHws", artistName: " Aly & AJ", albumArt: "https://i.scdn.co/image/ab67616d0000b273b52b84683b36aba0ce1e63f3", spotifyUrl: "https://open.spotify.com/track/1dpXikU9kSyxm1mKulwHws"),
         Track(songName: "Is It True", songId: "6RZmhpvukfyeSURhf4kZ0d", artistName: " Tame Impala", albumArt: "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", spotifyUrl: "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
         Track(songName: "Rush", songId: "2PXnV9PBUGW4v5u6WJpCjG", artistName: " SEATBELTS", albumArt: "https://i.scdn.co/image/ab67616d0000b273e90a54d6e31d9ff3f1d566fa", spotifyUrl: "https://open.spotify.com/track/2PXnV9PBUGW4v5u6WJpCjG"),
         Track(songName: "The Spirit Of Radio", songId: "4e9hUiLsN4mx61ARosFi7p", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", spotifyUrl: "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p")]
    
    var body: some View {
        ZStack {
            // background gradient
            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [.lilac, .amber]),
                    startPoint: .topLeading,
                      endPoint: .bottomTrailing
                ))
            VStack {
                HStack(spacing: 10) {
                    // album art
                    AsyncImage(url: URL(string: resultsImage)!,
                               placeholder: { Text("...").fonzParagraphTwo() },
                                   image: { Image(uiImage: $0).resizable() })
                        .frame( width: 80 ,height: 80, alignment: .leading).cornerRadius(5)
                    // title & artist
                    VStack(alignment: .leading, spacing: 5) {
                        Text(verbatim: resultsTitle)
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzParagraphOne()
                        Text(verbatim: resultsType)
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzParagraphTwo()
                    }
                    Spacer()
                }
                .padding()
                ZStack {
                    Rectangle()
                        .fill(colorScheme == .light ? Color.white: Color.darkBackground)
                        .ignoresSafeArea()
                    VStack {
                        Text("songs")
                            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                            .fonzParagraphTwo()
                            .padding(25)
                            .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                        ScrollView() {
                            LazyVGrid(columns: layout, spacing: 8) {
                                ForEach(0..<tracksFromEntry.count) {
                                    
                                    SongListModalSongButton(hostCoaster: hostCoaster, trackToQueue: tracksFromEntry[$0])
        //                            Button(action: {
        //                                print("button pressed: \(queuePopupPresent)" )
        //                                // temp button to send the song to a mate
        //    //                                    shareButton(urlToShare: item.spotifyUrl)
        //                                // sets the current song to song chosen
        //                                if !queuePopupPresent {
        //                                    // bool to launch queueSongSheet set to true
        //                                    self.queuePopupPresent = true
        //                                    // sets temp tune attributes to pass into sheet
        //                                    self.tempTune.albumArt = item.albumArt
        //                                    self.tempTune.songId = item.songId
        //                                    self.tempTune.songName = item.songName
        //                                    self.tempTune.artistName = item.artistName
        //                                    self.tempTune.songLoaded = true
        //                                self.tempTune.spotifyUrl = item.spotifyUrl
        //                                }
        //                            }, label: {
                                        
                                            
        //                            })
                                    // launches queueSongSheet after song is selected
        //                            .sheet(isPresented: $queuePopupPresent, onDismiss: {
        //                                print("test")
        //    //                                    self.currentTune.songLoaded = false
        //    //                                    self.queuesLeft += 1
        //                            }) {
        //                                QueueSongSheet(currentTune: tempTune, hostCoaster: hostCoaster, queuePopupPresent: $queuePopupPresent)
        //                            }
        //                        }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                        .frame(width: UIScreen.screenWidth * 0.9)
                    }
                }
            }
        }
    }
}

struct SongListModalSongButton: View {
    
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    
    // so the button can only be pressed once
    @State var queuePopupPresent = false
    
    var trackToQueue : Track
    
    
    var body: some View {
        Button {
            queuePopupPresent = true
        } label: {
            SongResultFromSearchItemView(item: trackToQueue)
        }.sheet(isPresented: $queuePopupPresent, onDismiss: {
            print("test")
        }) {
            QueueSongSheet(currentTune: trackToQueue.toGlobalTrack(), hostCoaster: hostCoaster, queuePopupPresent: $queuePopupPresent)
        }

    }
    
}

