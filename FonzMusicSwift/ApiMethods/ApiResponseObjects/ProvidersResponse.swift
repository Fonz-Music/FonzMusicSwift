//
//  ProvidersResponse.swift
//  FonzMusicSwift
//
//  Created by didi on 7/19/21.
//

import Foundation

struct ProviderResponse: Codable {
    var providers: Array<Provider>
//    var responseCode : Int
}
struct Provider: Codable {
    var display_name : String
    var id : String
    var provider : String
    var spotifyId : String
    
}

struct SpotifyUrlResponse: Codable {
    var authorizeURL : String
}
