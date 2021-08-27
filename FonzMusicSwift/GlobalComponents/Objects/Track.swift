//
//  Track.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import Foundation

// track Object
struct Track: Hashable, Decodable {
    var songName: String
    var songId: String
    var artistName: String
    var albumArt: String
    var spotifyUrl:String
    
    
}

struct TrackForPagination: Hashable, Decodable {
    var songName: String
    var songId: String
    var artistName: String
    var albumArt: String
    var spotifyUrl:String
    var index:Int
    
    func toTrack() -> Track {
        var globalTrack = Track(songName: self.songName, songId: self.songId, artistName: self.artistName, albumArt: self.albumArt, spotifyUrl: self.spotifyUrl)
//        globalTrack.songName = self.songName
//        globalTrack.songId = self.songId
//        globalTrack.artistName = self.artistName
//        globalTrack.albumArt = self.albumArt
//        globalTrack.spotifyUrl = self.spotifyUrl
        return globalTrack
    }
}

// this converts the JSON from songSearch into Object
struct TracksResult: Codable {
    var tracks: Tracks
}

struct SearchResults : Codable {
    var searchResults : Body
}

struct Body : Codable {
    var body : TrackBody
}

struct TrackBody : Codable {
    var tracks : Tracks
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
