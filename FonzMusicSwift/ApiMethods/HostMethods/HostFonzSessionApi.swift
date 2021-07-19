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
    
    let tempToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFiYjk2MDVjMzZlOThlMzAxMTdhNjk1MTc1NjkzODY4MzAyMDJiMmQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiZGVlciIsInBpY3R1cmUiOiJodHRwczovL2xoNC5nb29nbGV1c2VyY29udGVudC5jb20vLXdIRHZhQXRMWklzL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUFBL0FNWnV1Y256SmJCbk94bWtFcTNuM3BJeE9wUHNDUXZ1dmcvczk2LWMvcGhvdG8uanBnIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2ZvbnotbXVzaWMtYXBwIiwiYXVkIjoiZm9uei1tdXNpYy1hcHAiLCJhdXRoX3RpbWUiOjE2MjY3MDk3MjQsInVzZXJfaWQiOiJFMnU5aXJabWtIYkY5ZlBHWDcyZTBFVDJNcjkyIiwic3ViIjoiRTJ1OWlyWm1rSGJGOWZQR1g3MmUwRVQyTXI5MiIsImlhdCI6MTYyNjcxMzM1NCwiZXhwIjoxNjI2NzE2OTU0LCJlbWFpbCI6ImRpYXJtdWlkNDlAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiZGlhcm11aWQ0OUBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.jlOhvrIAhKzmOGzMfmyDOGzp078se8YfX5H4tWzQy4Pt1TseE2Ii5EpBuMi6srev4qeABg-ErhYpzkTLvUG5zmwLDXkRoJQg_-mqyE1UFR795rhCp0imV2nnbuoDNo3CdIgNit_3165YVSeWF2TPa9ArsJwqi4I63jFiv3KJsV4_BAKpxl02VNNYq72UVH15JBp74qRJzmL7FueglG65UcMF0Gs7PoCZBdkZVqfo3eDeOYvcJ6flKMP_wmimA-Iu_j7G1LiI6-Ny_MWmLgDvlGrjnEGOEPNImVDP-xVdLZQTK-WBybUmqsrjxbDs4cPd5nVddOZ8JQqeLzABhFqCjw"
    
    
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
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                        print(jsonData)
                
                returnCode = response?.getStatusCode() ?? 0
                print("returncode is \(returnCode)")
                if returnCode == 403 {
                    let sessionId = UserDefaults.standard.string(forKey: "userAccountSessionId")
                    if sessionId == nil || sessionId == "" {
                        DispatchQueue.main.async {
                            self.getSessionId()
                        }
                        
                    }
                    print("session from user def is \(sessionId)")
//                    DispatchQueue.main.async {
//                        guard let url = URL(string: self.ADDRESS + self.HOST + self.SESSION ) else { return }
//
//                        var request = URLRequest(url: url)
//                        request.httpMethod = "GET"
//                        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//                        // this is the request
//                        URLSession.shared.dataTask(with: request) { data, response, error in
//                            // code to defer until this is completed
//                            defer { sem.signal() }
//
//                            if let dataResp = data {
//                                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                                print(jsonData)
//
//                                returnCode = response?.getStatusCode() ?? 0
//
//                                if let decodedResponse = try? JSONDecoder().decode(SessionResponse.self, from: dataResp) {
//                                    print("success getting provider")
//                                    // sets return value
////                                    returnMessage = decodedResponse
//                                    UserDefaults.standard.set(decodedResponse.sessionId, forKey: "userAccountSessionId")
//                                }
//                                else {
//                                    let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
//
//                                    // sets return value
////                                    returnMessage = decodedResponse!.message
//                                }
//                            } else {
//                                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
//                            }
//                        }.resume()
//
//                // tells function to wait before returning
////                semTwo.wait()
//                returnObject = BasicResponse(message: returnMessage, status: returnCode)
//
//
//                    }
                }
                
                else if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                    print("success creating provider")
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
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                        print(jsonData)
                        
                        returnCode = response?.getStatusCode() ?? 0
                        
                        if let decodedResponse = try? JSONDecoder().decode(SessionResponse.self, from: dataResp) {
                            print("success getting provider")
                            // sets return value
//                                    returnMessage = decodedResponse
                            UserDefaults.standard.set(decodedResponse.sessionId, forKey: "userAccountSessionId")
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                            // sets return value
//                                    returnMessage = decodedResponse!.message
                        }
                    } else {
                        print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                    }
                }.resume()

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
