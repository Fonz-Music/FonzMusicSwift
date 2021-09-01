//
//  HostCoasterApi.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//


import Foundation
import Firebase
import KeychainAccess


struct MessageResponse: Codable {
    var message: String
}
struct NameCoasterResponse: Codable {
    var name: String
}
// response for getting the coasters
struct CoasterResponse: Codable {
    var active: Bool
    var coasterId: String
    var name: String
    var group: String?
    var encoded: Bool
//    var displayName: String
    var statusCode: Int?
}


extension URLResponse {

    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

// ----------------------------------- Coaster Management -----------------------------
class HostCoastersApi {
    
    let ADDRESS = "https://beta.api.fonzmusic.com/"
//        let ADDRESS = "http://52.50.138.97:8080/"
    let HOST = "host/"
    let COASTERS = "coasters/"
    
    let userEmail = UserDefaults.standard.string(forKey: "userEmail")
    

    // api call to get the Coaster info
    func getSingleOwnedCoaster(coasterUid:String) -> CoasterResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = CoasterResponse(active: false, coasterId: "", name: "", group: "", encoded: false)
        
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
            

//        print("token is \(accessToken)" )
        // set UID to uppercase
        let uid = coasterUid.uppercased()
        // create url
        guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS + uid ) else { return returnObject}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        // this is the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("msg from host api")
                        print(jsonData)
                
                returnObject.statusCode = response?.getStatusCode() ?? 0
                
                if let decodedResponse = try? JSONDecoder().decode(CoasterResponse.self, from: dataResp) {
                    
                    // creates new coasterResult from return value
                    let newCoaster = decodedResponse
//                    print("newCoaster " + "\(newCoaster)")
                    // sets return value
                    returnObject = newCoaster
                    returnObject.statusCode = response?.getStatusCode() ?? 0
                    print("newCoaster " + "\(returnObject)")
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                        print("failed")
                    returnObject.statusCode = 404
                        // creates new coasterResult from return value
//                    let newCoaster = CoasterResult(sessionId: "", displayName: "", coasterName:  "", coasterActive: false,  statusCode: decodedResponse?.status ?? 0 )
//                        print("newCoaster " + "\(newCoaster)")
//                        // sets return value
//                        returnObject = newCoaster
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
        // tells function to wait before returning
        sem.wait()
        return returnObject
    }
    
    // api call to get all coasters linked to the host
    func getOwnedCoasters() -> HostCoastersMapResult {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = HostCoastersMapResult(coasters: [], quantity: 0)
//        var returnObject = HostCoastersMapResult(quantity: 0)
        
        // gets accessToken & checks to see if expired
        let accessToken = getJWTAndCheckIfExpired()
                // create url
            guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS ) else { return returnObject}
            
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
                    if let decodedResponse = try? JSONDecoder().decode(HostCoastersMapResult.self, from: dataResp) {
                        print("\(decodedResponse)")
                        // creates new coasterResult from return value
//                            let newCoaster = CoasterResult(sessionId: decodedResponse.sessionId, displayName: decodedResponse.displayName, coasterName:  decodedResponse.coasterName, statusCode: 200 )
//                            print("newCoaster " + "\(newCoaster)")
                        // sets return value
                        returnObject = decodedResponse
                    }
                    else {
                        let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                            
                            // creates new coasterResult from return value
//                            let newCoaster = [CoasterResult(sessionId: "", displayName: "", coasterName:  "", statusCode: decodedResponse?.status ?? 0 )]
//                                print("newCoaster " + "\(newCoaster)")
                            // sets return value
//                                returnObject = decodedResponse
                    }
                } else {
                    print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                }
            }.resume()
        // tells function to wait before returning
        sem.wait()
        return returnObject
    }
    
    // api call to add a coaster
    func addCoaster(coasterUid:String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
       
        // gets accessToken & checks to see if expired
        let accessToken = getJWTAndCheckIfExpired()
        // set UID to uppercase
        let uid = coasterUid.uppercased()
        // create url
        guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS + uid ) else { return returnObject}
        
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
                print("code is \(String(describing: response?.getStatusCode()))")
                
                returnCode = response?.getStatusCode() ?? 0
                
                if let decodedResponse = try? JSONDecoder().decode(MessageResponse.self, from: dataResp) {
                    
                    // sets return value
                    returnMessage = decodedResponse.message
                }
                else if let decodedResponse = try? JSONDecoder().decode(BasicResponseWithCode.self, from: dataResp) {
                    if decodedResponse.code == "COASTER_NO_HOST" {
                        returnCode = 204
                    }
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)

                    if decodedResponse != nil {
                        // sets return value
                        returnMessage = decodedResponse!.message
                    }
                    
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
    
    // api call to rename a coaster
    func renameCoaster(coasterUid:String, newName:String) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        
        // gets accessToken & checks to see if expired
        let accessToken = getJWTAndCheckIfExpired()
        // set UID to uppercase
        let uid = coasterUid.uppercased()
        // create url
        guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS + uid ) else { return returnObject}
        // creates req w url
        var request = URLRequest(url: url)
        // sets method as PUT
        request.httpMethod = "PUT"
        // creates Param as Dictionary
        let parameters = [
            "name": newName,
        ] as [String : Any]
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
                print(jsonData as Any)
                
                returnCode = response?.getStatusCode() ?? 0
                
                if let decodedResponse = try? JSONDecoder().decode(NameCoasterResponse.self, from: dataResp) {

                    // sets return value
                    returnMessage = decodedResponse.name
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                        
                
                    if decodedResponse != nil {
                        // sets return value
                        returnMessage = decodedResponse!.message
                    }
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
    
    // api call to pause a coaster
    func pauseCoaster(coasterUid:String, active:Bool) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        print("got here")
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0
        // gets accessToken & checks to see if expired
        let accessToken = getJWTAndCheckIfExpired()
        // set UID to uppercase
        let uid = coasterUid.uppercased()
        // create url
        guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS + uid ) else { return returnObject}
        // creates req w url
        var request = URLRequest(url: url)
        // sets method as PUT
        request.httpMethod = "PUT"
        // creates Param as Dictionary
        let parameters = [
            "active": active
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
                print(jsonData as Any)
                
                returnCode = response?.getStatusCode() ?? 0
                
                if let decodedResponse = try? JSONDecoder().decode(BasicResponse.self, from: dataResp) {
                    
                    if decodedResponse != nil {
                        // sets return value
                        returnMessage = decodedResponse.message
                    }
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                        
                    if decodedResponse != nil {
                        // sets return value
                        returnMessage = decodedResponse!.message
                    }
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
    
    // api call to disconnect a coaster
    func disconnectCoaster(coasterUid:String) -> Int {
        
        var returnCode : Int = 0
        
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
            
        // gets accessToken & checks to see if expired
        let accessToken = getJWTAndCheckIfExpired()
        // set UID to uppercase
        let uid = coasterUid.uppercased()
        // create url
        guard let url = URL(string: self.ADDRESS + self.HOST + self.COASTERS + uid ) else { return returnCode}
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        // this is the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            returnCode = response?.getStatusCode() ?? 0
            
            // code to defer until this is completed
            defer { sem.signal() }
        }.resume()

        // tells function to wait before returning
        sem.wait()
        return returnCode

    }
}

