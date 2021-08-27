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
    var userSessionId : String = UserDefaults.standard.string(forKey: "userAccountSessionId") ?? ""
    var hostSessionId : String = UserDefaults.standard.string(forKey: "hostSessionId") ?? ""
    
    @Published private (set) var products: [Track] = []
    
//    @Published private (set) var products: [TrackForPagination] = []
    @Published var playlistId: String = String()

    @Published var offset : Int = Int()
    var resultsPerSearch = 20
    @Published var updateSearch = false
    
    init() {
        print("starting to get tracks by playlist")
        $playlistId
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [self] (playlist) in
//                if playlistId != "" {
//                products = SpotifyPaginatedApi().getTracksByPlaylistPaginated(sessionId: userSessionId, playlistId: playlist, offset: offset)
                        products = SpotifySuggestionsApi().getTracksByPlaylist(sessionId: hostSessionId, playlistId: playlist)
//                }
                
            }
            .store(in: &subscription)
//        $offset
//            .debounce(for: .milliseconds(600), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
//            .removeDuplicates()
//            .map({ (string) -> Int? in
////                if string.count < 3 {
////                    self.products = []
////                    return nil
////                }
//
//                return string
//            }) // prevents sending numerous requests and sends nil if the count of the characters is less than 1.
////            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
//            .sink { (_) in
//                //
//
//            } receiveValue: { [self] (playlist) in
//                if updateSearch {
//                    products += SpotifyPaginatedApi().getTracksByPlaylistPaginated(sessionId: hostSessionId, playlistId: playlistId, offset: offset)
//                    updateSearch = false
//                    resultsPerSearch += 20
//                }
////                products = GuestApi().searchSession(sessionId: tempSession, searchTerm: searchField)
//            }
//            .store(in: &subscription)
    }
    
}

