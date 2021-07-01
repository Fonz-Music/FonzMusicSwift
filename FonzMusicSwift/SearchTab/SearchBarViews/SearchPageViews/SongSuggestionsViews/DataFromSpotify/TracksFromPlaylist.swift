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
    var tempSession : String = ""
    
    @Published private (set) var products: [Track] = []
    
    @Published var playlist: String = String()
    
    // MARK:- Initiliazer for product via model.
    
    init() {
//        print("starting this")
        $playlist
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
                searchSession(sessionId: tempSession, searchTerm: searchField)
            }
            .store(in: &subscription)
    }
    
    
    func searchSession(sessionId:String, searchTerm:String) {
        print("starting search")
        // init vale for access token
        var accessToken = ""
        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return }
            // get token
            user.getIDToken(){ (idToken, error) in
            if error == nil, let token = idToken {
                
                // replaces spaces with underscore
                let searchSong = searchTerm.replacingOccurrences(of: " ", with: "_")
                
                accessToken = token
                // set URL
                guard let url = URL(string: "https://api.fonzmusic.com/guest/" + sessionId + "/spotify/search?term=" + searchSong) else { return }
                
            
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                // makes request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let dataResp = data {
                        // just to see output
//                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                        print(jsonData)
                        
                        if let decodedResponse = try? JSONDecoder().decode(TracksResult.self, from: dataResp) {
                            // object that will store searchResults
                            var searchResults = [Track]()
                            let tracks = decodedResponse.tracks.items
                            
                            // goes thru json and extracts important info for track
                            for track in tracks {
//                                print("\(track.external_urls)")
                            
                                let albumArt = track.album.images[0].url
                                let listArtist = track.artists
                                var listArtistString = ""
                                for (index, element) in listArtist.enumerated() {
                                    listArtistString += " " + element.name
                                    
                                }
                                let spotifyUrl = track.external_urls.spotify
                                // compiles all info into one track
                                let newTrack = Track(songName: track.name, songId: track.id, artistName: listArtistString, albumArt: albumArt, spotifyUrl: spotifyUrl)
                                // appends that onto searchResults array
//                                print(searchResults)
                                searchResults.append(newTrack)
                            }
                            DispatchQueue.main.async {
                                // returns searchResults
                                self.products = searchResults
                            }
                            return
                        }
                    } else {
                        print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                    }
                }.resume()
                
            }else{
                print("error")
                //error handling
            }
        }
    }
    
}

