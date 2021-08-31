//
//  UserApi.swift
//  FonzMusicSwift
//
//  Created by didi on 8/5/21.
//

import Foundation

struct UpdateUserResponse: Codable, Hashable {
    var displayName: String
    var email: String
    var userId: String
    var agreedMarketing: Bool
}


class UserApi {
    let ADDRESS = "https://beta.api.fonzmusic.com/"
//    let ADDRESS = "http://52.50.138.97:8080/"
    let AUTH = "auth/"
    
    // api call to register user
    func updateUserAccount(email: String, password: String, displayName: String, agreedConsent : Bool, agreedMarketing : Bool) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // init value for token
        let accessToken = getJWTAndCheckIfExpired()
        
        // create url
        guard let url = URL(string: self.ADDRESS + "user") else { return returnObject}
        // creates req w url
        var request = URLRequest(url: url)
        // sets method as PUT
        request.httpMethod = "PUT"
        // creates Param as Dictionary
        let parameters = [
            "displayName": displayName,
            "email": email,
            "password": password,
            "agreedConsent": agreedConsent,
            "agreedMarketing": agreedMarketing
        ] as [String : Any]
        // converts param dict to JSON DATA
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
        // adds JSON DATA to the body
        request.httpBody = jsonData
        // tells req that there is a body param
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // add token
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        // this is the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData)
                
                returnCode = response?.getStatusCode() ?? 0
               
                if let decodedResponse = try? JSONDecoder().decode(UpdateUserResponse.self, from: dataResp) {

                    print("worked")
                    

                    UserDefaults.standard.set(decodedResponse.displayName, forKey: "userDisplayName")
                    UserDefaults.standard.set(decodedResponse.email, forKey: "userEmail")
                    UserDefaults.standard.set(decodedResponse.userId, forKey: "userId")
                    UserDefaults.standard.set(decodedResponse.agreedMarketing, forKey: "agreedToEmail")
                    
                    
                    
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
    // api call to register user
    func getUserAccount() -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // init value for token
        let accessToken = getJWTAndCheckIfExpired()
        
        // create url
        guard let url = URL(string: self.ADDRESS + "user") else { return returnObject}
        // creates req w url
        var request = URLRequest(url: url)
        // sets method as PUT
        request.httpMethod = "GET"
        // tells req that there is a body param
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // add token
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        // this is the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData)
                
                returnCode = response?.getStatusCode() ?? 0
               
                if let decodedResponse = try? JSONDecoder().decode(UpdateUserResponse.self, from: dataResp) {

                    print("worked")
                    

                    UserDefaults.standard.set(decodedResponse.displayName, forKey: "userDisplayName")
                    UserDefaults.standard.set(decodedResponse.email, forKey: "userEmail")
                    UserDefaults.standard.set(decodedResponse.userId, forKey: "userId")
                    UserDefaults.standard.set(decodedResponse.agreedMarketing, forKey: "agreedToEmail")
                    
                    
                    
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
    // api call to register user
    func updateUserDisplayName( displayName: String ) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // init value for token
        let accessToken = getJWTAndCheckIfExpired()
        
        // create url
        guard let url = URL(string: self.ADDRESS + "user") else { return returnObject}
        // creates req w url
        var request = URLRequest(url: url)
        // sets method as PUT
        request.httpMethod = "PUT"
        // creates Param as Dictionary
        let parameters = [
            "displayName": displayName,
        ] as [String : Any]
        // converts param dict to JSON DATA
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
        // adds JSON DATA to the body
        request.httpBody = jsonData
        // tells req that there is a body param
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // add token
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        // this is the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonData)
                
                returnCode = response?.getStatusCode() ?? 0
               
                if let decodedResponse = try? JSONDecoder().decode(UpdateUserResponse.self, from: dataResp) {

                    print("worked")
                    

                    UserDefaults.standard.set(decodedResponse.displayName, forKey: "userDisplayName")
                    UserDefaults.standard.set(decodedResponse.email, forKey: "userEmail")
                    UserDefaults.standard.set(decodedResponse.userId, forKey: "userId")
                    UserDefaults.standard.set(decodedResponse.agreedMarketing, forKey: "agreedToEmail")
                    
                    
                    
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
}
