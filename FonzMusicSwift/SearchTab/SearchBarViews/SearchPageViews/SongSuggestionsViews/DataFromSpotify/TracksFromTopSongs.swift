//
//  TracksFromTopSongs.swift
//  FonzMusicSwift
//
//  Created by didi on 8/5/21.
//

import Foundation
import Combine
import Network

class TracksFromTopSongs: ObservableObject {

    var subscription: Set<AnyCancellable> = []
    var userSessionId = UserDefaults.standard.string(forKey: "userAccountSessionId") ?? ""
    var hostSessionId : String = UserDefaults.standard.string(forKey: "hostSessionId") ?? ""
//    var sessionId : String = ""

//    @Published private (set) var products: [Track] = []
    @Published private (set) var topProducts: [TrackForPagination] = []
    @Published private (set) var bottomProducts: [TrackForPagination] = []
    
    let connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")

    @Published var offset : Int = Int()
    var resultsPerSearch = 0
//    @Published var updateTopTracks = true
    
//    let ADDRESS = "https://api.fonzmusic.com/"
//    let ADDRESS = "http://beta.api.fonzmusic.com:8080/"
    let ADDRESS = "http://52.50.138.97:8080/"
    let tempTracks =
        [
                Track(songName: "Prune, You Talk Funny", songId: "6sHCvZe1PHrOAuYlwTLNH4", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ba8dea5129b6e43b59fadad7", spotifyUrl: "https://open.spotify.com/track/6sHCvZe1PHrOAuYlwTLNH4"),
                Track(songName: "Supalonely", songId: "3GZoWLVbmxcBys6g0DLFLf", artistName: " BENEE", albumArt: "https://i.scdn.co/image/ab67616d0000b2734bd20e01d00de4b35b61f5f7", spotifyUrl: "https://open.spotify.com/track/3GZoWLVbmxcBys6g0DLFLf"),
                Track(songName: "Post Humorous", songId: "0yb9DKhu0xA0h0qvKOHVwu", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b", spotifyUrl: "https://open.spotify.com/track/0yb9DKhu0xA0h0qvKOHVwu"),
                Track(songName: "I\'m Just Snacking", songId: "6413UUgINHbZsCJeJBFlmT", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b27303c5191d01d37d5c795697df", spotifyUrl: "https://open.spotify.com/track/6413UUgINHbZsCJeJBFlmT"),
                Track(songName: "Palms (with Channel Tres)", songId: "0Lskej1hiep1PKXoz7KhyO", artistName: " Gus Dapperton Channel Tres", albumArt: "https://i.scdn.co/image/ab67616d0000b273fd9c5111af2d35d22fb4a512", spotifyUrl: "https://open.spotify.com/track/0Lskej1hiep1PKXoz7KhyO"),
                Track(songName: "Somewhere (feat. Gus Dapperton)", songId: "0bmQ5H9mHFzRnJ4ZntylFg", artistName: " Surf Mesa Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ba3286704e1aec6a762ab144", spotifyUrl: "https://open.spotify.com/track/0bmQ5H9mHFzRnJ4ZntylFg"),
                Track(songName: "Medicine", songId: "7lLtAjBc4Fkaw0FkBQWlSX", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b", spotifyUrl: "https://open.spotify.com/track/7lLtAjBc4Fkaw0FkBQWlSX"),
                Track(songName: "I\'m On Fire", songId: "0lhcKPk0fppMAnFUt3QNy7", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ada32af03830941f2b510bd9", spotifyUrl: "https://open.spotify.com/track/0lhcKPk0fppMAnFUt3QNy7"),
                Track(songName: "Tom Sawyer", songId: "3QZ7uX97s82HFYSmQUAN1D", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/3QZ7uX97s82HFYSmQUAN1D"),
                Track(songName: "The Scientist", songId: "75JFxkI2RXiU7L9VXzMkle", artistName: " Coldplay", albumArt: "https://i.scdn.co/image/ab67616d0000b27390afd8e4ec6d787114ed6c40", spotifyUrl: "https://open.spotify.com/track/75JFxkI2RXiU7L9VXzMkle"),
                Track(songName: "Rush (feat. Jessie Reyez)", songId: "7tTRP2vA00uScZ4SjB3ZQZ", artistName: " Lewis Capaldi Jessie Reyez", albumArt: "https://i.scdn.co/image/ab67616d0000b273e8937101e6dc8ea504c6b546", spotifyUrl: "https://open.spotify.com/track/7tTRP2vA00uScZ4SjB3ZQZ"),
                Track(songName: "Limelight", songId: "0K6yUnIKNsFtfIpTgGtcHm", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
        
            ]
    
    let tempTracksPaginated =
        [
            TrackForPagination(songName: "Prune, You Talk Funny", songId: "6sHCvZe1PHrOAuYlwTLNH4", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ba8dea5129b6e43b59fadad7", spotifyUrl: "https://open.spotify.com/track/6sHCvZe1PHrOAuYlwTLNH4", index: 0),
            TrackForPagination(songName: "Supalonely", songId: "3GZoWLVbmxcBys6g0DLFLf", artistName: " BENEE", albumArt: "https://i.scdn.co/image/ab67616d0000b2734bd20e01d00de4b35b61f5f7", spotifyUrl: "https://open.spotify.com/track/3GZoWLVbmxcBys6g0DLFLf", index: 0),
            TrackForPagination(songName: "Post Humorous", songId: "0yb9DKhu0xA0h0qvKOHVwu", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b", spotifyUrl: "https://open.spotify.com/track/0yb9DKhu0xA0h0qvKOHVwu", index: 0),
            TrackForPagination(songName: "I\'m Just Snacking", songId: "6413UUgINHbZsCJeJBFlmT", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b27303c5191d01d37d5c795697df", spotifyUrl: "https://open.spotify.com/track/6413UUgINHbZsCJeJBFlmT", index: 0),
            TrackForPagination(songName: "Palms (with Channel Tres)", songId: "0Lskej1hiep1PKXoz7KhyO", artistName: " Gus Dapperton Channel Tres", albumArt: "https://i.scdn.co/image/ab67616d0000b273fd9c5111af2d35d22fb4a512", spotifyUrl: "https://open.spotify.com/track/0Lskej1hiep1PKXoz7KhyO", index: 0),
            TrackForPagination(songName: "Somewhere (feat. Gus Dapperton)", songId: "0bmQ5H9mHFzRnJ4ZntylFg", artistName: " Surf Mesa Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ba3286704e1aec6a762ab144", spotifyUrl: "https://open.spotify.com/track/0bmQ5H9mHFzRnJ4ZntylFg", index: 0),
            TrackForPagination(songName: "Medicine", songId: "7lLtAjBc4Fkaw0FkBQWlSX", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b", spotifyUrl: "https://open.spotify.com/track/7lLtAjBc4Fkaw0FkBQWlSX", index: 0),
            TrackForPagination(songName: "I\'m On Fire", songId: "0lhcKPk0fppMAnFUt3QNy7", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ada32af03830941f2b510bd9", spotifyUrl: "https://open.spotify.com/track/0lhcKPk0fppMAnFUt3QNy7", index: 0),
            TrackForPagination(songName: "Tom Sawyer", songId: "3QZ7uX97s82HFYSmQUAN1D", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/3QZ7uX97s82HFYSmQUAN1D", index: 0),
            TrackForPagination(songName: "The Scientist", songId: "75JFxkI2RXiU7L9VXzMkle", artistName: " Coldplay", albumArt: "https://i.scdn.co/image/ab67616d0000b27390afd8e4ec6d787114ed6c40", spotifyUrl: "https://open.spotify.com/track/75JFxkI2RXiU7L9VXzMkle", index: 0),
            TrackForPagination(songName: "Rush (feat. Jessie Reyez)", songId: "7tTRP2vA00uScZ4SjB3ZQZ", artistName: " Lewis Capaldi Jessie Reyez", albumArt: "https://i.scdn.co/image/ab67616d0000b273e8937101e6dc8ea504c6b546", spotifyUrl: "https://open.spotify.com/track/7tTRP2vA00uScZ4SjB3ZQZ", index: 0),
            TrackForPagination(songName: "Limelight", songId: "0K6yUnIKNsFtfIpTgGtcHm", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm", index: 0),
        
            ]

    init() {
        print("starting this")
        if connectedToSpotify && userSessionId != "" {

//            if updateTopTracks {
                print("first call is changing")
                topProducts += SpotifyPaginatedApi().getGuestTopSongsPaginated(sessionId: userSessionId, offset: offset)
                offset += 10
                bottomProducts += SpotifyPaginatedApi().getGuestTopSongsPaginated(sessionId: userSessionId, offset: offset)
//                SpotifySuggestionsApi().getGuestTopSongs(sessionId: userSessionId)
                if topProducts.count < 1 {
                    topProducts = tempTracksPaginated
                    bottomProducts = tempTracksPaginated
                }
//                updateTopTracks = false
                resultsPerSearch += 10
//            }

        }
        else {
            topProducts = tempTracksPaginated
            bottomProducts = tempTracksPaginated
//            products = SpotifySuggestionsApi().getNewSongReleases(sessionId: hostSessionId)
        }

//        if updateTopTracks {
//            print("second call is changing")
//            topProducts += SpotifyPaginatedApi().getGuestTopSongsPaginated(sessionId: userSessionId, offset: offset)
//            offset += 10
//            bottomProducts += SpotifyPaginatedApi().getGuestTopSongsPaginated(sessionId: userSessionId, offset: offset)
////                SpotifySuggestionsApi().getGuestTopSongs(sessionId: userSessionId)
//            if topProducts.count < 1 {
//                topProducts = tempTracksPaginated
//                bottomProducts = tempTracksPaginated
//            }
//            updateTopTracks = false
//            resultsPerSearch += 10
//        }
    }
    
    func loadMoreTracks() {
        topProducts += SpotifyPaginatedApi().getGuestTopSongsPaginated(sessionId: userSessionId, offset: offset)
        offset += 10
        bottomProducts += SpotifyPaginatedApi().getGuestTopSongsPaginated(sessionId: userSessionId, offset: offset)
    }
    
}
