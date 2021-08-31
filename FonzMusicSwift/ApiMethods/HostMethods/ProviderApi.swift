//
//  ProviderApi.swift
//  FonzMusicSwift
//
//  Created by didi on 8/5/21.
//

import Foundation





class ProviderApi {
//    let ADDRESS = "https://api.fonzmusic.com/"
    let ADDRESS = "https://beta.api.fonzmusic.com/"
//        let ADDRESS = "http://52.50.138.97:8080/"
    let HOST = "host/"
    let SESSION = "session/"
    let PROVIDERS = "providers/"
    let SPOTIFY = "spotify/"
    
    // api call to get music providers
    func getMusicProviders() -> [Provider] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)

        // init value for return
        var providerObject: [Provider] = [Provider]()

        
        var returnMessage = ""
        var returnCode = 0
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
                // create url
        guard let url = URL(string: self.ADDRESS + self.PROVIDERS ) else { return providerObject}

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

                if let decodedResponse = try? JSONDecoder().decode([Provider].self, from: dataResp) {
                    // sets return value
                    print("success")
                    print("decoded resp is \(decodedResponse)")
                    providerObject = decodedResponse
                    UserDefaults.standard.set(decodedResponse[0].displayName, forKey: "spotifyDisplayName")
                    let spotEmail = fetchEmailFromSpotifyAdditional(additionalText: decodedResponse[0].additional)
                    print("spot email is \(spotEmail)")
                    UserDefaults.standard.set(spotEmail, forKey: "spotifyEmail")
                }
//                else {
//                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
//                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
        // tells function to wait before returning
        sem.wait()
        
        return providerObject
    }
    
    // api call to remove a the Music provider
    func removeSpotifyProvider() -> BasicResponse {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        var returnObject: BasicResponse = BasicResponse(message: "", status: 0)
        var returnMessage = ""
        var returnCode = 0

        // get access token
        let accessToken = getJWTAndCheckIfExpired()
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
        return returnObject
    }
}
