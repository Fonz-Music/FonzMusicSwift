//
//  GuestTopPlaylists.swift
//  FonzMusicSwift
//
//  Created by didi on 8/5/21.
//

import Foundation
import Combine
import Network

class GuestTopPlaylists: ObservableObject {

    var subscription: Set<AnyCancellable> = []
    var userSessionId : String = UserDefaults.standard.string(forKey: "userAccountSessionId") ?? ""
    var hostSessionId : String = UserDefaults.standard.string(forKey: "hostSessionId") ?? ""
//    var sessionId : String = ""

    @Published private (set) var products: [PlaylistPaginated] = []
    
    var connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
    
    @Published var offset : Int = Int()
//    var resultsPerSearch = 0

    var tempProducts =
        [
            PlaylistPaginated(playlistName:  "t-shirt weather", playlistId: "450Qb5OrMrsUop1dAlYBzt", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb4782902e9ffcb3bb86cccb30", amountOfTracks: 147, index: 0),
            PlaylistPaginated(playlistName:  "loveBytes",  playlistId: "7EH7GHNyv4WGHNgNDmAIsi", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb9b9513be9ec5855f6ca7f292", amountOfTracks: 208, index: 0),
            PlaylistPaginated(playlistName: "itRunsThroughMe",  playlistId: "0xcjMAJmLaJNqh7T8ZYwiA", playlistImage: "https://i.scdn.co/image/ab67706c0000bebbe90916b767f2d807693ec92f", amountOfTracks: 125, index: 0),
            PlaylistPaginated(playlistName: "likeChanel",  playlistId: "0prPSwUI18YvnjcJog28AT", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb97618a5798f29ae672b9eb3f", amountOfTracks: 77, index: 0),
            PlaylistPaginated(playlistName:   "toKeepYouSound", playlistId: "2e5Sm7qY9VPfByZojYKKi9", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb0aec42f042641d173ded32d1", amountOfTracks: 89, index: 0),
            PlaylistPaginated(playlistName:  "bangers and bumpers", playlistId: "3sr4hesDPkwWLhUDwxo0cq", playlistImage: "https://mosaic.scdn.co/640/ab67616d0000b27374558885d860bb58d78d1de8ab67616d0000b273b87da477ad10e87b09b88d1eab67616d0000b273ec3d15eab5bd77027abc4b23ab67616d0000b273eedabed826eeb6506a4c700d", amountOfTracks: 147, index: 0),
//            PlaylistPaginated(playlistName:  "This Is Rush",  playlistId: "37i9dQZF1DX9E92APFiTvV", playlistImage: "https://i.scdn.co/image/ab67706f0000000336834b90af842ac737f7dac3", amountOfTracks: 50, index: 0),
//            PlaylistPaginated(playlistName: "memoryLane",  playlistId: "3sRM90oyy8Zul8iF3Cg3RF", playlistImage: "https://i.scdn.co/image/ab67706c0000bebbbbb8672f1afbe3add6554550", amountOfTracks: 83, index: 0),
//            PlaylistPaginated(playlistName: "beautifulEscape",  playlistId: "4d2ObNuTa7AIMJY8TGvLDB", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb12bc8c494507c2f6550b919b", amountOfTracks: 23, index: 0),
//            PlaylistPaginated(playlistName:   "manifest destiny", playlistId: "4TOUWjjIiwBNXj82cLnltq", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb802a02183d45115fc2639cb6", amountOfTracks: 234, index: 0),
//            PlaylistPaginated(playlistName:  "malibuNinetyTwo", playlistId: "6rqm7IuR0DRbktih6FV9jm", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb0e65fceaffd297b0f3f14756", amountOfTracks: 212, index: 0)

        ]

    init() {
        print("starting top playlists")
        products = tempProducts
//        loadTopPlaylists()
        
    }

    func loadMorePlaylists() {
        products += SpotifyPaginatedApi().getGuestTopPlaylistsPaginated(sessionId: userSessionId, offset: offset)
        offset += 10
    }
    func loadTopPlaylists() {
        if connectedToSpotify && userSessionId != "" {
            print("getting top playlists")
            products += SpotifyPaginatedApi().getGuestTopPlaylistsPaginated(sessionId: userSessionId, offset: offset)
            offset += 10
//                SpotifySuggestionsApi().getGuestTopPlaylists(sessionId: userSessionId)
            if products.count < 1 {
                products = tempProducts
            }
        }
        else {
            print("no spot or no sessionId")
            products = tempProducts
//            products = SpotifySuggestionsApi().getNewSongReleases(sessionId: hostSessionId)
        }
    }
    func loadTopPlaylistsAfterSpotSignIn() {
        connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
        products = []
        loadTopPlaylists()
    }
}
