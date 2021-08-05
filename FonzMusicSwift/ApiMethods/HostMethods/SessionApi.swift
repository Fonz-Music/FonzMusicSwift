//
//  HostFonzSessionApi.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import Foundation
import Firebase

// response for sessions
struct SessionResponse: Codable {
    var sessionId : String
    var userId : String
    var active : Bool
    var provider : String
}
// response for creating a session
struct CreateSessionResponse: Codable {
    var active : Bool
    var sessionId : String
    var userId : String
}

class SessionApi {
//    let ADDRESS = "https://api.fonzmusic.com/"
//    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
    let ADDRESS = "http://52.50.138.97:8080/"
    let HOST = "host/"
    let SESSION = "session/"
    let PROVIDERS = "providers/"
    let SPOTIFY = "spotify/"
    

    // api call to create a Fonz session (first time creating an account)
    func fetchSessionsAndCreateIfNone() -> BasicResponse {
        
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // init value for token
        var accessToken = ""
        // get access token
        accessToken = getJWTAndCheckIfExpired()
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
                print(jsonData as Any)
                
                returnCode = response?.getStatusCode() ?? 0
                print("returncode is \(returnCode)")
                if let decodedResponse = try? JSONDecoder().decode([SessionResponse].self, from: dataResp) {
                    print("success getting sessions")
                    if decodedResponse.count == 0 {
                        print("creating new session")
                        self.createSession()
                    }
                    else {
                        print("has sessions")
                        UserDefaults.standard.set(decodedResponse[0].sessionId, forKey: "userAccountSessionId")
                        returnMessage = "success"
                    }
                    sem.resume()
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                        
                    returnMessage = decodedResponse!.message
                    sem.resume()
                }
                
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
            sem.resume()
        }.resume()
        // tells function to wait before returning
        sem.wait()
        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        return returnObject
    }
    
    // api call to create a Fonz session (first time creating an account)
    func getAllSessions() -> [SessionResponse] {
        
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var sessionsObject: [SessionResponse] = [SessionResponse(sessionId: "", userId: "", active: false, provider: "")]
//        var returnMessage = ""
//        var returnCode = 0
        
        // init value for token
        var accessToken = ""
        // get access token
        accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.HOST + self.SESSION ) else { return sessionsObject}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        // this is the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData as Any)
                
                let returnCode = response?.getStatusCode() ?? 0
                print("returncode is \(returnCode)")
                if let decodedResponse = try? JSONDecoder().decode([SessionResponse].self, from: dataResp) {
                    print("success getting sessions")
                    if decodedResponse.count == 0 {
                        print("creating new session")
//                        self.createSession()
                    }
                    else {
                        print("has sessions")
                        UserDefaults.standard.set(decodedResponse[0].sessionId, forKey: "userAccountSessionId")
                    }
                    sessionsObject = decodedResponse
                    sem.resume()
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                        
//                    returnMessage = decodedResponse!.message
                    sem.resume()
                }
                
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
            sem.resume()
        }.resume()
        // tells function to wait before returning
        sem.wait()
//        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        return sessionsObject
    }
    
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
        // get access token
        accessToken = getJWTAndCheckIfExpired()
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
                print(jsonData as Any)
                
                returnCode = response?.getStatusCode() ?? 0
                print("returncode is \(returnCode)")
                if let decodedResponse = try? JSONDecoder().decode(CreateSessionResponse.self, from: dataResp) {
                    print("success creating provider")
                    UserDefaults.standard.set(decodedResponse.sessionId, forKey: "userAccountSessionId")
                    returnMessage = "success"
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                        
                    returnMessage = decodedResponse!.message
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
            sem.resume()
        }.resume()
        // tells function to wait before returning
        sem.wait()
        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        return returnObject
    }
    
    // api call to get a Fonz session
    func getSession(sessionId : String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // init value for token
        var accessToken = ""

            // get access token
        accessToken = getJWTAndCheckIfExpired()

                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.SESSION + sessionId ) else { return returnObject}
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                // this is the request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    // code to defer until this is completed
                    defer { sem.signal() }
                    
                    if let dataResp = data {
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                        print(jsonData as Any)
                        
                        returnCode = response?.getStatusCode() ?? 0
                        
                        if let decodedResponse = try? JSONDecoder().decode(SessionResponse.self, from: dataResp) {
                            print("success getting provider")
                            // sets return value
                            returnMessage = decodedResponse.sessionId
                            UserDefaults.standard.set(decodedResponse.sessionId, forKey: "userAccountSessionId")
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                                
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
    

    // fetch providers
    // then get provider at base 0
    // add that providerId to the session
    func addProviderToSession(sessionId:String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)

        // init value for return
        var providerObject: [Provider] = [Provider(displayName: "", provider: "", providerId: "", userId: "")]

        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.PROVIDERS ) else { return returnObject}

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
                        print("status code so far is \(response?.getStatusCode())")

                        if let decodedResponse = try? JSONDecoder().decode([Provider].self, from: dataResp) {
                            // sets return value
                            print("success")

                            providerObject = decodedResponse
                            let providerId = decodedResponse[0].providerId
                            UserDefaults.standard.set(decodedResponse[0].displayName, forKey: "spotifyDisplayName")
                            print("id is \(providerId)" )
//                            DispatchQueue.main.async {
                                // this allows us to wait before returning value
                                let semTwo = DispatchSemaphore.init(value: 0)
                                
                                guard let url = URL(string: self.ADDRESS + self.HOST + self.SESSION + sessionId ) else { return }

                                // creates req w url
                                var request = URLRequest(url: url)
                                // sets method as PUT
                                request.httpMethod = "PUT"
                                // creates Param as Dictionary
                                let parameters = [
                                    "active": "true",
                                    "providerId": providerId
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
    print("running 2nd call")
                                        returnCode = response?.getStatusCode() ?? 0

                                        if let decodedResponse = try? JSONDecoder().decode(AddProviderResponse.self, from: dataResp) {
                                            print("success here")
                                            // sets return value
                                            returnMessage = decodedResponse.message
                                        }
                                        else {
                                            let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)

                                            print("fail here")
                //                            returnMessage = decodedResponse!.message
                                        }
                                        
                                        sem.resume()
                                        
                                    } else {
                                        print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                                        sem.resume()
                                    }
                                    
                                }.resume()
                        
                        // tells function to wait before returning
//                        semTwo.wait()
                        returnObject = BasicResponse(message: returnMessage, status: returnCode)

//                            }
                    }
                    else {
                        let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)

//                            returnMessage = decodedResponse!.message
                    }
                } else {
                    print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                }
            }.resume()
            
        sem.wait()
        // tells function to wait before returning
        return returnObject
        
    }

    
    // api call to get the Coaster info
    func updateSessionProvider(sessionId: String, providerId: String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)

        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        
        // get access token
        let accessToken = getJWTAndCheckIfExpired()

        // create url
        guard let url = URL(string: self.ADDRESS + self.HOST + self.SESSION + sessionId )
        else {
//                    return
            return returnObject
        }

        // creates req w url
        var request = URLRequest(url: url)
        // sets method as PUT
        request.httpMethod = "PUT"
        // creates Param as Dictionary
        let parameters = [
            "providerId": providerId
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

                returnCode = response?.getStatusCode() ?? 0

                if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                    // sets return value
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
        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        return returnObject
    }
    
    
    
}
