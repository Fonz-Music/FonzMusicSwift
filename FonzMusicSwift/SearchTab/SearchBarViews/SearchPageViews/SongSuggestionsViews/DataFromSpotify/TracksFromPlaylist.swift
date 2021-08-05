//
//  TracksFromPlaylist.swift
//  FonzMusicSwift
//
//  Created by didi on 6/28/21.
//


import Foundation
import Combine
import Firebase
//import FirebaseAuth
import Network


class TracksFromPlaylist: ObservableObject {
    
    var subscription: Set<AnyCancellable> = []
    var userSessionId : String = UserDefaults.standard.string(forKey: "userSessionId")!
    var hostSessionId : String = UserDefaults.standard.string(forKey: "hostSessionId")!
    
    @Published private (set) var products: [Track] = []
    @Published var playlistId: String = String()

    
    init() {
//        print("starting this")
        $playlistId
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [self] (playlist) in
                products = SpotifySuggestionsApi().getTracksByPlaylist(sessionId: userSessionId, playlistId: playlist)
            }
            .store(in: &subscription)
    }
    
}

