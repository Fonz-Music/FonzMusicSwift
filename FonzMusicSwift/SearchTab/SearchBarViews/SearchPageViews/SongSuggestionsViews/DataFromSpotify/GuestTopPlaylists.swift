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

    @Published private (set) var products: [Playlist] = []
    
    let connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")

//    let ADDRESS = "https://api.fonzmusic.com/"
//    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
    let ADDRESS = "http://52.50.138.97:8080/"
    var tempProducts =
        [
            Playlist(playlistName:  "This Is Rush",  playlistId: "37i9dQZF1DX9E92APFiTvV", playlistImage: "https://i.scdn.co/image/ab67706f0000000336834b90af842ac737f7dac3", amountOfTracks: 50),
            Playlist(playlistName: "memoryLane",  playlistId: "3sRM90oyy8Zul8iF3Cg3RF", playlistImage: "https://i.scdn.co/image/ab67706c0000bebbbbb8672f1afbe3add6554550", amountOfTracks: 83),
            Playlist(playlistName: "beautifulEscape",  playlistId: "4d2ObNuTa7AIMJY8TGvLDB", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb12bc8c494507c2f6550b919b", amountOfTracks: 23),
            Playlist(playlistName:   "manifest destiny", playlistId: "4TOUWjjIiwBNXj82cLnltq", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb802a02183d45115fc2639cb6", amountOfTracks: 234),
            Playlist(playlistName:  "malibuNinetyTwo", playlistId: "6rqm7IuR0DRbktih6FV9jm", playlistImage: "https://i.scdn.co/image/ab67706c0000bebb0e65fceaffd297b0f3f14756", amountOfTracks: 212)

        ]

    init() {
        print("starting top playlists")
        
        if connectedToSpotify && userSessionId != "" {
            print("getting top playlists")
            products = SpotifySuggestionsApi().getGuestTopPlaylists(sessionId: userSessionId)
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

}
