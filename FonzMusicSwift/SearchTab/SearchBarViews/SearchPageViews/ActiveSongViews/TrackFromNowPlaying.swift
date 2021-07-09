//
//  TrackFromNowPlaying.swift
//  FonzMusicSwift
//
//  Created by didi on 6/28/21.
//

import Foundation
import Combine
import Firebase
//import FirebaseAuth
import Network


class TrackFromNowPlaying: ObservableObject {
    
    var subscription: Set<AnyCancellable> = []
    var tempSession : String = UserDefaults.standard.string(forKey: "hostSessionId")!
    
    @Published private (set) var currentSong: [NowPlayingInfo] = [NowPlayingInfo(artistName: "", albumArt: "https://i.scdn.co/image/ab67616d0000b273e1225196df3f67528c87c7fd", trackName: "")]
    
    @Published var nowPlaying: String = String()
    
    // MARK:- Initiliazer for product via model.
    
    init() {
//        print("starting this")
        $nowPlaying
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
//                    self.products = []
                    return nil
                }
                
                return string
            }) // prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [self] (searchField) in
                getActiveSong(sessionId: tempSession)
            }
            .store(in: &subscription)
    }
    
    
    func getActiveSong(sessionId:String) {
        print("starting search")
        // init vale for access token
        var accessToken = ""
        
        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return }
            // get token
            user.getIDToken(){ (idToken, error) in
            if error == nil, let token = idToken {
//                print("got token")
               
                
                accessToken = token
                // set URL
                guard let url = URL(string: "https://api.fonzmusic.com/guest/" + sessionId + "/spotify/state") else { return }
                
            
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                // makes request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let dataResp = data {
                        // just to see output
//                        print("got json")
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                        print(jsonData)
                        
                        if let decodedResponse = try? JSONDecoder().decode(NowPlayingResult.self, from: dataResp) {
                            // object that will store searchResults
                            var searchResults = [NowPlayingInfo]()
                            
//                            nowPlayingInfo = NowPlayingInfo(artistName: decodedResponse.artistName, albumArt: decodedResponse.images[0].url, trackName: decodedResponse.trackName)
                            
                            let newAlbumArt = decodedResponse.images[0].url
                            print(type(of: newAlbumArt))
                            print("this is the active song img \(decodedResponse.images[0].url)")
                            
                            let nowPlaying = NowPlayingInfo(artistName: decodedResponse.artistName, albumArt: newAlbumArt, trackName: decodedResponse.trackName)
//                                searchResults.append(nowPlaying)
//                            }
                            searchResults.append(nowPlaying)
                            DispatchQueue.main.async {
                                // returns searchResults
                                self.currentSong = searchResults
                                
//                                self.currentSong = NowPlayingInfo(artistName: decodedResponse.artistName, albumArt: newAlbumArt, trackName: decodedResponse.trackName)
                                print("this is the active song \(decodedResponse)")
                                print("this is the new song \(self.currentSong)")
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

struct NowPlayingResult: Codable {
    var artistName: String
    var images: Array<ImageArray>
    var trackName: String
}
struct NowPlayingInfo: Codable {
    var artistName: String
    var albumArt: String
    var trackName: String
}

