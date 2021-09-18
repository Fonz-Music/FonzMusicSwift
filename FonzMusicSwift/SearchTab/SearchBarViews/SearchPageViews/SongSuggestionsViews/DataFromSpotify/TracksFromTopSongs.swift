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
    
    var connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")

    @Published var offset : Int = Int()
    var resultsPerSearch = 0
//    @Published var updateTopTracks = true
//    let tempTracks =
//        [
//                Track(songName: "Prune, You Talk Funny", songId: "6sHCvZe1PHrOAuYlwTLNH4", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ba8dea5129b6e43b59fadad7", spotifyUrl: "https://open.spotify.com/track/6sHCvZe1PHrOAuYlwTLNH4"),
//                Track(songName: "Supalonely", songId: "3GZoWLVbmxcBys6g0DLFLf", artistName: " BENEE", albumArt: "https://i.scdn.co/image/ab67616d0000b2734bd20e01d00de4b35b61f5f7", spotifyUrl: "https://open.spotify.com/track/3GZoWLVbmxcBys6g0DLFLf"),
//                Track(songName: "Post Humorous", songId: "0yb9DKhu0xA0h0qvKOHVwu", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b", spotifyUrl: "https://open.spotify.com/track/0yb9DKhu0xA0h0qvKOHVwu"),
//                Track(songName: "I\'m Just Snacking", songId: "6413UUgINHbZsCJeJBFlmT", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b27303c5191d01d37d5c795697df", spotifyUrl: "https://open.spotify.com/track/6413UUgINHbZsCJeJBFlmT"),
//                Track(songName: "Palms (with Channel Tres)", songId: "0Lskej1hiep1PKXoz7KhyO", artistName: " Gus Dapperton Channel Tres", albumArt: "https://i.scdn.co/image/ab67616d0000b273fd9c5111af2d35d22fb4a512", spotifyUrl: "https://open.spotify.com/track/0Lskej1hiep1PKXoz7KhyO"),
//                Track(songName: "Somewhere (feat. Gus Dapperton)", songId: "0bmQ5H9mHFzRnJ4ZntylFg", artistName: " Surf Mesa Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ba3286704e1aec6a762ab144", spotifyUrl: "https://open.spotify.com/track/0bmQ5H9mHFzRnJ4ZntylFg"),
//                Track(songName: "Medicine", songId: "7lLtAjBc4Fkaw0FkBQWlSX", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b2731dc1bd83254e89b474ca496b", spotifyUrl: "https://open.spotify.com/track/7lLtAjBc4Fkaw0FkBQWlSX"),
//                Track(songName: "I\'m On Fire", songId: "0lhcKPk0fppMAnFUt3QNy7", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b273ada32af03830941f2b510bd9", spotifyUrl: "https://open.spotify.com/track/0lhcKPk0fppMAnFUt3QNy7"),
//                Track(songName: "Tom Sawyer", songId: "3QZ7uX97s82HFYSmQUAN1D", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/3QZ7uX97s82HFYSmQUAN1D"),
//                Track(songName: "The Scientist", songId: "75JFxkI2RXiU7L9VXzMkle", artistName: " Coldplay", albumArt: "https://i.scdn.co/image/ab67616d0000b27390afd8e4ec6d787114ed6c40", spotifyUrl: "https://open.spotify.com/track/75JFxkI2RXiU7L9VXzMkle"),
//                Track(songName: "Rush (feat. Jessie Reyez)", songId: "7tTRP2vA00uScZ4SjB3ZQZ", artistName: " Lewis Capaldi Jessie Reyez", albumArt: "https://i.scdn.co/image/ab67616d0000b273e8937101e6dc8ea504c6b546", spotifyUrl: "https://open.spotify.com/track/7tTRP2vA00uScZ4SjB3ZQZ"),
//                Track(songName: "Limelight", songId: "0K6yUnIKNsFtfIpTgGtcHm", artistName: " Rush", albumArt: "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", spotifyUrl: "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
//
//            ]
    
    let tempTracksTopPaginated =
        [
            TrackForPagination(songName: "Chanel", songId: "6Nle9hKrkL1wQpwNfEkxjh", artistName: "Frank Ocean", albumArt: "https://i.scdn.co/image/ab67616d0000b273a0b780c23fc3c19bd412b234", spotifyUrl: "https://open.spotify.com/track/6Nle9hKrkL1wQpwNfEkxjh", index: 0),
            TrackForPagination(songName: "Do Me a Favour", songId: "13NCxLOlvQ4Tnexgfp03Gs", artistName: "Arctic Monkeys", albumArt: "https://i.scdn.co/image/ab67616d0000b2730c8ac83035e9588e8ad34b90", spotifyUrl: "https://open.spotify.com/track/13NCxLOlvQ4Tnexgfp03Gs", index: 0),
            TrackForPagination(songName: "Pacifier", songId: "1rcu88dzWE5GyqtpuWvd0C", artistName: "Catfish and the Bottlemen", albumArt: "https://i.scdn.co/image/ab67616d0000b273b87da477ad10e87b09b88d1e", spotifyUrl: "https://open.spotify.com/track/1rcu88dzWE5GyqtpuWvd0C", index: 0),
            TrackForPagination(songName: "Verdigris", songId: "0praNEF55GE8iZca1tC8BM", artistName: " Gus Dapperton", albumArt: "https://i.scdn.co/image/ab67616d0000b27361d8be1be46d21609f68d476", spotifyUrl: "https://open.spotify.com/track/0praNEF55GE8iZca1tC8BM", index: 0),
            TrackForPagination(songName: "What They Want", songId: "3pndPhlQWjuSoXhcIIdBjv", artistName: " Russ", albumArt: "https://i.scdn.co/image/ab67616d0000b273cb045e684adce8d49ada4045", spotifyUrl: "https://open.spotify.com/track/3pndPhlQWjuSoXhcIIdBjv", index: 0),
            TrackForPagination(songName: "Take My Breath", songId: "6OGogr19zPTM4BALXuMQpF", artistName: " The Weeknd", albumArt: "https://i.scdn.co/image/ab67616d0000b2733c041e53cb5c38b6de03e758", spotifyUrl: "https://open.spotify.com/track/6OGogr19zPTM4BALXuMQpF", index: 0),
            TrackForPagination(songName: "Digital Love", songId: "2VEZx7NWsZ1D0eJ4uv5Fym", artistName: " Daft Punk", albumArt: "https://i.scdn.co/image/ab67616d0000b273b33d46dfa2635a47eebf63b2", spotifyUrl: "https://open.spotify.com/track/2VEZx7NWsZ1D0eJ4uv5Fym", index: 0),
            TrackForPagination(songName: "Bonny", songId: "6XGup1vnoRarqS5Eb0zeUc", artistName: " Prefab Sprout", albumArt: "https://i.scdn.co/image/ab67616d0000b273e40c4c9d5f19d2ab9886a534", spotifyUrl: "https://open.spotify.com/track/6XGup1vnoRarqS5Eb0zeUc", index: 0),
            TrackForPagination(songName: "Ooh La", songId: "6xqCTPxYnRf8X0p6N5Vw2T", artistName: " The Kooks", albumArt: "https://i.scdn.co/image/ab67616d0000b2736e8b31b2e7cec192c603eece", spotifyUrl: "https://open.spotify.com/track/6xqCTPxYnRf8X0p6N5Vw2T", index: 0),
            TrackForPagination(songName: "Hello?", songId: "7qwt4xUIqQWCu1DJf96g2k", artistName: "Clairo, Rejjie Snow", albumArt: "https://i.scdn.co/image/ab67616d0000b273bf94e27360806b5aa5025f93", spotifyUrl: "https://open.spotify.com/track/7qwt4xUIqQWCu1DJf96g2k", index: 0),
            
        
            ]
    let tempTracksBottomPaginated =
        [
            TrackForPagination(songName: "A Fool Moon Night", songId: "6c7JQdDL94DF8ECGCwT3zG", artistName: "THE KOXX", albumArt: "https://i.scdn.co/image/ab67616d0000b27300e62f490dd62b191d6c6874", spotifyUrl: "https://open.spotify.com/track/6c7JQdDL94DF8ECGCwT3zG", index: 0),
            TrackForPagination(songName: "Glue", songId: "2aJDlirz6v2a4HREki98cP", artistName: " Bicep", albumArt: "https://i.scdn.co/image/ab67616d0000b273d4322a9004288009f6da2975", spotifyUrl: "https://open.spotify.com/track/2aJDlirz6v2a4HREki98cP", index: 0),
            TrackForPagination(songName: "Losing It", songId: "6ho0GyrWZN3mhi9zVRW7xi", artistName: " FISHER", albumArt: "https://i.scdn.co/image/ab67616d0000b2739367c1ee2eec0bf3a04b4868", spotifyUrl: "https://open.spotify.com/track/6ho0GyrWZN3mhi9zVRW7xi", index: 0),
            TrackForPagination(songName: "Believe What I Say", songId: "73uxnSsFMeJ15POpd3zgrV", artistName: "Kanye West", albumArt: "https://i.scdn.co/image/ab67616d0000b2736ba1cffc9b2c5469503430b3", spotifyUrl: "https://open.spotify.com/track/73uxnSsFMeJ15POpd3zgrV", index: 0),
            TrackForPagination(songName: "Anseo (Single Mix)", songId: "6DW0XcQeWW9s4SU5cStQqc", artistName: "Denise Chaila, Jafaris", albumArt: "https://i.scdn.co/image/ab67616d0000b273f0ad7b153c7ca8ea32579a20", spotifyUrl: "https://open.spotify.com/track/6DW0XcQeWW9s4SU5cStQqc", index: 0),
            TrackForPagination(songName: "I Still Haven't Found What I'm Looking For", songId: "6wpGqhRvJGNNXwWlPmkMyO", artistName: "U2", albumArt: "https://i.scdn.co/image/ab67616d0000b273b7bea3d01f04e6d0408d2afe", spotifyUrl: "https://open.spotify.com/track/6wpGqhRvJGNNXwWlPmkMyO", index: 0),
            TrackForPagination(songName: "A.D.H.D", songId: "2Fw5S2gaOSZzdN5dFoC2dj", artistName: " Kendrick Lamar", albumArt: "https://i.scdn.co/image/ab67616d0000b273eddb2639b74ac6c202032ebe", spotifyUrl: "https://open.spotify.com/track/2Fw5S2gaOSZzdN5dFoC2dj", index: 0),
            TrackForPagination(songName: "Zombie", songId: "7EZC6E7UjZe63f1jRmkWxt", artistName: " The Cranberries", albumArt: "https://i.scdn.co/image/ab67616d0000b27372d481a5999197ef5f42f796", spotifyUrl: "https://open.spotify.com/track/7EZC6E7UjZe63f1jRmkWxt", index: 0),
            TrackForPagination(songName: "That Funny Feeling", songId: "7uCq4vBPffjaTMlE8EQzJD", artistName: " Bo Burnham", albumArt: "https://i.scdn.co/image/ab67616d0000b2732853b5ea06ddc676b337c389", spotifyUrl: "https://open.spotify.com/track/7uCq4vBPffjaTMlE8EQzJD", index: 0),
            TrackForPagination(songName: "Bonkers", songId: "6ddQ5KCkvCggk3j6KdA0zL", artistName: " Dizzee Rascal, Armand Van Helden", albumArt: "https://i.scdn.co/image/ab67616d0000b2736f754c78ad0a1cb7fa2d6c4f", spotifyUrl: "https://open.spotify.com/track/6ddQ5KCkvCggk3j6KdA0zL", index: 0),
            
            
        
            ]

    
    init() {
        print("starting this tracks from top songs")
        loadTracks()

    }
    
    func loadMoreTracks() {
        topProducts += SpotifyPaginatedApi().getGuestTopSongsPaginated(sessionId: userSessionId, offset: offset)
        offset += 10
        bottomProducts += SpotifyPaginatedApi().getGuestTopSongsPaginated(sessionId: userSessionId, offset: offset)
    }
    
    func loadTracks() {
        connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
        if connectedToSpotify && userSessionId != "" {

//            if updateTopTracks {
                print("first call is changing")
                topProducts += SpotifyPaginatedApi().getGuestTopSongsPaginated(sessionId: userSessionId, offset: offset)
                offset += 10
                bottomProducts += SpotifyPaginatedApi().getGuestTopSongsPaginated(sessionId: userSessionId, offset: offset)
//                SpotifySuggestionsApi().getGuestTopSongs(sessionId: userSessionId)
                if topProducts.count < 1 {
                    topProducts = tempTracksTopPaginated
                    bottomProducts = tempTracksBottomPaginated
                }
//                updateTopTracks = false
                resultsPerSearch += 10
//            }

        }
        else {
            topProducts = tempTracksTopPaginated
            bottomProducts = tempTracksBottomPaginated
//            products = SpotifySuggestionsApi().getNewSongReleases(sessionId: hostSessionId)
        }
    }
    func loadTracksAfterSpotConnect() {
        connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
        topProducts = []
        bottomProducts = []
        loadTracks()
    }
    
}
