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
}
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
    
    let ADDRESS = "https://api.fonzmusic.com/"
    let HOST = "host/"
    let COASTERS = "coasters/"
    

    // api call to get the Coaster info
    func getSingleOwnedCoaster(coasterUid:String) -> CoasterResult {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = CoasterResult(sessionId: "", displayName: "", coasterName: "", coasterActive: false, coasterPaused: false, statusCode: 0)
        
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
                            let newCoaster = CoasterResult(sessionId: decodedResponse.sessionId, displayName: decodedResponse.displayName, coasterName:  decodedResponse.coasterName, coasterActive: decodedResponse.coasterActive, coasterPaused: decodedResponse.coasterPaused, statusCode: 200 )
                            print("newCoaster " + "\(newCoaster)")
                            // sets return value
                            returnObject = newCoaster
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
                                // creates new coasterResult from return value
                            let newCoaster = CoasterResult(sessionId: "", displayName: "", coasterName:  "", coasterActive: false, coasterPaused: false, statusCode: decodedResponse?.status ?? 0 )
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
    func getOwnedCoasters() -> HostCoastersMapResult {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject = HostCoastersMapResult(coasters: [], quantity: 0)
//        var returnObject = HostCoastersMapResult(quantity: 0)
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return  returnObject}

            // get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
        accessToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjRlOWRmNWE0ZjI4YWQwMjUwNjRkNjY1NTNiY2I5YjMzOTY4NWVmOTQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiZGlkaSIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHZ2EyQmxHR3NCYVVweXZlYldwdm1wZ2lCX0ZUUXhCWWRER2x2MjBndz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9mb256LW11c2ljLWFwcCIsImF1ZCI6ImZvbnotbXVzaWMtYXBwIiwiYXV0aF90aW1lIjoxNjE0NDY2NzcwLCJ1c2VyX2lkIjoiSWpxVURQNVJKOVdHbkpZbFpYQXJLRmJINzk2MiIsInN1YiI6IklqcVVEUDVSSjlXR25KWWxaWEFyS0ZiSDc5NjIiLCJpYXQiOjE2MTk3OTA4NTIsImV4cCI6MTYxOTc5NDQ1MiwiZW1haWwiOiJkaWFybXVpZG1jZ29uYWdsZUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwODQwNTQ0NjMzMDM4NzM1OTU0NiJdLCJhcHBsZS5jb20iOlsiMDAwODcxLjJlMGM1MDViZWFiNjQwNjM5Yjc4NTM2ZThlYWQwMDIwLjIzMjkiXSwiZW1haWwiOlsiZGlhcm11aWRtY2dvbmFnbGVAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.lcYE4yBaoWXcisnpGWT_ZxfqIB1WOHiiD00o7qDCaRa6zRV_XYZ37fPKEVG8nz6jL49C4kfmjRQGMfyuV_G8_ezcq-NCgvmmwEGsacVVFnI9Ub5hUhO4jXtcxyj9s8-r84R84WKbUIcw_PHz-gvAXvnZggTd2JvyWJ3F9Bkxiop5U7tdGdx4baJMEqW2O_UpoLn8xGVhumkhho2WEG0CuYrnk1UHSqkr2nmVo9m0or9ZJ_HQnDeQQmrFL2-lDR_2LqKiyXHlQ6nFYByb3bZg2Xco_0ursA21SVuF7I0GyOEnW7PlMWAxXS1ePW05BMQfzhqzgvVj817_E253UeCy6g"
//                print("token is \(accessToken)" )
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
                        print(jsonData)
                        if let decodedResponse = try? JSONDecoder().decode(HostCoastersMapResult.self, from: dataResp) {
                            print("\(decodedResponse)")
                            // creates new coasterResult from return value
//                            let newCoaster = CoasterResult(sessionId: decodedResponse.sessionId, displayName: decodedResponse.displayName, coasterName:  decodedResponse.coasterName, statusCode: 200 )
//                            print("newCoaster " + "\(newCoaster)")
                            // sets return value
                            returnObject = decodedResponse
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(ErrorResult.self, from: dataResp)
                                
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
//            }else{
//                print("error")
//                //error handling
//            }
//        }
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
        
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return returnObject}

            // get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
        accessToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjRlOWRmNWE0ZjI4YWQwMjUwNjRkNjY1NTNiY2I5YjMzOTY4NWVmOTQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiZGlkaSIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHZ2EyQmxHR3NCYVVweXZlYldwdm1wZ2lCX0ZUUXhCWWRER2x2MjBndz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9mb256LW11c2ljLWFwcCIsImF1ZCI6ImZvbnotbXVzaWMtYXBwIiwiYXV0aF90aW1lIjoxNjE0NDY2NzcwLCJ1c2VyX2lkIjoiSWpxVURQNVJKOVdHbkpZbFpYQXJLRmJINzk2MiIsInN1YiI6IklqcVVEUDVSSjlXR25KWWxaWEFyS0ZiSDc5NjIiLCJpYXQiOjE2MTk3OTA4NTIsImV4cCI6MTYxOTc5NDQ1MiwiZW1haWwiOiJkaWFybXVpZG1jZ29uYWdsZUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwODQwNTQ0NjMzMDM4NzM1OTU0NiJdLCJhcHBsZS5jb20iOlsiMDAwODcxLjJlMGM1MDViZWFiNjQwNjM5Yjc4NTM2ZThlYWQwMDIwLjIzMjkiXSwiZW1haWwiOlsiZGlhcm11aWRtY2dvbmFnbGVAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.lcYE4yBaoWXcisnpGWT_ZxfqIB1WOHiiD00o7qDCaRa6zRV_XYZ37fPKEVG8nz6jL49C4kfmjRQGMfyuV_G8_ezcq-NCgvmmwEGsacVVFnI9Ub5hUhO4jXtcxyj9s8-r84R84WKbUIcw_PHz-gvAXvnZggTd2JvyWJ3F9Bkxiop5U7tdGdx4baJMEqW2O_UpoLn8xGVhumkhho2WEG0CuYrnk1UHSqkr2nmVo9m0or9ZJ_HQnDeQQmrFL2-lDR_2LqKiyXHlQ6nFYByb3bZg2Xco_0ursA21SVuF7I0GyOEnW7PlMWAxXS1ePW05BMQfzhqzgvVj817_E253UeCy6g"
//                print("token is \(accessToken)" )
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
                        print(jsonData)
                        print("code is \(response?.getStatusCode())")
                        
                        returnCode = response?.getStatusCode() ?? 0
                        
                        if let decodedResponse = try? JSONDecoder().decode(MessageResponse.self, from: dataResp) {
                            
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
    
    // api call to rename a coaster
    func renameCoaster(coasterUid:String, newName:String) -> BasicResponse {
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
            print("got user")
            // get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
        accessToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjRlOWRmNWE0ZjI4YWQwMjUwNjRkNjY1NTNiY2I5YjMzOTY4NWVmOTQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiZGlkaSIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHZ2EyQmxHR3NCYVVweXZlYldwdm1wZ2lCX0ZUUXhCWWRER2x2MjBndz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9mb256LW11c2ljLWFwcCIsImF1ZCI6ImZvbnotbXVzaWMtYXBwIiwiYXV0aF90aW1lIjoxNjE0NDY2NzcwLCJ1c2VyX2lkIjoiSWpxVURQNVJKOVdHbkpZbFpYQXJLRmJINzk2MiIsInN1YiI6IklqcVVEUDVSSjlXR25KWWxaWEFyS0ZiSDc5NjIiLCJpYXQiOjE2MTk3OTA4NTIsImV4cCI6MTYxOTc5NDQ1MiwiZW1haWwiOiJkaWFybXVpZG1jZ29uYWdsZUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwODQwNTQ0NjMzMDM4NzM1OTU0NiJdLCJhcHBsZS5jb20iOlsiMDAwODcxLjJlMGM1MDViZWFiNjQwNjM5Yjc4NTM2ZThlYWQwMDIwLjIzMjkiXSwiZW1haWwiOlsiZGlhcm11aWRtY2dvbmFnbGVAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.lcYE4yBaoWXcisnpGWT_ZxfqIB1WOHiiD00o7qDCaRa6zRV_XYZ37fPKEVG8nz6jL49C4kfmjRQGMfyuV_G8_ezcq-NCgvmmwEGsacVVFnI9Ub5hUhO4jXtcxyj9s8-r84R84WKbUIcw_PHz-gvAXvnZggTd2JvyWJ3F9Bkxiop5U7tdGdx4baJMEqW2O_UpoLn8xGVhumkhho2WEG0CuYrnk1UHSqkr2nmVo9m0or9ZJ_HQnDeQQmrFL2-lDR_2LqKiyXHlQ6nFYByb3bZg2Xco_0ursA21SVuF7I0GyOEnW7PlMWAxXS1ePW05BMQfzhqzgvVj817_E253UeCy6g"
//                print("token is \(accessToken)" )
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
                        
                        returnCode = response?.getStatusCode() ?? 0
                        
                        if let decodedResponse = try? JSONDecoder().decode(NameCoasterResponse.self, from: dataResp) {

                            // sets return value
                            returnMessage = decodedResponse.name
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
    
    // api call to pause a coaster
    func pauseCoaster(coasterUid:String, paused:Bool) -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        print("got here")
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
        accessToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjRlOWRmNWE0ZjI4YWQwMjUwNjRkNjY1NTNiY2I5YjMzOTY4NWVmOTQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiZGlkaSIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHZ2EyQmxHR3NCYVVweXZlYldwdm1wZ2lCX0ZUUXhCWWRER2x2MjBndz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9mb256LW11c2ljLWFwcCIsImF1ZCI6ImZvbnotbXVzaWMtYXBwIiwiYXV0aF90aW1lIjoxNjE0NDY2NzcwLCJ1c2VyX2lkIjoiSWpxVURQNVJKOVdHbkpZbFpYQXJLRmJINzk2MiIsInN1YiI6IklqcVVEUDVSSjlXR25KWWxaWEFyS0ZiSDc5NjIiLCJpYXQiOjE2MTk3OTA4NTIsImV4cCI6MTYxOTc5NDQ1MiwiZW1haWwiOiJkaWFybXVpZG1jZ29uYWdsZUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwODQwNTQ0NjMzMDM4NzM1OTU0NiJdLCJhcHBsZS5jb20iOlsiMDAwODcxLjJlMGM1MDViZWFiNjQwNjM5Yjc4NTM2ZThlYWQwMDIwLjIzMjkiXSwiZW1haWwiOlsiZGlhcm11aWRtY2dvbmFnbGVAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.lcYE4yBaoWXcisnpGWT_ZxfqIB1WOHiiD00o7qDCaRa6zRV_XYZ37fPKEVG8nz6jL49C4kfmjRQGMfyuV_G8_ezcq-NCgvmmwEGsacVVFnI9Ub5hUhO4jXtcxyj9s8-r84R84WKbUIcw_PHz-gvAXvnZggTd2JvyWJ3F9Bkxiop5U7tdGdx4baJMEqW2O_UpoLn8xGVhumkhho2WEG0CuYrnk1UHSqkr2nmVo9m0or9ZJ_HQnDeQQmrFL2-lDR_2LqKiyXHlQ6nFYByb3bZg2Xco_0ursA21SVuF7I0GyOEnW7PlMWAxXS1ePW05BMQfzhqzgvVj817_E253UeCy6g"
//                print("token is \(accessToken)" )
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
                    "paused": paused
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
    
    // api call to disconnect a coaster
    func disconnectCoaster(coasterUid:String) {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
            
        // init value for token
        var accessToken = ""

        guard let user = Auth.auth().currentUser else {
            print("there was an error getting the user")
            return }

            // get access token
//            user.getIDToken(){ (idToken, error) in
//            if error == nil, let token = idToken {
//                accessToken = token
        accessToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjRlOWRmNWE0ZjI4YWQwMjUwNjRkNjY1NTNiY2I5YjMzOTY4NWVmOTQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiZGlkaSIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS0vQU9oMTRHZ2EyQmxHR3NCYVVweXZlYldwdm1wZ2lCX0ZUUXhCWWRER2x2MjBndz1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9mb256LW11c2ljLWFwcCIsImF1ZCI6ImZvbnotbXVzaWMtYXBwIiwiYXV0aF90aW1lIjoxNjE0NDY2NzcwLCJ1c2VyX2lkIjoiSWpxVURQNVJKOVdHbkpZbFpYQXJLRmJINzk2MiIsInN1YiI6IklqcVVEUDVSSjlXR25KWWxaWEFyS0ZiSDc5NjIiLCJpYXQiOjE2MTk3OTA4NTIsImV4cCI6MTYxOTc5NDQ1MiwiZW1haWwiOiJkaWFybXVpZG1jZ29uYWdsZUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwODQwNTQ0NjMzMDM4NzM1OTU0NiJdLCJhcHBsZS5jb20iOlsiMDAwODcxLjJlMGM1MDViZWFiNjQwNjM5Yjc4NTM2ZThlYWQwMDIwLjIzMjkiXSwiZW1haWwiOlsiZGlhcm11aWRtY2dvbmFnbGVAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.lcYE4yBaoWXcisnpGWT_ZxfqIB1WOHiiD00o7qDCaRa6zRV_XYZ37fPKEVG8nz6jL49C4kfmjRQGMfyuV_G8_ezcq-NCgvmmwEGsacVVFnI9Ub5hUhO4jXtcxyj9s8-r84R84WKbUIcw_PHz-gvAXvnZggTd2JvyWJ3F9Bkxiop5U7tdGdx4baJMEqW2O_UpoLn8xGVhumkhho2WEG0CuYrnk1UHSqkr2nmVo9m0or9ZJ_HQnDeQQmrFL2-lDR_2LqKiyXHlQ6nFYByb3bZg2Xco_0ursA21SVuF7I0GyOEnW7PlMWAxXS1ePW05BMQfzhqzgvVj817_E253UeCy6g"
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
//            }else{
//                print("error")
//                //error handling
//            }
//        }
        // tells function to wait before returning
        sem.wait()

    }
}

