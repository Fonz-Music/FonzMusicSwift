//
//  ProvidersResponse.swift
//  FonzMusicSwift
//
//  Created by didi on 7/19/21.
//

import Foundation

//struct ProviderResponse: Codable {
//    var providers: Array<Provider>
////    var responseCode : Int
//}
struct Provider: Codable {
    var displayName : String
    var provider : String
    var providerId : String
    var userId : String
    
} 

struct SpotifyUrlResponse: Codable {
    var authorizeURL : String
}

struct AddProviderResponse: Codable {
    var message : String
    var session : SessionResponse
//    var responseCode : Int
}
