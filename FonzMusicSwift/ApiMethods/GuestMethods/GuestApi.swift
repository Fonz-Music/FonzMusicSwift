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



// all api functions inside
class GuestApi {
//    let ADDRESS = "https://api.fonzmusic.com/"
    //    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
        let ADDRESS = "http://52.50.138.97:8080/"
    let GUEST = "guest/"
    let COASTER = "coaster/"

    let tempToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFiYjk2MDVjMzZlOThlMzAxMTdhNjk1MTc1NjkzODY4MzAyMDJiMmQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiZGVlciIsInBpY3R1cmUiOiJodHRwczovL2xoNC5nb29nbGV1c2VyY29udGVudC5jb20vLXdIRHZhQXRMWklzL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUFBL0FNWnV1Y256SmJCbk94bWtFcTNuM3BJeE9wUHNDUXZ1dmcvczk2LWMvcGhvdG8uanBnIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2ZvbnotbXVzaWMtYXBwIiwiYXVkIjoiZm9uei1tdXNpYy1hcHAiLCJhdXRoX3RpbWUiOjE2MjcyNDI3MDAsInVzZXJfaWQiOiJFMnU5aXJabWtIYkY5ZlBHWDcyZTBFVDJNcjkyIiwic3ViIjoiRTJ1OWlyWm1rSGJGOWZQR1g3MmUwRVQyTXI5MiIsImlhdCI6MTYyNzI0MjcwMCwiZXhwIjoxNjI3MjQ2MzAwLCJlbWFpbCI6ImRpYXJtdWlkNDlAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiZGlhcm11aWQ0OUBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.lmM4hpgNo3Nfxj7n5bhkK0w6AReJtgPpz9KJssGC-zpkpX70X_4scS8B-5xKlF5ZoqwtrMTwetBXOAxQBJODyVBkQ74AFnoRgmmRVt7CU9tngk6oblp1s71LwT_mdtaWdlnQ3Kd75UlI1RuPnhZWyfEflGupAcIXBGkRQaXS4HaMuM9sEzJmV8bjkKXjz1piXqAn6qhnr6KtG9QbHTJUNJ3LtKMAQaWInqqaKpRffq5Wk-qhPyiKoanRCmKn42UqfBAZPwN2seVUe_gsFFO4RPdyE0WwMzVtfYAhE_Ft0ScdwyOZjH0GY4kAQuVHK-t8LQQKzqVU5dqhlWtm6WOELw"
    
    let userEmail = UserDefaults.standard.string(forKey: "userEmail")
    
    @State var results: CoasterResult!
    @Published private (set) var products: [Track] = []
 
    // api call to get the Coaster info
    func getCoasterInfo(coasterUid:String) -> CoasterResult {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = CoasterResult(sessionId: "", displayName: "", coasterName: "", coasterActive: false, coasterPaused: false, statusCode: 0)
        
        // init value for token
        var accessToken = ""

        print("starting getCoaster")

        accessToken = getJWTAndCheckIfExpired()
        

//        guard let user = Auth.auth().currentUser else {
//            print("there was an error getting the user")
//            return  returnObject}
//        print("got auth")
//
////             get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
//        accessToken = tempToken
                print("got token")
                print("\(accessToken)" )
                // set UID to uppercase
                let uid = coasterUid.uppercased()
                // create url
                guard let url = URL(string: self.ADDRESS + self.GUEST + self.COASTER + uid )
                else {
//                    return
                    return returnObject
                }
                
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
                        
                        returnObject.statusCode = response?.getStatusCode() ?? 0
                        
                        if let decodedResponse = try? JSONDecoder().decode(CoasterResult.self, from: dataResp) {
                            
                            // creates new coasterResult from return value
                            let newCoaster = CoasterResult(sessionId: decodedResponse.sessionId, displayName: decodedResponse.displayName, coasterName:  decodedResponse.coasterName, coasterActive: decodedResponse.coasterActive, coasterPaused: decodedResponse.coasterPaused, statusCode: 200 )
//                            print("newCoaster " + "\(newCoaster)")
                            // sets return value
                            returnObject = newCoaster
                        }
                        else if let decodedResponse = try? JSONDecoder().decode(BasicResponseWithCode.self, from: dataResp) {
                            if decodedResponse.code == "COASTER_NO_HOST" {
                                returnObject.statusCode = 204
                            }
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                            print(decodedResponse?.status)
                            print("there was an error \(decodedResponse?.message)")
                            
                            returnObject.statusCode = decodedResponse?.status ?? 0
                                
                                // creates new coasterResult from return value
//                            let newCoaster = CoasterResult(sessionId: "", displayName: "", coasterName:  "", coasterActive: false, coasterPaused: false, statusCode: decodedResponse?.status ?? 0 )
//                                print("newCoaster " + "\(newCoaster)")
//                                // sets return value
//                                returnObject = newCoaster
                            
                            
                        }
                    } else {
                        print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                    }
                }.resume()
//            }else{
//                print("error")
//                //error handling
//            }
//        }
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
        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return returnInt}
        print("no error getting user")
            // get access token
            user.getIDToken(){ (idToken, error) in
            if error == nil, let token = idToken {
                accessToken = token
                print("got token")
                print("the session if id \(sessionId)")
                print(" the track id is \(trackId)")
                // set URL
                guard let url = URL(string: self.ADDRESS + self.GUEST + sessionId + "/spotify/queue/spotify:track:" + trackId) else { return }
            
                
                print("creating url req")
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                // makes the request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    // code to defer until this is completed
                    defer { sem.signal() }
                    
                    if let dataResp = data {

                        if let decodedResponse = try? JSONDecoder().decode(QueueSongResult.self, from: dataResp) {
                    
//                            print("decoded resposne . status \(decodedResponse.status)")
                            // sets return value
                            returnInt = decodedResponse.status
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
        // tells function to wait before returning
        sem.wait()
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
    
//    func searchSession(sessionId:String, searchTerm:String) {
//        print("searching session")
//        var accessToken = ""
//        guard let user = Auth.auth().currentUser else {
//            print("there was an error getting the user")
//            return }
////        var accessToken =
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                print("changing accessToken")
//                accessToken = token
//                print(accessToken)
//                guard let url = URL(string: "https://api.fonzmusic.com/guest/" + sessionId + "/spotify/search?term=" + searchTerm) else { return }
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
//                        if let decodedResponse = try? JSONDecoder().decode(TracksResult.self, from: dataResp) {
//                            print("decoded response")
//                            print("decoded resposne \(decodedResponse)")
//                            DispatchQueue.main.async {
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
    
    
    


}

