//
//  SpotifyTrackConverter.swift
//  FonzMusicSwift
//
//  Created by didi on 8/5/21.
//

import Foundation

func itemsToTracks(tracks : [Items]) -> [Track] {
    var trackReturn = [Track]()
    for track in tracks {
//                                print("\(track.external_urls)")
    
        let albumArt = track.album.images[0].url
        let listArtist = track.artists
        var listArtistString = ""
        for (index, element) in listArtist.enumerated() {
            listArtistString += " " + element.name
            
        }
        let spotifyUrl = track.external_urls.spotify
        // compiles all info into one track
        let newTrack = Track(songName: track.name, songId: track.id, artistName: listArtistString, albumArt: albumArt, spotifyUrl: spotifyUrl)
        // appends that onto searchResults array
//                                print(searchResults)
        trackReturn.append(newTrack)
    }
    return trackReturn
}

func artistResponseToArtist(artistResps : [ArtistResponse]) -> [Artist] {
    var artists = [Artist]()
    for artist in artistResps {
        let artistArt = artist.images[0].url
        let artistName = artist.name
        let artistId = artist.id
        
        let newArtist = Artist(artistName: artistName, artistId: artistId, artistImage: artistArt)
        artists.append(newArtist)
    }
    return artists
    
}
