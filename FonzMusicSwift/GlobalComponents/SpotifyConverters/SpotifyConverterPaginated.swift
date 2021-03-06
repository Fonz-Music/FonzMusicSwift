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

func artistResponseToArtistPaginated(artistResps : [ArtistResponse], offset: Int) -> [ArtistPaginated] {
    var artists = [ArtistPaginated]()
    var index = offset
    for artist in artistResps {
        if artist.images.count == 0 {
            continue
        }
        let artistArt = artist.images[0].url
        let artistName = artist.name
        let artistId = artist.id
        
        let newArtist = ArtistPaginated(artistName: artistName, artistId: artistId, artistImage: artistArt, index: index)
        artists.append(newArtist)
        index += 1
    }
    return artists
    
}
func playlistResponseToPlaylistPaginated(playlistResps : [PlaylistResponse], offset: Int) -> [PlaylistPaginated] {
    var playlists = [PlaylistPaginated]()
    var index = offset
    for playlist in playlistResps {
        if playlist.images.count == 0 {
            continue
        }
        guard case let art = playlist.images[0].url
        else { continue }
        let name = playlist.name
        let id = playlist.id
        let tracks = playlist.tracks.total
        if tracks > 1 {
            let newPlaylist = PlaylistPaginated(playlistName: name, playlistId: id, playlistImage: art, amountOfTracks: tracks, index: index)
            playlists.append(newPlaylist)
            index += 1
        }
        
    }
    return playlists

}

func playlistTracksToTracksPaginated(playlistResps : ItemsFromPlaylist, offset: Int) -> [TrackForPagination] {
    var tracks = [TrackForPagination]()
    var index = offset
    for playlistTrack in playlistResps.items {
        if playlistTrack.track.album.images.count == 0 {
            continue
        }
        let art = playlistTrack.track.album.images[0].url
        let name = playlistTrack.track.name
        let id = playlistTrack.track.id
        let listArtist = playlistTrack.track.artists
        var listArtistString = ""
        for (index, element) in listArtist.enumerated() {
            listArtistString += " " + element.name
            
        }

        let newTrack = TrackForPagination(songName: name, songId: id, artistName: listArtistString, albumArt: art, spotifyUrl: playlistTrack.track.external_urls.spotify, index: index)
        tracks.append(newTrack)
        index += 1
    }
    return tracks

}
