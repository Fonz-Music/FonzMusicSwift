//
//  ProductViewModel.swift
//  Fonz Music App Clip
//
//  Created by didi on 2/13/21.
//

import Foundation
import Combine
import Firebase
//import FirebaseAuth
import Network

class TracksFromSearch: ObservableObject {
    
    var subscription: Set<AnyCancellable> = []
    var tempSession : String = UserDefaults.standard.string(forKey: "hostSessionId") ?? ""
    
//    @Published private (set) var products: [Track] = []
    @Published private (set) var products: [TrackForPagination] = []
    
    @Published var searchText: String = String()
    
    @Published var offset : Int = Int()
    var resultsPerSearch = 20
    @Published var updateSearch = false
    
    // MARK:- Initiliazer for product via model.
    
    init() {
        print("starting this  tracks from search")
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 3 {
                    self.products = []
                    return nil
                }
                
                return string
            }) // prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
                
            } receiveValue: { [self] (searchField) in
//                if updateSearch {
                    products = SpotifyPaginatedApi().searchSessionPaginated(sessionId: tempSession, searchTerm: searchText, offset: offset)
//                    updateSearch = false
//                }
//                products = GuestApi().searchSession(sessionId: tempSession, searchTerm: searchField)
            }
            .store(in: &subscription)
        $offset
            .debounce(for: .milliseconds(600), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map({ (string) -> Int? in
//                if string.count < 3 {
//                    self.products = []
//                    return nil
//                }

                return string
            }) // prevents sending numerous requests and sends nil if the count of the characters is less than 1.
//            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
                
            } receiveValue: { [self] (searchField) in
                if updateSearch {
                    products += SpotifyPaginatedApi().searchSessionPaginated(sessionId: tempSession, searchTerm: searchText, offset: offset)
                    updateSearch = false
                    resultsPerSearch += 20
                }
//                products = GuestApi().searchSession(sessionId: tempSession, searchTerm: searchField)
            }
            .store(in: &subscription)
    }
}
