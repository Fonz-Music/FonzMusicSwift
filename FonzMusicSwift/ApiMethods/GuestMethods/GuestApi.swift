//
//  APIMethods.swift
//  Fonz Music App Clip
//
//  Created by didi on 2/9/21.
//

import SwiftUI
import Firebase
import KeychainAccess



struct QueueSongResult: Codable {
    var status: Int
}
// response for getting the coaster info
struct GetCoasterInfoGuestResponse : Codable {
    var coaster : CoasterResponse
    var session : SessionResponse
    var statusCode: Int?
}



// all api functions inside
class GuestApi {
//    let ADDRESS = "https://api.fonzmusic.com/"
    let ADDRESS = "https://beta.api.fonzmusic.com/"
//    let ADDRESS = "http://52.50.138.97:8080/"
    let GUEST = "guest/"
    let COASTER = "coaster/"

//    let tempToken = ""
    
//    let userEmail = UserDefaults.standard.string(forKey: "userEmail")

//    @Published private (set) var products: [Track] = []
 
    // api call to get the Coaster info
    func getCoasterInfo(coasterUid:String) -> GetCoasterInfoGuestResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = GetCoasterInfoGuestResponse(coaster: CoasterResponse(active: false, coasterId: "", name: "", group: "", encoded: false), session: SessionResponse(sessionId: "", userId: "", active: false, provider: ""))
        
        // init value for token
        var accessToken = ""

        print("starting getCoaster")

        accessToken = getJWTAndCheckIfExpired()
        
//        print("\(accessToken)" )
        // set UID to uppercase
        let uid = coasterUid.uppercased()
        // create url
        guard let url = URL(string: self.ADDRESS + self.GUEST + self.COASTER + uid )
        else { return returnObject}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        // this is the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData)
                
                if let decodedResponse = try? JSONDecoder().decode(GetCoasterInfoGuestResponse.self, from: dataResp) {
                    
                    print("success getting reponse")
                    // creates new coasterResult from return value
                    let newCoaster = decodedResponse
//                            print("newCoaster " + "\(newCoaster)")
                    // sets return value
                    returnObject = newCoaster
                    returnObject.statusCode = response?.getStatusCode() ?? 0
                    print("resp code is \(returnObject.statusCode)")
                    
                }
                else if let decodedResponse = try? JSONDecoder().decode(BasicResponseWithCode.self, from: dataResp) {
                    print("in basic response")
                    if decodedResponse.code == "COASTER_NO_HOST" {
                        returnObject.coaster.statusCode = 204
                        returnObject.statusCode = 204
                        print("setting return to 204")
                    }
                    else {
                        returnObject.statusCode = response?.getStatusCode() ?? 0
                        print("setting return to \(returnObject.statusCode)")
                    }
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print(decodedResponse?.status)
                    print("there was an error \(decodedResponse?.message)")
                    
                    returnObject.statusCode = decodedResponse?.status ?? 0
                }
            } else {
                returnObject.statusCode = response?.getStatusCode() ?? 0
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
        // tells function to wait before returning
        sem.wait()
        return returnObject
    }
    
    
    
    func queueSong(sessionId:String, trackId:String) -> Int {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        // init return Status code
        var returnInt = 0
        
        print("strting to queue song")
        // init token
        var accessToken = ""
        
        accessToken = getJWTAndCheckIfExpired()
//        print("got token")
//        print("the session if id \(sessionId)")
//        print(" the track id is \(trackId)")
        // set URL
        guard let url = URL(string: self.ADDRESS + self.GUEST + sessionId + "/spotify/queue/spotify:track:" + trackId) else { return returnInt}
    
        print("creating url req")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        // makes the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData as Any)
                if let decodedResponse = try? JSONDecoder().decode(QueueSongResult.self, from: dataResp) {
            
//                            print("decoded resposne . status \(decodedResponse.status)")
                    // sets return value
                    
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
            
            returnInt = response?.getStatusCode() ?? 0
            
        }.resume()
        // tells function to wait before returning
        sem.wait(timeout: .now() + 2.0)
        print("return int is \(returnInt)")
        return returnInt
    }
    
//    func joinSession(sessionId:String) {
//        print("joining session")
//        var accessToken = ""
//        guard let user = Auth.auth().currentUser else {
//            print("there was an error getting the user")
//            return }
////        var accessToken =
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                print("changing accessToken")
//                accessToken = token
////                print(accessToken)
//                guard let url = URL(string: "https://api.fonzmusic.com/guest/session/" + sessionId ) else { return }
//
//                var request = URLRequest(url: url)
//                request.httpMethod = "GET"
//                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//
//                URLSession.shared.dataTask(with: request) { data, response, error in
//                    if let dataResp = data {
//                        print("got data ")
//
////                        print(try? JSONSerialization.jsonObject(with: data!, options: []))
//                        if let decodedResponse = try? JSONDecoder().decode(JoinSessionResult.self, from: dataResp) {
//                            print("decoded response")
//
//                            print("decoded resposne \(decodedResponse)")
//                            DispatchQueue.main.async {
//
////                                self.results = [CoasterResult(sessionId: decodedResponse.sessionId, displayName: decodedResponse.displayName, coasterName:  decodedResponse.coasterName )]
//                            }
//
//                            return
//                        }
//                    } else {
//                        print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
//                    }
//                }.resume()
//
//            }else{
//                print("error")
//                //error handling
//            }
//        }
//
//    }
    
    func searchSession(sessionId:String, searchTerm:String) -> [Track] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        // init vale for access token
        var accessToken = ""
        var products: [Track] = []
        // get access token
        accessToken = getJWTAndCheckIfExpired()
        // replaces spaces with underscore
        let searchSong = searchTerm.replacingOccurrences(of: " ", with: "_")
        
//                accessToken = token
        // set URL
        guard let url = URL(string: self.ADDRESS + "guest/" + sessionId + "/spotify/search?term=" + searchSong) else { return products}
        print("url \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        // makes request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                // just to see output
                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                        print(jsonData)
                
                if let decodedResponse = try? JSONDecoder().decode(SearchResults.self, from: dataResp) {
                    
                    print("success")
                    // object that will store searchResults
                    let tracks = decodedResponse.searchResults.body.tracks.items
                    // goes thru json and extracts important info for track
                    products = itemsToTracks(tracks: tracks)
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
        // tells function to wait before returning
        sem.wait()
        return products
    }
    
   
    
    


}

