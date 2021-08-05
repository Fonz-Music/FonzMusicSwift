//
//  TracksFromTopSongs.swift
//  FonzMusicSwift
//
//  Created by didi on 8/5/21.
//

import Foundation
import Combine
import Firebase
//import FirebaseAuth
import Network

class TracksFromTopSongs: ObservableObject {

    var subscription: Set<AnyCancellable> = []
    var userSessionId : String = UserDefaults.standard.string(forKey: "userSessionId")!
    var hostSessionId : String = UserDefaults.standard.string(forKey: "hostSessionId")!
//    var sessionId : String = ""

    @Published private (set) var products: [Track] = []
    @Published var searchText: String = String()
    
    let connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")

//    let ADDRESS = "https://api.fonzmusic.com/"
//    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
    let ADDRESS = "http://52.50.138.97:8080/"


    init() {
        print("starting this")
        if connectedToSpotify {
            products = SpotifySuggestionsApi().getGuestTopSongs(sessionId: userSessionId)
        }
        else {
            products = SpotifySuggestionsApi().getNewSongReleases(sessionId: hostSessionId)
        }
    }

}
