//
//  SpotifyPaginatedApi.swift
//  FonzMusicSwift
//
//  Created by didi on 8/27/21.
//

import Foundation

// all api functions inside
class SpotifyPaginatedApi {
//    let ADDRESS = "https://api.fonzmusic.com/"
    let ADDRESS = "https://beta.api.fonzmusic.com/"
    let GUEST = "guest/"
    let SPOTIFY = "spotify/"
    let SEARCH = "search/"

    func searchSessionPaginated(sessionId:String, searchTerm:String, offset:Int) -> [TrackForPagination] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        // init vale for access token
        var accessToken = ""
        var products: [TrackForPagination] = []
        // get access token
        accessToken = getJWTAndCheckIfExpired()
        // replaces spaces with underscore
        let searchSong = searchTerm.replacingOccurrences(of: " ", with: "_")
        
//                accessToken = token
        // set URL
        let offsetString = "&offset=" + String(offset) + "&limit=20"
        guard let url = URL(string: self.ADDRESS + GUEST + sessionId + "/spotify/search?term=" + searchSong + offsetString) else { return products}
        print("url \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        // makes request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // code to defer until this is completed
            defer { sem.signal() }
            
            if let dataResp = data {
                // just to see output
                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                        print(jsonData)
                
                if let decodedResponse = try? JSONDecoder().decode(SearchResults.self, from: dataResp) {
                    
                    print("success")
                    // object that will store searchResults
                    let tracks = decodedResponse.searchResults.body.tracks.items
                    // goes thru json and extracts important info for track
                    products = itemsToTracksForPagination(tracks: tracks, offset: offset)
//                    print("products are \(products)")
                }
            } else {
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
        // tells function to wait before returning
        sem.wait()
        return products
    }
    
    func getGuestTopSongsPaginated(sessionId: String, offset:Int) -> [TrackForPagination] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        // return
        var tracks : [TrackForPagination] = [TrackForPagination]()
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        let offsetString = "&offset=" + String(offset) + "&limit=10"
        guard let url = URL(string: self.ADDRESS + self.GUEST + sessionId + "/" + self.SPOTIFY + self.SEARCH + "top?type=tracks" + offsetString) else { return tracks }
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
                    tracks = itemsToTracksForPagination(tracks: decodedResponse, offset: offset)
                    print("tracks are \(tracks)")
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
    
    
    func getGuestTopArtistsPaginated(sessionId: String, offset: Int) -> [ArtistPaginated] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        var artists = [ArtistPaginated]()
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        let offsetString = "&offset=" + String(offset) + "&limit=10"
        guard let url = URL(string: self.ADDRESS + self.GUEST + sessionId + "/" + self.SPOTIFY + self.SEARCH + "top?type=artists" + offsetString) else { return artists }
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
                        artists = artistResponseToArtistPaginated(artistResps: decodedResponse, offset: offset)
                    }
                    
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

    return artists
    }
    
    func getGuestTopPlaylistsPaginated(sessionId: String, offset: Int) -> [PlaylistPaginated] {
        // this allows us to wait before returning value
        let sem = DispatchSemaphore.init(value: 0)
        var playlists = [PlaylistPaginated]()
        // get access token
        let accessToken = getJWTAndCheckIfExpired()
        // create url
        let offsetString = "&offset=" + String(offset) + "&limit=10"

        guard let url = URL(string: self.ADDRESS + self.GUEST + sessionId + "/" + self.SPOTIFY + self.SEARCH + "top?type=playlists" + offsetString) else { return playlists}
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
                        playlists = playlistResponseToPlaylistPaginated(playlistResps: decodedResponse, offset: offset)
                    }

                    
                   
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
    return playlists
    //return providerObject
    }
    
}
