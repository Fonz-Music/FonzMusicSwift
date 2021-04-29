//
//  HostCoasterApi.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//


import Foundation
import Firebase

struct BasicResponse: Codable {
    var message: String
    var status: Int
    var body: String
}
// ----------------------------------- Coaster Management -----------------------------
class HostCoasterApi {
    
    let ADDRESS = "https://api.fonzmusic.com/"
    let HOST = "host/"
    let COASTERS = "coasters/"
    

    // api call to get the Coaster info
    func getSingleOwnedCoaster(coasterUid:String) -> CoasterResult {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = CoasterResult(sessionId: "", displayName: "", coasterName: "", statusCode: 0)
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return  returnObject}

            // get access token
            user.getIDToken(){ (idToken, error) in
            if error == nil, let token = idToken {
                accessToken = token
//                print("token is \(accessToken)" )
                // set UID to uppercase
                let uid = coasterUid.uppercased()
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS + uid ) else { return }
                
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
                        if let decodedResponse = try? JSONDecoder().decode(CoasterResult.self, from: dataResp) {
                            
                            // creates new coasterResult from return value
                            let newCoaster = CoasterResult(sessionId: decodedResponse.sessionId, displayName: decodedResponse.displayName, coasterName:  decodedResponse.coasterName, statusCode: 200 )
                            print("newCoaster " + "\(newCoaster)")
                            // sets return value
                            returnObject = newCoaster
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                                // creates new coasterResult from return value
                            let newCoaster = CoasterResult(sessionId: "", displayName: "", coasterName:  "", statusCode: decodedResponse?.status ?? 0 )
                                print("newCoaster " + "\(newCoaster)")
                                // sets return value
                                returnObject = newCoaster
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
        return returnObject
    }
    
    // api call to get all coasters linked to the host
    func getOwnedCoasters() -> [CoasterResult] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = [CoasterResult(sessionId: "", displayName: "", coasterName: "", statusCode: 0)]
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return  returnObject}

