//
//  SpotifyConverterPaginated.swift
//  FonzMusicSwift
//
//  Created by didi on 8/27/21.
//

import Foundation


func itemsToTracksForPagination(tracks : [Items], offset : Int) -> [TrackForPagination] {
    print("in itemsToTracks")
    var index = offset
    var trackReturn = [TrackForPagination]()
    for track in tracks {
//                                print("\(track.external_urls)")
        if track.album.images.count == 0 {
            continue
        }
        let albumArt = track.album.images[0].url
        let listArtist = track.artists
        var listArtistString = ""
        for (index, element) in listArtist.enumerated() {
            listArtistString += " " + element.name
            
        }
        let spotifyUrl = track.external_urls.spotify
        // compiles all info into one track
        let newTrack = TrackForPagination(songName: track.name, songId: track.id, artistName: listArtistString, albumArt: albumArt, spotifyUrl: spotifyUrl, index: index)
        // appends that onto searchResults array
//                                print(searchResults)
        trackReturn.append(newTrack)
        index += 1
    }
    return trackReturn
}
