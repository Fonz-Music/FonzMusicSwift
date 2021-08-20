//
//  SpotifySignInApi.swift
//  FonzMusicSwift
//
//  Created by didi on 6/9/21.
//

import SwiftUI
import Firebase

// all api functions inside
class SpotifyAuthApi {
    
//    let ADDRESS = "https://api.fonzmusic.com/"
    let ADDRESS = "https://beta.api.fonzmusic.com/"
//    let ADDRESS = "http://52.50.138.97:8080/"
    let CALLBACK = "callback/"
    let SESSION = "session/"
    let HOST = "host/"
    let SPOTIFY = "spotify/"
    let PROVIDERS = "providers/"
       
    
 
    
    
    // api call to get the Coaster info
    func getSpotifySignInUrl() -> String {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)

        // init value for return
        var returnMessage = ""
        var returnCode = 0
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.PROVIDERS + self.SPOTIFY + "?device=iOS" ) else { return returnMessage}
        // creates req w url
        var request = URLRequest(url: url)
        // sets method as PUT
        request.httpMethod = "GET"
        
        // adds auth token
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        // tells req that there is a body param
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // this is the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }

            if let dataResp = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData)

                // sets resp code
                returnCode = response?.getStatusCode() ?? 0

                if let decodedResponse = try? JSONDecoder().decode(SpotifyUrlResponse.self, from: dataResp) {
                    // sets return value
                    print("success")
                    returnMessage = decodedResponse.authorizeURL
//                            returnObject.responseCode = returnCode
//                            returnMessage = decodedResponse.message
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)

//                            returnMessage = decodedResponse!.message
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
        
    // tells function to wait before returning
    sem.wait()

    return returnMessage
    }
    
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
////
////        // gets password from keychain
////        let keychain = Keychain(service: "api.fonzmusic.com")
////        let password = keychain[userEmail!]
////        // gets token by passing email + password into api
////        accessToken = SignInSignUpApi().loginUser(email: self.userEmail!, password: password!).message
//
//
//        guard let user = Auth.auth().currentUser else {
//            print("there was an error getting the user")
//            return  returnObject}
//
////        accessToken = tempAccessToken
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
//                            let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
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
//                            let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
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