            // get access token
            user.getIDToken(){ (idToken, error) in
            if error == nil, let token = idToken {
                accessToken = token
//                print("token is \(accessToken)" )
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS ) else { return }
                
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
                        if let decodedResponse = try? JSONDecoder().decode([CoasterResult].self, from: dataResp) {
                            
                            // creates new coasterResult from return value
//                            let newCoaster = CoasterResult(sessionId: decodedResponse.sessionId, displayName: decodedResponse.displayName, coasterName:  decodedResponse.coasterName, statusCode: 200 )
//                            print("newCoaster " + "\(newCoaster)")
                            // sets return value
                            returnObject = decodedResponse
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                                // creates new coasterResult from return value
                            let newCoaster = [CoasterResult(sessionId: "", displayName: "", coasterName:  "", statusCode: decodedResponse?.status ?? 0 )]
                                print("newCoaster " + "\(newCoaster)")
                                // sets return value
                                returnObject = newCoaster
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
        return returnObject
    }
    
    // api call to add a coaster
    func addCoaster(coasterUid:String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = BasicResponse(message: "error", status: 400, body: "something brok")
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return returnObject}

            // get access token
            user.getIDToken(){ (idToken, error) in
            if error == nil, let token = idToken {
                accessToken = token
//                print("token is \(accessToken)" )
                // set UID to uppercase
                let uid = coasterUid.uppercased()
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS + uid ) else { return }
                
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
                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                            
                            // creates new coasterResult from return value
//                            let newCoaster = BasicResponse(message: decodedResponse., status: <#T##Int#>, body: <#T##String#>)
//                            print("newCoaster " + "\(newCoaster)")
                            // sets return value
                            returnObject = decodedResponse
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                                // creates new coasterResult from return value
//
                            let resp = BasicResponse(message: decodedResponse?.message ?? "", status: decodedResponse?.status ?? 400, body: "something broke")
                            // sets return value
                            returnObject = resp
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
        return returnObject
    }
    
    // api call to rename a coaster
    func renameCoaster(coasterUid:String, newName:String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = BasicResponse(message: "error", status: 400, body: "something brok")
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return returnObject}
            print("got user")
            // get access token
            user.getIDToken(){ (idToken, error) in
            if error == nil, let token = idToken {
                accessToken = token
//                accessToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjRlOWRmNWE0ZjI4YWQwMjUwNjRkNjY1NTNiY2I5YjMzOTY4NWVmOTQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiZGlkaSIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHZ2EyQmxHR3NCYVVweXZlYldwdm1wZ2lCX0ZUUXhCWWRER2x2MjBndz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9mb256LW11c2ljLWFwcCIsImF1ZCI6ImZvbnotbXVzaWMtYXBwIiwiYXV0aF90aW1lIjoxNjE0NDY2NzcwLCJ1c2VyX2lkIjoiSWpxVURQNVJKOVdHbkpZbFpYQXJLRmJINzk2MiIsInN1YiI6IklqcVVEUDVSSjlXR25KWWxaWEFyS0ZiSDc5NjIiLCJpYXQiOjE2MTk3MjM3NDEsImV4cCI6MTYxOTcyNzM0MSwiZW1haWwiOiJkaWFybXVpZG1jZ29uYWdsZUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwODQwNTQ0NjMzMDM4NzM1OTU0NiJdLCJhcHBsZS5jb20iOlsiMDAwODcxLjJlMGM1MDViZWFiNjQwNjM5Yjc4NTM2ZThlYWQwMDIwLjIzMjkiXSwiZW1haWwiOlsiZGlhcm11aWRtY2dvbmFnbGVAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.VsYNcXZgfUa1v9tY8jYoSCx-6ifny6lRuK38u48Mg4oxitmCS5zE3jpJWfvSMrokzSq6xvZwYBHnSstuujsj6b4dzCOWaNGkNie93QE_au5LwV4inrzHSXKIhdRKOefyguXTddvuwIQiarUwUR9w3FgNI3-0_cVSW7ikk2AlcV_2hTcCPIxcjLkIYjrVcnN2BU3ZvCsayjig6snazmDnV7JWM9MFEroKPKOnoYEL-BMgD6yDOjCJ8EqCWdHa6MWgYnRY1sHex71tN9hcW1GaIwFhLgiWJWREIHRMW9DcJN66T4j3O-s4XqfXQV9nS3_LAjVpekkLFCwM_GNj_FGteA"
//                print("token is \(accessToken)" )
                // set UID to uppercase
                let uid = coasterUid.uppercased()
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS + uid ) else { return }
                // creates req w url
                var request = URLRequest(url: url)
                // sets method as PUT
                request.httpMethod = "PUT"
                // creates Param as Dictionary
                let parameters = [
                    "name": newName
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
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                        print(jsonData)
                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                            
                            // creates new coasterResult from return value
//                            let newCoaster = BasicResponse(message: decodedResponse., status: <#T##Int#>, body: <#T##String#>)
//                            print("newCoaster " + "\(newCoaster)")
                            // sets return value
                            returnObject = decodedResponse
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                                // creates new coasterResult from return value
//
                            let resp = BasicResponse(message: decodedResponse?.message ?? "", status: decodedResponse?.status ?? 400, body: "something broke")
                            // sets return value
                            returnObject = resp
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
        return returnObject
    }
    
    // api call to pause a coaster
    func pauseCoaster(coasterUid:String, paused:Bool) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = BasicResponse(message: "error", status: 400, body: "something brok")
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return returnObject}

            // get access token
            user.getIDToken(){ (idToken, error) in
            if error == nil, let token = idToken {
                accessToken = token
//                print("token is \(accessToken)" )
                // set UID to uppercase
                let uid = coasterUid.uppercased()
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS + uid ) else { return }
                // creates req w url
                var request = URLRequest(url: url)
                // sets method as PUT
                request.httpMethod = "PUT"
                // creates Param as Dictionary
                let parameters = [
                    "active": paused
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
                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                            
                            // creates new coasterResult from return value
//                            let newCoaster = BasicResponse(message: decodedResponse., status: <#T##Int#>, body: <#T##String#>)
//                            print("newCoaster " + "\(newCoaster)")
                            // sets return value
                            returnObject = decodedResponse
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                                // creates new coasterResult from return value
//
                            let resp = BasicResponse(message: decodedResponse?.message ?? "", status: decodedResponse?.status ?? 400, body: "something broke")
                            // sets return value
                            returnObject = resp
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
        return returnObject
    }
    
    // api call to disconnect a coaster
    func disconnectCoaster(coasterUid:String) {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = BasicResponse(message: "error", status: 400, body: "something brok")
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return }

            // get access token
            user.getIDToken(){ (idToken, error) in
            if error == nil, let token = idToken {
                accessToken = token
//                print("token is \(accessToken)" )
                // set UID to uppercase
                let uid = coasterUid.uppercased()
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS + uid ) else { return }
                
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                // this is the request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    // code to defer until this is completed
                    defer { sem.signal() }
                }.resume()
            }else{
                print("error")
                //error handling
            }
        }
        // tells function to wait before returning
        sem.wait()

    }
}

