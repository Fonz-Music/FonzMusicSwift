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
    
    var connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
    
    var loadArtists = true
    
    @Published var offset : Int = Int()

    let tempArtists =
        [
            ArtistPaginated(artistName: "Gus Dapperton", artistId:  "6sHCvZe1PHrOAuYlwTLNH4", artistImage: "https://i.scdn.co/image/ab6761610000e5ebb9583cd924906a133356770b", index: 0),
            ArtistPaginated(artistName: "Sticky Fingers", artistId: "3ZGr7nQBXDU2WhyXgRVbt0", artistImage: "https://i.scdn.co/image/ab6761610000e5eb1ce40fb5594af15406d233d0", index: 0),
            ArtistPaginated(artistName: "Jafaris", artistId: "69hGavzu5tphYU1EIY0yEg", artistImage: "https://i.scdn.co/image/ab6761610000e5ebccbb4acd25d81442c1ab5bf8", index: 0),
            ArtistPaginated(artistName: "Hippo Campus", artistId: "1btWGBz4Uu1HozTwb2Lm8A", artistImage: "https://i.scdn.co/image/ab6761610000e5eb220b2af522d5044b93fc678e", index: 0),
            ArtistPaginated(artistName: "Txmmy Rose", artistId: "1bcfct7lYeMK7cqCDFRGYo", artistImage: "https://i.scdn.co/image/ab6761610000e5ebb7ef98ac88a29bd18d80b3fd", index: 0),
            ArtistPaginated(artistName: "girl in red", artistId: "3uwAm6vQy7kWPS2bciKWx9", artistImage: "https://i.scdn.co/image/ebff5a127cf8fbb20deb9bbcd02cfea64a660bef", index: 0),
            ArtistPaginated(artistName: "Mac Miller", artistId: "4LLpKhyESsyAXpc4laK94U", artistImage: "https://i.scdn.co/image/ab6761610000e5ebed3b89aa602145fde71a163a", index: 0),
            ArtistPaginated(artistName: "Dominic Fike", artistId: "6USv9qhCn6zfxlBQIYJ9qs", artistImage: "https://i.scdn.co/image/ab6761610000e5eb436d45fb9b11ad089e0e3c11", index: 0),
            ArtistPaginated(artistName: "Peach Pit", artistId: "6fC2AcsQtd9h4BWELbbire", artistImage: "https://i.scdn.co/image/ab6761610000e5ebb95318e678c40fc2f02c0722", index: 0),
            
//            ArtistPaginated(artistName: "alt-J", artistId: "3XHO7cRUPCLOr6jwp8vsx5", artistImage: "https://i.scdn.co/image/7ac54cbec2f1b3f5f1b7f6fc23acb9d00c70fb51", index: 0),
//            ArtistPaginated(artistName: "BENEE", artistId: "0Cp8WN4V8Tu4QJQwCN5Md4", artistImage: "https://i.scdn.co/image/cf1265cb1c2c35d253cbbac9b1489bc181322ed3", index: 0),
//            ArtistPaginated(artistName: "Rush", artistId: "2Hkut4rAAyrQxRdof7FVJq", artistImage: "https://i.scdn.co/image/6fdfa7c623d77d5900e69eef2443340e3493a4bf", index: 0)
        ]

    init() {
        print("starting this artists")
//        products = tempArtists
//        loadTopArtists()
    }

    func loadMoreArtists() {
        products += SpotifyPaginatedApi().getGuestTopArtistsPaginated(sessionId: userSessionId, offset: offset)
        offset += 10
    }
    func loadTopArtists() {
//        products = []
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
    func loadTopArtistsAfterSpotSignIn() {
        connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
        products = []
        loadTopArtists()
    }
}
