//
//  Artist.swift
//  FonzMusicSwift
//
//  Created by didi on 6/22/21.
//

import Foundation


// track Object
struct Artist: Hashable {
    var artistName: String
    var artistId: String
    var artistImage: String
}

struct ArtistPaginated: Hashable {
    var artistName: String
    var artistId: String
    var artistImage: String
    var index:Int
    
    func toArtist() -> Artist {
        return Artist(artistName: self.artistName, artistId: self.artistId, artistImage: self.artistImage)
    }
}



