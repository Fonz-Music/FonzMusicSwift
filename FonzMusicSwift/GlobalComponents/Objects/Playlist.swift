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
struct PlaylistPaginated: Hashable, Decodable {
    var playlistName: String
    var playlistId: String
    var playlistImage: String
    var amountOfTracks: Int
    var index:Int
    
    func toPlaylist() -> Playlist {
        return Playlist(playlistName: self.playlistName, playlistId: self.playlistId, playlistImage: self.playlistImage, amountOfTracks: self.amountOfTracks)
    }
}
