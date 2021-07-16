//
//  SpotifySignInApi.swift
//  FonzMusicSwift
//
//  Created by didi on 6/9/21.
//

import SwiftUI
import Firebase

// all api functions inside
class SpotifySignInApi {
    
//    let ADDRESS = "https://api.fonzmusic.com/"
    //    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
        let ADDRESS = "http://52.50.138.97:8080/"
    let CALLBACK = "callback/"
    let SPOTIFY = "spotify"
    
    
//    // api call to get the Coaster info
//    func updateSpotifyProvider() -> BasicResponse {
//        // this allows us to wait before returning value
//        let sem = DispatchSemaphore.init(value: 0)
//
//        // init value for return
//        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
//        var returnMessage = ""
//        var returnCode = 0
//        // init value for token
//        var accessToken = ""
//
//        //
//        //        // gets password from keychain
//        //        let keychain = Keychain(service: "api.fonzmusic.com")
//        //        let password = keychain[userEmail!]
//        //        // gets token by passing email + password into api
//        //        accessToken = SignInSignUpApi().loginUser(email: self.userEmail!, password: password!).message
//
//        guard let user = Auth.auth().currentUser else {
//            print("there was an error getting the user")
//            return  returnObject}
//
//            // get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
////                print("token is \(accessToken)" )
//                // create url
//                guard let url = URL(string: self.ADDRESS + self.CALLBACK + self.SPOTIFY  + "?code=" + authCode) else { return }
//
//                // creates req w url
//                var request = URLRequest(url: url)
//                // sets method as PUT
//                request.httpMethod = "GET"
////                // creates Param as Dictionary
////                let parameters = [
////                    "code": authCode
////                ]
////                // converts param dict to JSON DATA
////                let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
////                // adds JSON DATA to the body
////                request.httpBody = jsonData
//                // adds auth token
//                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//                // tells req that there is a body param
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//                // this is the request
//                URLSession.shared.dataTask(with: request) { data, response, error in
//                    // code to defer until this is completed
//                    defer { sem.signal() }
//
//                    if let dataResp = data {
//                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                        print(jsonData)
//
//                        returnCode = response?.getStatusCode() ?? 0
//
//                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
//                            // sets return value
////                            returnMessage = decodedResponse.message
//                        }
//                        else {
//                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
//
////                            returnMessage = decodedResponse!.message
//                        }
//                    } else {
//                        print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
//                    }
//                }.resume()
//            }else{
//                print("error")
//                //error handling
//            }
//        }
//        // tells function to wait before returning
//        sem.wait()
//        returnObject = BasicResponse(message: returnMessage, status: returnCode)
//        return returnObject
//    }
//
//    // api call to get the Coaster info
//    func sendAuthCodeToSpotify(authCode:String) -> BasicResponse {
//        // this allows us to wait before returning value
//        let sem = DispatchSemaphore.init(value: 0)
//
//        // init value for return
//        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
//        var returnMessage = ""
//        var returnCode = 0
//        // init value for token
//        var accessToken = ""
//
//
//
//        guard let user = Auth.auth().currentUser else {
//            print("there was an error getting the user")
//            return  returnObject}
//
////        accessToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFiMGNiMTk5Zjg3MGYyOGUyOTg5YWI0ODFjYzJlNDdlMGUyY2MxOWQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiZGlhcm11aWQiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDQuZ29vZ2xldXNlcmNvbnRlbnQuY29tLy13SER2YUF0TFpJcy9BQUFBQUFBQUFBSS9BQUFBQUFBQUFBQS9BTVp1dWNuekpiQm5PeG1rRXEzbjNwSXhPcFBzQ1F2dXZnL3M5Ni1jL3Bob3RvLmpwZyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9mb256LW11c2ljLWFwcCIsImF1ZCI6ImZvbnotbXVzaWMtYXBwIiwiYXV0aF90aW1lIjoxNjIzMjgxNTM4LCJ1c2VyX2lkIjoiRTJ1OWlyWm1rSGJGOWZQR1g3MmUwRVQyTXI5MiIsInN1YiI6IkUydTlpclpta0hiRjlmUEdYNzJlMEVUMk1yOTIiLCJpYXQiOjE2MjMyODE1MzgsImV4cCI6MTYyMzI4NTEzOCwiZW1haWwiOiJkaWFybXVpZDQ5QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7Imdvb2dsZS5jb20iOlsiMTA2NzY3ODIwOTgyOTg5ODg4NjQ2Il0sImVtYWlsIjpbImRpYXJtdWlkNDlAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.AWjfdh6Dw_6RfcltOVWAYdwTp5gmgXw1mTaCRmrJWS0byOlUJFiFhp6bIxui9DDzuOI2v_UQKC36KA39QBZw7GfsWzUXPIqZxLe0CfZ1is_7bM6DDnYLRKrdWT2z3S6_QQDBNGaWhzmFw8AKc1jFhhasTUUmHj3MOb7AOW0JlKYCf48DN_n72bijzChOGzMT2q30f4cW1nzRSFtGzQ6UgVmejyejieyLMhf5mbX31KFNA5ianCK15K98UOFKOxBRbwU6leFdL83OmLDbUFOPt2nJrFcZMCxeMX9ViBZIX6NulHfFRf6eFdjOIL1bo0psCQAPeWiW5yRC9FrQ2U2BFw"
//
//            // get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
////                print("token is \(accessToken)" )
//                // create url
//                guard let url = URL(string: self.ADDRESS + self.CALLBACK + self.SPOTIFY  + "?code=" + authCode) else { return }
//
//                // creates req w url
//                var request = URLRequest(url: url)
//                // sets method as PUT
//                request.httpMethod = "GET"
////                // creates Param as Dictionary
////                let parameters = [
////                    "code": authCode
////                ]
////                // converts param dict to JSON DATA
////                let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
////                // adds JSON DATA to the body
////                request.httpBody = jsonData
//                // adds auth token
//                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//                // tells req that there is a body param
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//                // this is the request
//                URLSession.shared.dataTask(with: request) { data, response, error in
//                    // code to defer until this is completed
//                    defer { sem.signal() }
//
//                    if let dataResp = data {
//                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                        print(jsonData)
//
//                        returnCode = response?.getStatusCode() ?? 0
//
//                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
//                            // sets return value
////                            returnMessage = decodedResponse.message
//                        }
//                        else {
//                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
//
////                            returnMessage = decodedResponse!.message
//                        }
//                    } else {
//                        print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
//                    }
//                }.resume()
//            }else{
//                print("error")
//                //error handling
//            }
//        }
//        // tells function to wait before returning
//        sem.wait()
//        returnObject = BasicResponse(message: returnMessage, status: returnCode)
//        return returnObject
//    }
    
//    // api call to get the Coaster info
//    func getRefreshToken(authCode:String) -> BasicResponse {
//        // this allows us to wait before returning value
//        let sem = DispatchSemaphore.init(value: 0)
//
//        // init value for return
//        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
//        var returnMessage = ""
//        var returnCode = 0
//        // init value for token
//        var accessToken = ""
//
//
//
//        guard let user = Auth.auth().currentUser else {
//            print("there was an error getting the user")
//            return  returnObject}
//
//
//                // create url
//                guard let url = URL(string: "") else { return BasicResponse}
//
//                // creates req w url
//                var request = URLRequest(url: url)
//                // sets method as PUT
//                request.httpMethod = "GET"
////                // creates Param as Dictionary
////                let parameters = [
////                    "code": authCode
////                ]
////                // converts param dict to JSON DATA
////                let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
////                // adds JSON DATA to the body
////                request.httpBody = jsonData
//                // adds auth token
//                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//                // tells req that there is a body param
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//                // this is the request
//                URLSession.shared.dataTask(with: request) { data, response, error in
//                    // code to defer until this is completed
//                    defer { sem.signal() }
//
//                    if let dataResp = data {
//                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                        print(jsonData)
//
//                        returnCode = response?.getStatusCode() ?? 0
//
//                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
//                            // sets return value
////                            returnMessage = decodedResponse.message
//                        }
//                        else {
//                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
//
////                            returnMessage = decodedResponse!.message
//                        }
//                    } else {
//                        print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
//                    }
//                }.resume()
//
//        // tells function to wait before returning
//        sem.wait()
//        returnObject = BasicResponse(message: returnMessage, status: returnCode)
//        return returnObject
//    }
//    
}

