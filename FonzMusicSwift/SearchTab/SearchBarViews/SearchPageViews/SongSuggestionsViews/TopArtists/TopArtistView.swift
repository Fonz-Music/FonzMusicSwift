//
//  TopArtistView.swift
//  FonzMusicSwift
//
//  Created by didi on 7/31/21.
//

import SwiftUI
import FirebaseAnalytics

struct TopArtistView: View {
    
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
            tracksFromArtist.artistId = artistIn.artistId
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
            ArtistSongListModal(hostCoaster: hostCoaster, resultsTitle: artistIn.artistName,  resultsImage: artistIn.artistImage, tracksFromEntry: tracksFromArtist)
        }
    }
}
