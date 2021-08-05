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
    var tempSession : String = UserDefaults.standard.string(forKey: "hostSessionId")!
    
    @Published private (set) var products: [Track] = []
    
    @Published var searchText: String = String()
    
//    let ADDRESS = "https://api.fonzmusic.com/"
    //    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
        let ADDRESS = "http://52.50.138.97:8080/"
    
    // MARK:- Initiliazer for product via model.
    
    init() {
        print("starting this")
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.products = []
                    return nil
                }
                
                return string
            }) // prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [self] (searchField) in
                products = GuestApi().searchSession(sessionId: tempSession, searchTerm: searchField)
            }
            .store(in: &subscription)
    }
}
