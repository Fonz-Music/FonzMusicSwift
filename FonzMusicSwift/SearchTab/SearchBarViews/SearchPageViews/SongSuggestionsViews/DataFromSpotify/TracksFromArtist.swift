//
//  TracksFromArtist.swift
//  FonzMusicSwift
//
//  Created by didi on 6/28/21.
//



import Foundation
import Combine
import Firebase
//import FirebaseAuth
import Network


class TracksFromArtist: ObservableObject {
    
    var subscription: Set<AnyCancellable> = []
    var userSessionId : String = UserDefaults.standard.string(forKey: "userSessionId")!
    var hostSessionId : String = UserDefaults.standard.string(forKey: "hostSessionId")!
    
    @Published private (set) var products: [Track] = []
    
    @Published var artistId: String = String()
    

    
//    let ADDRESS = "https://api.fonzmusic.com/"
//    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
    let ADDRESS = "http://52.50.138.97:8080/"
    
    // MARK:- Initiliazer for product via model.
    
    init() {
        print("starting this")
        $artistId
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [self] (artist) in
                products = SpotifySuggestionsApi().getTracksByArtist(sessionId: userSessionId, artistId: artist)
            }
            .store(in: &subscription)
        
    }
}

