//
//  SpotifyTrackConverter.swift
//  FonzMusicSwift
//
//  Created by didi on 8/5/21.
//

import Foundation

func itemsToTracks(tracks : [Items]) -> [Track] {
    print("in itemsToTracks")
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

func playlistResponseToPlaylist(playlistResps : [PlaylistResponse]) -> [Playlist] {
    var playlists = [Playlist]()
    for playlist in playlistResps {
        let art = playlist.images[0].url
        let name = playlist.name
        let id = playlist.id
        let tracks = playlist.tracks.total

        let newPlaylist = Playlist(playlistName: name, playlistId: id, playlistImage: art, amountOfTracks: tracks)
        playlists.append(newPlaylist)
    }
    return playlists

}

func playlistTracksToTracks(playlistResps : ItemsFromPlaylist) -> [Track] {
    var tracks = [Track]()
    for playlistTrack in playlistResps.items {
        let art = playlistTrack.track.album.images[0].url
        let name = playlistTrack.track.name
        let id = playlistTrack.track.id
        let listArtist = playlistTrack.track.artists
        var listArtistString = ""
        for (index, element) in listArtist.enumerated() {
            listArtistString += " " + element.name
            
        }

        let newTrack = Track(songName: name, songId: id, artistName: listArtistString, albumArt: art, spotifyUrl: playlistTrack.track.external_urls.spotify)
        tracks.append(newTrack)
    }
    return tracks

}
