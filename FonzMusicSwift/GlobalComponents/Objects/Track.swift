//
//  Track.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import Foundation

// track Object
struct Track: Hashable {
    var songName: String
    var songId: String
    var artistName: String
    var albumArt: String
    var spotifyUrl:String
}

// this converts the JSON from songSearch into Object
struct TracksResult: Codable {
    var tracks: Tracks
}
struct Tracks: Codable {
    var items: Array<Items>
}
struct Items: Codable {
    var album: Album
    var artists: Array<ArtistArray>
    var name:String
    var id:String
    var external_urls: ExternalUrl
}

struct ExternalUrl: Codable {
    var spotify:String
}

// albums
struct Album: Codable {
    var images: Array<ImageArray>
}
struct ImageArray: Codable {
    var url:String
}

// artists
struct ArtistArray: Codable {
    var name: String
}
