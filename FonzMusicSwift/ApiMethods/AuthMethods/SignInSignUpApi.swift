//
//  SignInSignUpApi.swift
//  FonzMusicSwift
//
//  Created by didi on 7/8/21.
//

import SwiftUI
//import Security
import KeychainAccess



struct AuthResponse: Codable, Hashable {
    var accessToken: String
    var email: String
    var userId: String
}

struct SignInResponse: Codable, Hashable {
    var accessToken: String
//    var email: String
//    var userId: String
}


class SignInSignUpApi {
//    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
    let ADDRESS = "http://52.50.138.97:8080/"
    let AUTH = "auth/"
    
    
    // api call to register user
    func registerUser(email: String, password: String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // create url
        guard let url = URL(string: self.ADDRESS + self.AUTH + "register") else { return returnObject}
        // creates req w url
        var request = URLRequest(url: url)
        // sets method as PUT
        request.httpMethod = "POST"
        // creates Param as Dictionary
        let parameters = [
            "email": email,
            "password": password
        ]
        // converts param dict to JSON DATA
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
        // adds JSON DATA to the body
        request.httpBody = jsonData
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
               
                if let decodedResponse = try? JSONDecoder().decode(AuthResponse.self, from: dataResp) {

                    print("worked")
                    
//                    let accessToken = decodedResponse.accessToken
                    let email = decodedResponse.email
                    DispatchQueue.main.async {
                        // creates email + password as dict to store in keychain
                        let keychain = Keychain(service: "api.fonzmusic.com")
                        do {
                            try keychain
                                .label("fonzMusicApi")
                                .set(password, key: email)
                        } catch let error {
                            print("error: \(error)")
                        }
                        
                        // creates accessToken as dict to store in keychain
                        let keychainAccess = Keychain(service: "api.fonzmusic.com")
                        do {
                            try keychainAccess
                                .label("fonzMusicApiAcesssToken")
                                .set(decodedResponse.accessToken, key: "accessToken")
                        } catch let error {
                            print("error: \(error)")
                        }
//                        keychain[email] = password
//
                        UserDefaults.standard.set(email, forKey: "userEmail")
                        returnMessage = decodedResponse.accessToken
                        returnCode = 200
//
//                        if status == 0 {
//                            // sets return value
//                            returnMessage = "login success"
//                            returnCode = 200
//                        }
//                        else {
//                            // sets return value
//                            returnMessage = "something went wrong"
//                            returnCode = 1
//                        }
                    }
                    
                    
                    
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("didnt worked")
                
                    // sets return value
                    returnMessage = decodedResponse!.message
                }
                
                
                
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()

        // tells function to wait before returning
        sem.wait()
        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        print("return msg is \(returnObject)")
        return returnObject
        
    }

    
    // api call to login user
    func loginUser(email: String, password: String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        print("starting this")
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // create url
        guard let url = URL(string: self.ADDRESS + self.AUTH + "login") else { return returnObject}
        // creates req w url
        var request = URLRequest(url: url)
        // sets method as PUT
        request.httpMethod = "POST"
        // creates Param as Dictionary
        let parameters = [
            "email": email,
            "password": password
        ]
        // converts param dict to JSON DATA
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
        // adds JSON DATA to the body
        request.httpBody = jsonData
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
                print("returnCode is \(returnCode)")
                
                if let decodedResponse = try? JSONDecoder().decode(SignInResponse.self, from: dataResp) {

                    returnMessage = decodedResponse.accessToken
                    UserDefaults.standard.set(email, forKey: "userEmail")
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)

                    // sets return value
                    returnMessage = decodedResponse!.message
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()

        // tells function to wait before returning
        sem.wait()
        returnObject = BasicResponse(message: returnMessage, status: returnCode)
        print("return msg is \(returnObject)")
        return returnObject
        
    }
}


//guard let data = data,
//                       let response = response as? HTTPURLResponse,
//                       error == nil else {                                              // check for fundamental networking error
//                       print("error", error ?? "Unknown error")
//                       return
//                   }
//
//                   guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
//                       print("statusCode should be 2xx, but is \(response.statusCode)")
//                       print("response = \(response)")
//                       return
//                   }
//
//                   let responseString = String(data: data, encoding: .utf8)
//                   print("responseString = \(responseString)")
