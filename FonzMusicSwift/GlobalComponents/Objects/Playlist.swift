//
//  Playlist.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import Foundation



// track Object
struct Playlist: Hashable, Decodable {
    var playlistName: String
    var playlistId: String
    var playlistImage: String
    var amountOfTracks: Int
}
//
//// this converts the JSON from songSearch into Object
//struct TracksResult: Codable {
//    var tracks: Tracks
//}
//struct Tracks: Codable {
//    var items: Array<Items>
//}
//struct Items: Codable {
//    var album: Album
//    var artists: Array<ArtistArray>
//    var name:String
//    var id:String
//    var external_urls: ExternalUrl
//}
//
//struct ExternalUrl: Codable {
//    var spotify:String
//}
//
//// albums
//struct Album: Codable {
//    var images: Array<ImageArray>
//}
//struct ImageArray: Codable {
//    var url:String
//}
//
//// artists
//struct ArtistArray: Codable {
//    var name: String
//}
