//
//  YourFavoriteArtists.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct YourFavoriteArtists: View {
    
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    
    // object that stores the songs from the api
    @ObservedObject var tracksFromArtist: TracksFromArtist
    
    
    @Environment(\.colorScheme) var colorScheme
    
    var topArtists =
    [
        Artist(artistName: "Red Hot Chili Peppers", artistId:  "0L8ExT028jH3ddEcZwqJJ5", artistImage: "https://i.scdn.co/image/89bc3c14aa2b4f250033ffcf5f322b2a553d9331"),
        Artist(artistName: "Kings of Leon", artistId: "2qk9voo8llSGYcZ6xrBzKx", artistImage: "https://i.scdn.co/image/168a281f4a0b1c2c61acb010239ead4710a234a3"),
        Artist(artistName: "Circa Waves", artistId: "6hl5k4gLl1p3sjhHcb57t2", artistImage: "https://i.scdn.co/image/4a8d60073c6ce7007ac43a4807b36f0abd381028"),
        Artist(artistName: "Hippo Campus", artistId: "1btWGBz4Uu1HozTwb2Lm8A", artistImage: "https://i.scdn.co/image/ab6761610000e5eb220b2af522d5044b93fc678e"),
        Artist(artistName: "COIN", artistId: "0ZxZlO7oWCSYMXhehpyMvE", artistImage: "https://i.scdn.co/image/ab6761610000e5eb8a331b3acc328de052617020"),
        Artist(artistName: "alt-J", artistId: "3XHO7cRUPCLOr6jwp8vsx5", artistImage: "https://i.scdn.co/image/7ac54cbec2f1b3f5f1b7f6fc23acb9d00c70fb51"),
        Artist(artistName: "BENEE", artistId: "0Cp8WN4V8Tu4QJQwCN5Md4", artistImage: "https://i.scdn.co/image/cf1265cb1c2c35d253cbbac9b1489bc181322ed3"),
        Artist(artistName: "girl in red", artistId: "3uwAm6vQy7kWPS2bciKWx9", artistImage: "https://i.scdn.co/image/ebff5a127cf8fbb20deb9bbcd02cfea64a660bef"),
        Artist(artistName: "Rush", artistId: "2Hkut4rAAyrQxRdof7FVJq", artistImage: "https://i.scdn.co/image/6fdfa7c623d77d5900e69eef2443340e3493a4bf")
    ]
    
    var body: some View {
        VStack {
            Text("your favorite artists")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzParagraphTwo()
                .padding(25)
                .frame(width: UIScreen.screenWidth, height: 50, alignment: .topLeading)
                .padding(.bottom, 25)
            
                ZStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0..<topArtists.count) {
                                
                                FavoriteArtistView(hostCoaster: hostCoaster, artistIn: topArtists[$0],  tracksFromArtist: tracksFromArtist)
                            }
                        }
                    }
                    .padding(20)
                }
                .background(
                    RoundedRectangle(cornerRadius: .cornerRadiusTasks)
                    .fill(colorScheme == .light ? Color.white: Color.darkButton)
                    .frame(width: UIScreen.screenWidth * 0.9, height: 150, alignment: .center)
                        .fonzShadow()
                )
                .padding(.horizontal)
        }
    }
}

struct FavoriteArtistView: View {
    
    // hostCoaster details passed in and will update view when changed
    @ObservedObject var hostCoaster:HostCoasterInfo
    // the song passed in
    let artistIn: Artist
   
    // object that stores the songs from the api
    @ObservedObject var tracksFromArtist: TracksFromArtist
    
    // so the button can only be pressed once
    @State var launchArtistSongsModal = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            launchArtistSongsModal = true
            tracksFromArtist.artist = artistIn.artistName
            FirebaseAnalytics.Analytics.logEvent("guestSelectedArtist", parameters: ["user":"guest", "tab":"search"])
        } label: {
            VStack {
                AsyncImage(url: URL(string: artistIn.artistImage)!,
                           placeholder: { Text("...").fonzParagraphTwo() },
                               image: { Image(uiImage: $0).resizable() })
                    .clipShape(Circle())
                    .frame(width: 80, height: 80, alignment: .center)
                Text(artistIn.artistName)
                    .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                    .fonzParagraphThree()
            }
            .frame(width: 90, height: 105, alignment: .center)
        }
        .sheet(isPresented: $launchArtistSongsModal, onDismiss: {
            print("test")
//                                    self.currentTune.songLoaded = false
//                                    self.queuesLeft += 1
        }) {
//            ArtistSongListModal(hostCoaster: hostCoaster, resultsTitle: artistIn.artistName, resultsType: "artist", resultsImage: artistIn.artistImage, currentTune: $currentTune, pressedSongToLaunchNfc: $pressedSongToLaunchNfc, tracksFromEntry: tracksFromArtist)
            ArtistSongListModal(hostCoaster: hostCoaster, resultsTitle: artistIn.artistName,  resultsImage: artistIn.artistImage, tracksFromEntry: tracksFromArtist)
        }

        
    }
}
