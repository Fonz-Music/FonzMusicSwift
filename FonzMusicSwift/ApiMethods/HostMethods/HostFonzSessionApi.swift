//
//  HostFonzSessionApi.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import Foundation
import Firebase

class HostFonzSessionApi {
    let ADDRESS = "https://api.fonzmusic.com/"
    let HOST = "host/"
    let SESSION = "session/"
    let PROVIDERS = "providers/"
    let SPOTIFY = "spotify/"
    
    let tempToken = ""
    
    // api call to create a Fonz session (first time creating an account)
    func createSession() -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return returnObject}

            // get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
//                print("token is \(accessToken)" )
        accessToken = tempToken
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.SESSION ) else { return returnObject}
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                // this is the request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    // code to defer until this is completed
                    defer { sem.signal() }
                    
                    if let dataResp = data {
//                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                        print(jsonData)
                        
                        returnCode = response?.getStatusCode() ?? 0
                        
                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                            
                            returnMessage = decodedResponse.message
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                            returnMessage = decodedResponse!.message
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
        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        return returnObject
    }
    
    // api call to get a Fonz session
    func getSessionId() -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return returnObject}

            // get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
//                print("token is \(accessToken)" )
        accessToken = tempToken
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.SESSION ) else { return returnObject}
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                // this is the request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    // code to defer until this is completed
                    defer { sem.signal() }
                    
                    if let dataResp = data {
//                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                        print(jsonData)
                        
                        returnCode = response?.getStatusCode() ?? 0
                        
                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                            
                            // sets return value
                            returnMessage = decodedResponse.message
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                            // sets return value
                            returnMessage = decodedResponse!.message
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
        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        return returnObject
    }
    
    // api call to update the session provider
    func updateSessionProvider(sessionId:String, authId:String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return returnObject}

            // get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
//                print("token is \(accessToken)" )
                accessToken = tempToken
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.SESSION + sessionId) else { return returnObject}
                // creates req w url
                var request = URLRequest(url: url)
                // sets method as PUT
                request.httpMethod = "PUT"
                // creates Param as Dictionary
                let parameters: [String: Any] = [
                    "active": true,
                    "authenticationId": authId
                ]
                // converts param dict to JSON DATA
                let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
                // adds JSON DATA to the body
                request.httpBody = jsonData
                // adds auth token
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                // tells req that there is a body param
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                // this is the request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    // code to defer until this is completed
                    defer { sem.signal() }
                    
                    if let dataResp = data {
//                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                        print(jsonData)
                        
                        returnCode = response?.getStatusCode() ?? 0
                        
                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                            
                            // sets return value
                            returnMessage = decodedResponse.message
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                            // sets return value
                            returnMessage = decodedResponse!.message
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
        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        return returnObject
    }
    
    // api call to get a the Music provider
    func getMusicProvider() -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return returnObject}

            // get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
//                print("token is \(accessToken)" )
                accessToken = tempToken
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.PROVIDERS ) else { return returnObject}
                
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
                        
                        returnCode = response?.getStatusCode() ?? 0
                        
                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                            
                            // sets return value
                            returnMessage = decodedResponse.message
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                            // sets return value
                            returnMessage = decodedResponse!.message
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
        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        return returnObject
    }
    
    // api call to remove a the Music provider
    func removeSpotifyProvider() -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return returnObject}

            // get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
                accessToken = tempToken
//                print("token is \(accessToken)" )
                
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.PROVIDERS + self.SPOTIFY ) else { return returnObject}
                
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                // this is the request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    // code to defer until this is completed
                    defer { sem.signal() }
                    
                    if let dataResp = data {
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                        print(jsonData)
                        
                        returnCode = response?.getStatusCode() ?? 0
                        
                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                            
                            // sets return value
                            returnMessage = decodedResponse.message
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                            // sets return value
                            returnMessage = decodedResponse!.message
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
        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        return returnObject
    }
    
}
