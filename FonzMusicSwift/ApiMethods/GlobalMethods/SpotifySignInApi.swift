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
    
    let ADDRESS = "https://api.fonzmusic.com/"
    //    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
//        let ADDRESS = "http://52.50.138.97:8080/"
    let CALLBACK = "callback/"
    let SESSION = "session/"
    let HOST = "host/"
    let SPOTIFY = "spotify"
    let PROVIDERS = "providers"
    
    let tempAccessToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijc3MTBiMDE3ZmQ5YjcxMWUwMDljNmMzNmIwNzNiOGE2N2NiNjgyMTEiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiZGVlciIsInBpY3R1cmUiOiJodHRwczovL2xoNC5nb29nbGV1c2VyY29udGVudC5jb20vLXdIRHZhQXRMWklzL0FBQUFBQUFBQUFJL0FBQUFBQUFBQUFBL0FNWnV1Y256SmJCbk94bWtFcTNuM3BJeE9wUHNDUXZ1dmcvczk2LWMvcGhvdG8uanBnIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2ZvbnotbXVzaWMtYXBwIiwiYXVkIjoiZm9uei1tdXNpYy1hcHAiLCJhdXRoX3RpbWUiOjE2MjY3MDQxNjgsInVzZXJfaWQiOiJFMnU5aXJabWtIYkY5ZlBHWDcyZTBFVDJNcjkyIiwic3ViIjoiRTJ1OWlyWm1rSGJGOWZQR1g3MmUwRVQyTXI5MiIsImlhdCI6MTYyNjcwOTcyMywiZXhwIjoxNjI2NzEzMzIzLCJlbWFpbCI6ImRpYXJtdWlkNDlAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiZGlhcm11aWQ0OUBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.X8oRBcId1Su944dhLie9ga56B57wN4-5vWk9V4KowUU2iYhqLPxEtO2QNRt5kxmh0g5IMS5qWwZ4VK3GryfdNCfu1UzDWd1-bMoZ2JIC4Ze8Gpr0dSk5VUlg-PdRfEdw2vlcBzgcoLpdfyFEBTEWPrOZoZlj2HepVcDsUDc327fK-klsUzlGIJrgCCSKJdj2CKp8YfYejz_yPyNxJVQvZ8iJT4rOgC_AVV34epdw89vNyC2beInx1b808cplcrFq3frWlSenH3Ld-QtqTgtNayyfAym48bkSfCOMnF1ynJxDX1p6_wRDbDLhOkemFmQdpV6Cw4NuKT9YQOdDh51y1A"
    
    func addSpotifyToAccount(sessionId:String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)

        // init value for return
        var providerObject: ProviderResponse = ProviderResponse(providers: [Provider(display_name: "", id: "", provider: "", spotifyId: "")]
//                                                              , responseCode: 0
        )
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        // init value for token
        var accessToken = ""

//
//        // gets password from keychain
//        let keychain = Keychain(service: "api.fonzmusic.com")
//        let password = keychain[userEmail!]
//        // gets token by passing email + password into api
//        accessToken = SignInSignUpApi().loginUser(email: self.userEmail!, password: password!).message

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return  returnObject}

        accessToken = tempAccessToken
//                print("token is \(accessToken)" )
                // create url
        guard let url = URL(string: self.ADDRESS + self.HOST + self.PROVIDERS ) else { return returnObject}

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

                        if let decodedResponse = try? JSONDecoder().decode(ProviderResponse.self, from: dataResp) {
                            // sets return value
                            print("success")
                            providerObject.providers = decodedResponse.providers
                            let providerId = decodedResponse.providers[0].id
                            print("id is \(providerId)" )
                            DispatchQueue.main.async {
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
                                    "authenticationId": providerId
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
                                    defer { semTwo.signal() }

                                    if let dataResp = data {
                                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                                        print(jsonData)
    print("running 2nd call")
                                        returnCode = response?.getStatusCode() ?? 0

                                        if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                                            print("success here")
                                            // sets return value
                //                            returnMessage = decodedResponse.message
                                        }
                                        else {
                                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)

                                            print("fail here")
                //                            returnMessage = decodedResponse!.message
                                        }
                                    } else {
                                        print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                                    }
                                }.resume()
                        
                        // tells function to wait before returning
                        semTwo.wait()
                        returnObject = BasicResponse(message: returnMessage, status: returnCode)
    //                            returnObject.responseCode = returnCode
    //                            returnMessage = decodedResponse.message
                            }
                    }
                    else {
                        let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)

//                            returnMessage = decodedResponse!.message
                    }
                } else {
                    print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                }
            }.resume()
            
        // tells function to wait before returning
        return returnObject
        sem.wait()
    }

    
    // api call to get the Coaster info
    func updateSpotifyProvider(sessionId: String, providerId: String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)

        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        // init value for token
        var accessToken = ""

//
//        // gets password from keychain
//        let keychain = Keychain(service: "api.fonzmusic.com")
//        let password = keychain[userEmail!]
//        // gets token by passing email + password into api
//        accessToken = SignInSignUpApi().loginUser(email: self.userEmail!, password: password!).message

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return  returnObject}

            // get access token
            user.getIDToken(){ (idToken, error) in
            if error == nil, let token = idToken {
                accessToken = token
//                print("token is \(accessToken)" )
                // create url
                guard let url = URL(string: self.ADDRESS + self.HOST + self.SESSION + sessionId ) else { return }

                // creates req w url
                var request = URLRequest(url: url)
                // sets method as PUT
                request.httpMethod = "PUT"
                // creates Param as Dictionary
                let parameters = [
                    "authenticationId": providerId
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
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)

//                            returnMessage = decodedResponse!.message
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
        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        return returnObject
    }
    
    // api call to get the Coaster info
    func getMusicProviders() -> ProviderResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)

        // init value for return
        var returnObject: ProviderResponse = ProviderResponse(providers: [Provider(display_name: "", id: "", provider: "", spotifyId: "")]
//                                                              , responseCode: 0
        )
        var returnMessage = ""
        var returnCode = 0
        // init value for token
        var accessToken = ""

//
//        // gets password from keychain
//        let keychain = Keychain(service: "api.fonzmusic.com")
//        let password = keychain[userEmail!]
//        // gets token by passing email + password into api
//        accessToken = SignInSignUpApi().loginUser(email: self.userEmail!, password: password!).message

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return  returnObject}

        accessToken = tempAccessToken
//                print("token is \(accessToken)" )
                // create url
        guard let url = URL(string: self.ADDRESS + self.HOST + self.PROVIDERS ) else { return returnObject}

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

                        if let decodedResponse = try? JSONDecoder().decode(ProviderResponse.self, from: dataResp) {
                            // sets return value
                            print("success")
                            returnObject.providers = decodedResponse.providers
//                            returnObject.responseCode = returnCode
//                            returnMessage = decodedResponse.message
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)

//                            returnMessage = decodedResponse!.message
                        }
                    } else {
                        print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                    }
                }.resume()
            
        // tells function to wait before returning
        sem.wait()
        
        return returnObject
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

