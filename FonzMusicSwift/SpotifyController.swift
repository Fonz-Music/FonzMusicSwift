//
//  SpotifyController.swift
//  SpotifyQuickStart
//
//  Created by Till Hainbach on 02.04.21.
//

import SwiftUI
import Combine

class SpotifyController: NSObject, ObservableObject, SPTSessionManagerDelegate {
    
    // our client id
    let spotifyClientID = "f0973699a0ef4a44b444027ea5c54daf"
    // our redirect url
    let spotifyRedirectURL = URL(string:"fonz-music://spotify-login-callback")!
    // need to set to defauly
    var accessToken: String? = nil
    // set as any song
    var playURI = "3KapR70eIR6Zm3kJfG4oB3?si=a1f50289d0694473"
    
    private var connectCancellable: AnyCancellable?
    private var disconnectCancellable: AnyCancellable?
    
    //remove scopes you don't need
    let scopes: SPTScope = [.userReadEmail, .userReadPrivate,
    .userReadPlaybackState, .userModifyPlaybackState,
    .userReadCurrentlyPlaying, .streaming, .appRemoteControl,
    .playlistReadCollaborative, .playlistModifyPublic, .playlistReadPrivate, .playlistModifyPrivate,
    .userLibraryModify, .userLibraryRead,
    .userTopRead, .userReadPlaybackState, .userReadCurrentlyPlaying,
    .userFollowRead, .userFollowModify,]
    
    //remove scopes you don't need
    let stringScopes = ["user-read-email", "user-read-private",
    "user-read-playback-state", "user-modify-playback-state", "user-read-currently-playing",
    "streaming", "app-remote-control",
    "playlist-read-collaborative", "playlist-modify-public", "playlist-read-private", "playlist-modify-private",
    "user-library-modify", "user-library-read",
    "user-top-read", "user-read-playback-position", "user-read-recently-played",
    "user-follow-read", "user-follow-modify",]
    
//    override init() {
//        super.init()
//        print("doing the init ")
//        connectCancellable = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//                self.connect()
//            }
//
//        disconnectCancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//                self.disconnect()
//            }
//
//    }
        
    lazy var configuration = SPTConfiguration(
        clientID: spotifyClientID,
        redirectURL: spotifyRedirectURL
    )
    
    lazy var sessionManager: SPTSessionManager? = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
        return manager
      }()
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("launched the session manager")
        self.appRemote.connectionParameters.accessToken = session.accessToken
        self.appRemote.connect()
    }
        
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print(error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print(session)
    }

    lazy var appRemote: SPTAppRemote = {
        print("creating remote ")
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()
    
    // do not need
//    func setAccessToken(from url: URL) {
//        let parameters = appRemote.authorizationParameters(from: url)
//        print("seting tokens ")
//
//        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
//            appRemote.connectionParameters.accessToken = accessToken
//            print("access token is \(accessToken)")
//
//            self.accessToken = accessToken
//        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
//            print(errorDescription)
//        }
//
//    }
    
    // do not need
//    func connect() {
//        guard let _ = self.appRemote.connectionParameters.accessToken else {
//            print("connecting ")
//            self.appRemote.authorizeAndPlayURI("")
//            return
//        }
//
//        appRemote.connect()
//    }
    
    // do not need
//    func disconnect() {
//        if appRemote.isConnected {
//            appRemote.disconnect()
//        }
//    }
}

extension SpotifyController: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("esstablishing connection ")
        self.appRemote = appRemote
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
}

extension SpotifyController: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        print("chandged state")
    }
    
}

