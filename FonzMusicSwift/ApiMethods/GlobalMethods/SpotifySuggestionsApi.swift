//
//  SpotifySuggestions.swift
//  FonzMusicSwift
//
//  Created by didi on 8/4/21.
//

import Foundation
import SwiftUI

// artist return Object
struct ArtistResponse: Codable {
    var name: String
    var id: String
    var images: Array<ImageArray>
}

// playlist return Object
struct PlaylistResponse: Codable {
    var name: String
    var id: String
    var images: Array<ImageArray>
    var tracks : TotalTracksInPlaylist
}
struct TotalTracksInPlaylist: Codable {
    var total: Int
}

struct ItemsFromPlaylist: Codable {
    var items: Array<TracksInPlaylist>
}
//struct ItemInPlayList: Codable {
//
//}
struct TracksInPlaylist: Codable {
    var is_local: Bool
    var added_at: String
    var track: TrackInPlaylist
}
struct TrackInPlaylist: Codable {
    var artists: Array<ArtistArray>
    var name: String
    var id: String
    var album: Album
    var external_urls: ExternalUrl
}


class SpotifySuggestionsApi {
    
//    let ADDRESS = "https://api.fonzmusic.com/"
    let ADDRESS = "https://beta.api.fonzmusic.com/"
//    let ADDRESS = "http://52.50.138.97:8080/"
    let GUEST = "guest/"
    let SPOTIFY = "spotify/"
    let SEARCH = "search/"
    
    func getGuestTopSongs(sessionId: String) -> [Track] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        // return
        var tracks : [Track] = [Track]()
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
//                print(jsonData)

                // sets resp code
//                returnCode = response?.getStatusCode() ?? 0

                print("code is \(response?.getStatusCode() ?? 0)")
                
                
                if let decodedResponse = try? JSONDecoder().decode([Items].self, from: dataResp) {
                    // sets return value
                    print("success")
//                    print("decoded resp is \(decodedResponse)")
                    tracks = itemsToTracks(tracks: decodedResponse)
                   
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("error")
//                            returnMessage = decodedResponse?.message ?? "error"
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
    // tells function to wait before returning
    sem.wait()

    return tracks
    }
    
    func getNewSongReleases(sessionId: String) -> [Track] {
//        print("sessio id is \(sessionId)")
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        // return
        var tracks : [Track] = [Track]()
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
                    tracks = itemsToTracks(tracks: decodedResponse)
                   
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("error")
//                            returnMessage = decodedResponse?.message ?? "error"
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
    // tells function to wait before returning
    sem.wait()

    return tracks
    }
    
    func getGuestTopArtists(sessionId: String) -> [Artist] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        var artists = [Artist]()
        if sessionId == "" {
            return artists
        }
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.GUEST + sessionId + "/" + self.SPOTIFY + self.SEARCH + "top?type=artists" ) else { return artists }
        print("address is \(url)")
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
//                print(jsonData)

                // sets resp code
//                returnCode = response?.getStatusCode() ?? 0

                print("code is \(response?.getStatusCode() ?? 0)")
                
                
                if let decodedResponse = try? JSONDecoder().decode([ArtistResponse].self, from: dataResp) {
                    // sets return value
                    print("success")
//                    print("decoded resp is \(decodedResponse)")
                    if decodedResponse.count > 1 {
                        artists = artistResponseToArtist(artistResps: decodedResponse)
                    }
                    
//                    providerObject = decodedResponse
                   
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("error")
//                            returnMessage = decodedResponse?.message ?? "error"
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
    // tells function to wait before returning
    sem.wait()

    return artists
    }
    
    func getGuestTopPlaylists(sessionId: String) -> [Playlist] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        var playlists = [Playlist]()
        if sessionId == "" {
            return playlists
        }
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.GUEST + sessionId + "/" + self.SPOTIFY + self.SEARCH + "top?type=playlists" ) else { return playlists}
        print("address is \(url)")
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
//                print(jsonData)

                // sets resp code
//                returnCode = response?.getStatusCode() ?? 0

                print("code is \(response?.getStatusCode() ?? 0)")
                
                
                if let decodedResponse = try? JSONDecoder().decode([PlaylistResponse].self, from: dataResp) {
                    // sets return value
                    print("success")
                    print("decoded resp is \(decodedResponse)")
                    if decodedResponse.count > 1 {
                        playlists = playlistResponseToPlaylist(playlistResps: decodedResponse)
                    }

                    
                   
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("error")
//                            returnMessage = decodedResponse?.message ?? "error"
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
    // tells function to wait before returning
    sem.wait()
    return playlists
    //return providerObject
    }
    
    func getTracksByArtist(sessionId: String, artistId: String) -> [Track] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        // return
        var tracks : [Track] = [Track]()
        if artistId == "" {
            print("artistId is empty")
            return tracks
        }
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.GUEST + sessionId + "/" + self.SPOTIFY + self.SEARCH + "artist/" + artistId ) else { return tracks}
//        print("url is \(url)")
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
//                print(jsonData)

                // sets resp code
//                returnCode = response?.getStatusCode() ?? 0

                print("code is \(response?.getStatusCode() ?? 0)")
                
                
                if let decodedResponse = try? JSONDecoder().decode([Items].self, from: dataResp) {
                    // sets return value
                    print("success")
//                    print("decoded resp is \(decodedResponse)")
                    tracks = itemsToTracks(tracks: decodedResponse)
                   
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("error")
//                            returnMessage = decodedResponse?.message ?? "error"
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
    // tells function to wait before returning
    sem.wait()

    return tracks
    }
    
    func getTracksByPlaylist(sessionId: String, playlistId: String) -> [Track] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        // return
        var tracks : [Track] = [Track]()
        if playlistId == "" {
            print("playlistId is empty")
            return tracks
        }
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        guard let url = URL(string: self.ADDRESS + self.GUEST + sessionId + "/" + self.SPOTIFY + self.SEARCH + "playlist/" + playlistId ) else { return tracks}
//        print("url is \(url)")
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
//                print(jsonData)

                // sets resp code
//                returnCode = response?.getStatusCode() ?? 0

                print("code is \(response?.getStatusCode() ?? 0)")
                
                
                if let decodedResponse = try? JSONDecoder().decode(ItemsFromPlaylist.self, from: dataResp) {
                    // sets return value
                    print("success")
//                    print("decoded resp is \(decodedResponse)")
                    tracks  = playlistTracksToTracks(playlistResps: decodedResponse)
                   
                }
                else {
                    let decodedResponse = try? JSONDecoder().decode(ErrorResponse.self, from: dataResp)
                    print("error")
//                            returnMessage = decodedResponse?.message ?? "error"
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
    
    // tells function to wait before returning
    sem.wait()

    return tracks
    }
    
}
