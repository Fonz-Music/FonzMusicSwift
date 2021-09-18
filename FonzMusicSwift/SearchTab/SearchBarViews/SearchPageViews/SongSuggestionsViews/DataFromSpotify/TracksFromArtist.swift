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
    var hostSessionId : String = UserDefaults.standard.string(forKey: "hostSessionId") ?? ""
    
    @Published private (set) var products: [Track] = []
    
    @Published var artistId: String = String()
    


    init() {
        print("starting this tracks from artists")
        $artistId
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [self] (artist) in
//                if artistId != "" {
                    products = SpotifySuggestionsApi().getTracksByArtist(sessionId: hostSessionId, artistId: artist)
//                }
                
            }
            .store(in: &subscription)
        
    }
}

