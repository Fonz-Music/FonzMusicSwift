//
//  GuestTopArtists.swift
//  FonzMusicSwift
//
//  Created by didi on 8/5/21.
//

import Foundation
import Combine
import Network

class GuestTopArtists: ObservableObject {

    var subscription: Set<AnyCancellable> = []
    var userSessionId : String = UserDefaults.standard.string(forKey: "userAccountSessionId") ?? ""
    var hostSessionId : String = UserDefaults.standard.string(forKey: "hostSessionId") ?? ""
//    var sessionId : String = ""

    @Published private (set) var products: [ArtistPaginated] = []
    
    let connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
    
    @Published var offset : Int = Int()
    var resultsPerSearch = 0
//    @Published var updateTopArtists = true

//    let ADDRESS = "https://api.fonzmusic.com/"
//    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
    let ADDRESS = "http://52.50.138.97:8080/"
    let tempArtists =
        [
            ArtistPaginated(artistName: "Red Hot Chili Peppers", artistId:  "0L8ExT028jH3ddEcZwqJJ5", artistImage: "https://i.scdn.co/image/89bc3c14aa2b4f250033ffcf5f322b2a553d9331", index: 0),
            ArtistPaginated(artistName: "Kings of Leon", artistId: "2qk9voo8llSGYcZ6xrBzKx", artistImage: "https://i.scdn.co/image/168a281f4a0b1c2c61acb010239ead4710a234a3", index: 0),
            ArtistPaginated(artistName: "Circa Waves", artistId: "6hl5k4gLl1p3sjhHcb57t2", artistImage: "https://i.scdn.co/image/4a8d60073c6ce7007ac43a4807b36f0abd381028", index: 0),
            ArtistPaginated(artistName: "Hippo Campus", artistId: "1btWGBz4Uu1HozTwb2Lm8A", artistImage: "https://i.scdn.co/image/ab6761610000e5eb220b2af522d5044b93fc678e", index: 0),
            ArtistPaginated(artistName: "COIN", artistId: "0ZxZlO7oWCSYMXhehpyMvE", artistImage: "https://i.scdn.co/image/ab6761610000e5eb8a331b3acc328de052617020", index: 0),
            ArtistPaginated(artistName: "alt-J", artistId: "3XHO7cRUPCLOr6jwp8vsx5", artistImage: "https://i.scdn.co/image/7ac54cbec2f1b3f5f1b7f6fc23acb9d00c70fb51", index: 0),
            ArtistPaginated(artistName: "BENEE", artistId: "0Cp8WN4V8Tu4QJQwCN5Md4", artistImage: "https://i.scdn.co/image/cf1265cb1c2c35d253cbbac9b1489bc181322ed3", index: 0),
            ArtistPaginated(artistName: "girl in red", artistId: "3uwAm6vQy7kWPS2bciKWx9", artistImage: "https://i.scdn.co/image/ebff5a127cf8fbb20deb9bbcd02cfea64a660bef", index: 0),
            ArtistPaginated(artistName: "Rush", artistId: "2Hkut4rAAyrQxRdof7FVJq", artistImage: "https://i.scdn.co/image/6fdfa7c623d77d5900e69eef2443340e3493a4bf", index: 0)
        ]

    init() {
        print("starting this")
        if connectedToSpotify && userSessionId != "" {
            products += SpotifyPaginatedApi().getGuestTopArtistsPaginated(sessionId: userSessionId, offset: offset)
            offset += 10
//                SpotifySuggestionsApi().getGuestTopArtists(sessionId: userSessionId)
            if products.count < 1 {
                products = tempArtists
            }
        }
        else {
            products = tempArtists
                
//            products = SpotifySuggestionsApi().getNewSongReleases(sessionId: hostSessionId)
        }
    }

    func loadMoreArtists() {
        products += SpotifyPaginatedApi().getGuestTopArtistsPaginated(sessionId: userSessionId, offset: offset)
        offset += 10
    }
}
