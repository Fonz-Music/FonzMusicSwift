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

extension URLResponse {

    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

// ----------------------------------- Coaster Management -----------------------------
class HostCoasterApi {
    
    //    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
        let ADDRESS = "http://52.50.138.97:8080/"
    let HOST = "host/"
    let COASTERS = "coasters/"
    
//    let tempToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg4ZGYxMzgwM2I3NDM2NjExYWQ0ODE0NmE4ZGExYjA3MTg2ZmQxZTkiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9mb256LW11c2ljLWFwcCIsImF1ZCI6ImZvbnotbXVzaWMtYXBwIiwiYXV0aF90aW1lIjoxNjE5MjkyODM5LCJ1c2VyX2lkIjoiRFpuOUp0dVo4Zlo5QVdxZGo0NUl0UXhwMXM1MyIsInN1YiI6IkRabjlKdHVaOGZaOUFXcWRqNDVJdFF4cDFzNTMiLCJpYXQiOjE2MjQ2NjE0MDgsImV4cCI6MTYyNDY2NTAwOCwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6e30sInNpZ25faW5fcHJvdmlkZXIiOiJhbm9ueW1vdXMifX0.EK_k8XuSm_nRGAb0uajNssPiHWgryP8zNg4-65JnjuoQonp6gl_29pxb6Ed9CXkWd-1AA169jNZknH4uqHFgSmZfBE78SRjsJBUJm5_xMlFMBGVKKfkeUKOW1OGyKipcvH7yrxTH0-kpGhYsA3eFN-_Ge9b_24MZbT1YxSg6mIgMKuFW_dMlqoMBAxDXMEOqAckKQhqPHTuzf4TAJHr2Ty9ijJuJds9bROKXF_kfIS_1qaEa3v9uPPukVMYuQlqYBycHWQxztltODAjbLl-GXpdxamK7ArtH-7I579ywCcP3Y6V6cmgpJhyCCGeuPmoOZWhVTI8m6gWkDqZTpgxdgw"
    
    let userEmail = UserDefaults.standard.string(forKey: "userEmail")
    

    // api call to get the Coaster info
    func getSingleOwnedCoaster(coasterUid:String) -> CoasterResult {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = CoasterResult(sessionId: "", displayName: "", coasterName: "", coasterActive: false, statusCode: 0)
        
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
            

        print("token is \(accessToken)" )
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
//                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                        print(jsonData)
                if let decodedResponse = try? JSONDecoder().decode(CoasterResult.self, from: dataResp) {
                    
                    // creates new coasterResult from return value
                    let newCoaster = CoasterResult(sessionId: decodedResponse.sessionId, displayName: decodedResponse.displayName, coasterName:  decodedResponse.coasterName, coasterActive: decodedResponse.coasterActive,  statusCode: 200 )
                    print("newCoaster " + "\(newCoaster)")
                    // sets return value
                    returnObject = newCoaster
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                        
                        // creates new coasterResult from return value
                    let newCoaster = CoasterResult(sessionId: "", displayName: "", coasterName:  "", coasterActive: false,  statusCode: decodedResponse?.status ?? 0 )
                        print("newCoaster " + "\(newCoaster)")
                        // sets return value
                        returnObject = newCoaster
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
            "active" : true
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
    func pauseCoaster(coasterUid:String, paused:Bool) -> BasicResponse {
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

