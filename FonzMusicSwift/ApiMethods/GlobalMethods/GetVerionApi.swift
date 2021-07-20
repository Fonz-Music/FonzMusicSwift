//
//  GetVerion.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//


import SwiftUI
import Firebase

// all api functions inside
class GetVersionApi {
    
    //    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
    let ADDRESS = "http://52.50.138.97:8080/"
    let VERSION = "version/"
  

    // api call to get the Coaster info
    func getMinVersion(device:String) -> String {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // init value for return
        
        var versionNumber = ""

//                // create url
                guard let url = URL(string: self.ADDRESS + self.VERSION + "?device=" + device) else { return ""}
        // create url
//        guard let url = URL(string: self.ADDRESS + "?device=" + device) else { return ""}
                
                // creates req w url
                var request = URLRequest(url: url)
                // sets method as PUT
                request.httpMethod = "GET"
                // tells req that there is a body param
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                // this is the request
                URLSession.shared.dataTask(with: request) { data, response, error in
                    // code to defer until this is completed
                    defer { sem.signal() }
                    
                    if let dataResp = data {
                        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
                        print(jsonData)
                        
//                        versionNumber = jsonData["minimumAppVersion"]
                        
                        if let decodedResponse = try? JSONDecoder().decode(VersionResponse.self, from: dataResp) {
                            print("success \(decodedResponse)")
                            // sets return value
                            versionNumber = decodedResponse.minimumAppVersion
                        }
                        else {
                            let decodedResponse = try? JSONDecoder().decode(VersionResponse.self, from: dataResp)
                            print("fail \(decodedResponse)")
//                            returnMessage = decodedResponse!.message
                        }
                    } else {
                        print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
                    }
                }.resume()
            
        // tells function to wait before returning
        sem.wait()
        return versionNumber
    }
    
}
