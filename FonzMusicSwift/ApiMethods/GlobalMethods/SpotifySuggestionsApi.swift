//
//  SpotifySuggestions.swift
//  FonzMusicSwift
//
//  Created by didi on 8/4/21.
//

import Foundation
import SwiftUI

class SpotifySuggestionsApi {
    
//    let ADDRESS = "https://api.fonzmusic.com/"
//    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
    let ADDRESS = "http://52.50.138.97:8080/"
    let GUEST = "guest/"
    let SPOTIFY = "spotify/"
    let SEARCH = "search/"
    
    func getGuestTopSongs(sessionId: String) -> [Items] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        // return
        var tracks : [Items] = [Items(album: Album(images: [ImageArray(url: "")]), artists: [ArtistArray(name: "")], name: "", id: "", external_urls: ExternalUrl(spotify: ""))]
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.GUEST + sessionId + "/" + self.SPOTIFY + self.SEARCH + "top?type=tracks" ) else { return tracks }
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
//                returnCode = response?.getStatusCode() ?? 0

                print("code is \(response?.getStatusCode() ?? 0)")
                
                
                if let decodedResponse = try? JSONDecoder().decode([Items].self, from: dataResp) {
                    // sets return value
                    print("success")
                    print("decoded resp is \(decodedResponse)")
                    tracks = decodedResponse
                   
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("error")
//                            returnMessage = decodedResponse!.message
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
    // tells function to wait before returning
    sem.wait()

    return tracks
    }
    
    func getNewSongReleases(sessionId: String) -> [Items] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        // return
        var tracks : [Items] = [Items(album: Album(images: [ImageArray(url: "")]), artists: [ArtistArray(name: "")], name: "", id: "", external_urls: ExternalUrl(spotify: ""))]
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.GUEST + sessionId + "/" + self.SPOTIFY + self.SEARCH + "releases" ) else { return tracks}
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
//                returnCode = response?.getStatusCode() ?? 0

                print("code is \(response?.getStatusCode() ?? 0)")
                
                
                if let decodedResponse = try? JSONDecoder().decode([Items].self, from: dataResp) {
                    // sets return value
                    print("success")
                    print("decoded resp is \(decodedResponse)")
                    tracks = decodedResponse
                   
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("error")
//                            returnMessage = decodedResponse!.message
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
    // tells function to wait before returning
    sem.wait()

    return tracks
    }
    
    func getGuestTopArtists(userId: String) {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.GUEST + userId + "/" + self.SPOTIFY + self.SEARCH + "top?type=artists" ) else { return }
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
//                returnCode = response?.getStatusCode() ?? 0

                print("code is \(response?.getStatusCode() ?? 0)")
                
                
                if let decodedResponse = try? JSONDecoder().decode([TracksResult].self, from: dataResp) {
                    // sets return value
                    print("success")
                    print("decoded resp is \(decodedResponse)")
//                    providerObject = decodedResponse
                   
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("error")
//                            returnMessage = decodedResponse!.message
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
    // tells function to wait before returning
    sem.wait()

    //return providerObject
    }
    
    func getGuestTopPlaylists(userId: String) {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.GUEST + userId + "/" + self.SPOTIFY + self.SEARCH + "top?type=playlists" ) else { return }
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
//                returnCode = response?.getStatusCode() ?? 0

                print("code is \(response?.getStatusCode() ?? 0)")
                
                
                if let decodedResponse = try? JSONDecoder().decode([TracksResult].self, from: dataResp) {
                    // sets return value
                    print("success")
                    print("decoded resp is \(decodedResponse)")
//                    providerObject = decodedResponse
                   
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("error")
//                            returnMessage = decodedResponse!.message
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
    // tells function to wait before returning
    sem.wait()

    //return providerObject
    }
    
    func getTracksByArtist(userId: String, artistId: String) {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.GUEST + userId + "/" + self.SPOTIFY + self.SEARCH + "artist/" + artistId ) else { return }
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
//                returnCode = response?.getStatusCode() ?? 0

                print("code is \(response?.getStatusCode() ?? 0)")
                
                
                if let decodedResponse = try? JSONDecoder().decode([TracksResult].self, from: dataResp) {
                    // sets return value
                    print("success")
                    print("decoded resp is \(decodedResponse)")
//                    providerObject = decodedResponse
                   
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("error")
//                            returnMessage = decodedResponse!.message
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
    // tells function to wait before returning
    sem.wait()

    //return providerObject
    }
    
}
