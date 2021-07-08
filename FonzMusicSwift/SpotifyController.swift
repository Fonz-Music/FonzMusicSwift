////
////  SpotifyController.swift
////  SpotifyQuickStart
////
////  Created by Till Hainbach on 02.04.21.
////
//
//import SwiftUI
//import Combine
//
//
// // removed spotify ios sdk
//
//class SpotifyController: NSObject, ObservableObject, SPTSessionManagerDelegate {
//
//    // our client id
//    let spotifyClientID = "f0973699a0ef4a44b444027ea5c54daf"
//    // our redirect url
//    let spotifyRedirectURL = URL(string:"fonz-music://spotify-login-callback")!
//    // need to set to defauly
//    var accessToken: String? = nil
//    // set as any song
//    var playURI = "3KapR70eIR6Zm3kJfG4oB3?si=a1f50289d0694473"
//
////    let spotifyClientSecretKey = "438adf2c4d4d44a5b99030b910209051"
//
//    var responseTypeCode: String? {
//            didSet {
//                fetchSpotifyToken { (dictionary, error) in
//                    if let error = error {
//                        print("Fetching token request error \(error)")
//                        return
//                    }
//                    let accessToken = dictionary!["access_token"] as! String
//                    let refreshToken = dictionary!["refresh_token"] as! String
////                    DispatchQueue.main.async {
////                        self.appRemote.connectionParameters.accessToken = accessToken
////                        self.appRemote.connect()
////                    }
//                }
//            }
//        }
//
//    var codeVerifier = "Hgb4g8LxFDMPGumCK-LAp6xkieATSO74AqePlU6BztXxM0IOTHZPPx60hJXALLVkYCUNg6SEkpzRtncVy2Rovk0Z3DU_pYRhRePhPouYVT4lQkplKWgbBZ00XB8LGAMH"
//    var codeChallenge = ""
//
//    // optional, but strongly recommended
//    let state = String.randomURLSafe(length: 128)
//
//    private var connectCancellable: AnyCancellable?
//    private var disconnectCancellable: AnyCancellable?
//
//    //remove scopes you don't need
//    let scopes: SPTScope = [.userReadEmail, .userReadPrivate,
//    .userReadPlaybackState, .userModifyPlaybackState,
//    .userReadCurrentlyPlaying, .streaming, .appRemoteControl,
//    .playlistReadCollaborative, .playlistModifyPublic, .playlistReadPrivate, .playlistModifyPrivate,
//    .userLibraryModify, .userLibraryRead,
//    .userTopRead, .userReadPlaybackState, .userReadCurrentlyPlaying,
//    .userFollowRead, .userFollowModify,]
//
//    //remove scopes you don't need
//    let stringScopes = ["user-read-email", "user-read-private",
//    "user-read-playback-state", "user-modify-playback-state", "user-read-currently-playing",
//    "streaming", "app-remote-control",
//    "playlist-read-collaborative", "playlist-modify-public", "playlist-read-private", "playlist-modify-private",
//    "user-library-modify", "user-library-read",
//    "user-top-read", "user-read-playback-position", "user-read-recently-played",
//    "user-follow-read", "user-follow-modify",]
//
////    override init() {
////        super.init()
////        print("doing the init ")
////        connectCancellable = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
////            .receive(on: DispatchQueue.main)
////            .sink { _ in
////                self.connect()
////            }
////
////        disconnectCancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
////            .receive(on: DispatchQueue.main)
////            .sink { _ in
////                self.disconnect()
////            }
////
////    }
//
//    lazy var configuration = SPTConfiguration(
//        clientID: spotifyClientID,
//        redirectURL: spotifyRedirectURL
//    )
//
//    lazy var sessionManager: SPTSessionManager? = {
//        let manager = SPTSessionManager(configuration: configuration, delegate: self)
//        return manager
//      }()
//
//    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
//        print("launched the session manager")
//        self.appRemote.connectionParameters.accessToken = session.accessToken
//        self.appRemote.connect()
//    }
//
//    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
//        print(error)
//    }
//
//    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
//        print(session)
//    }
//
//    lazy var appRemote: SPTAppRemote = {
//        print("creating remote ")
//        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
//        appRemote.connectionParameters.accessToken = self.accessToken
//        appRemote.delegate = self
//
////        print("session here is \(sessionManager?.session)" )
//        return appRemote
//    }()
//
//    ///fetch Spotify access token. Use after getting responseTypeCode
//      func fetchSpotifyCode(completion: @escaping ([String: Any]?, Error?) -> Void) {
//
//        self.codeChallenge = String.makeCodeChallenge(codeVerifier: codeVerifier)
//        print("code verifier is \(codeVerifier)" )
//        let scopeAsString = stringScopes.joined(separator: " ") //put array to string separated by whitespace
//
//        let url = URL(string: "https://accounts.spotify.com/authorize?"
//                        + "client_id=" + spotifyClientID
//                        + "&response_type=" + "code"
//                        + "&redirect_uri=" + spotifyRedirectURL.absoluteString
//                        + "&code_challenge_method=" + "S256"
//                        + "&code_challenge=" + codeChallenge
////                        + "&state=" + state
//                        )!
////        var request = URLRequest(url: url)
//        print("about to open in app")
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        print("opened in app")
////        request.httpMethod = "GET"
////        let spotifyAuthKey = "Basic \((spotifyClientID + ":" + spotifyClientSecretKey).data(using: .utf8)!.base64EncodedString())"
////        request.allHTTPHeaderFields = ["Authorization": spotifyAuthKey, "Content-Type": "application/x-www-form-urlencoded"]
////        do {
//////          requestBodyComponents.queryItems =
//////            [URLQueryItem(name: "client_id", value: spotifyClientID),
//////             URLQueryItem(name: "response_type", value: "code"),
//////             URLQueryItem(name: "redirect_uri", value: spotifyRedirectURL.absoluteString),
//////             URLQueryItem(name: "code_challenge_method", value: "S256"),
//////             URLQueryItem(name: "code_verifier", value: codeChallenge),
//////             URLQueryItem(name: "state", value: state),
//////             URLQueryItem(name: "scope", value: scopeAsString),]
//////            print("\(requestBodyComponents.queryItems)")
//////          request.httpBody = requestBodyComponents.query?.data(using: .utf8)
////          let task = URLSession.shared.dataTask(with: request) { data, response, error in
////            guard let data = data,                            // is there data
////            let response = response as? HTTPURLResponse,  // is there HTTP response
////            (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
////            error == nil else {                           // was there no error, otherwise ...
////              print("Error fetching token \(error?.localizedDescription ?? "")")
////                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
////                print(jsonData)
////                print(error)
////                print(response)
////
////              return completion(nil, error)
////            }
////            print("got here")
////            let responseObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
////            print("Access Token Dictionary=", responseObject ?? "")
////            completion(responseObject, nil)
////
////          }
////          task.resume()
////        } catch {
////          print("Error JSON serialization \(error.localizedDescription)")
////        }
//      }
//
//    ///fetch Spotify access token. Use after getting responseTypeCode
//      func fetchSpotifyToken(completion: @escaping ([String: Any]?, Error?) -> Void) {
//        let url = URL(string: "https://accounts.spotify.com/api/token")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
////        let spotifyAuthKey = "Basic \((spotifyClientID + ":" + spotifyClientSecretKey).data(using: .utf8)!.base64EncodedString())"
////        request.allHTTPHeaderFields = ["Authorization": spotifyAuthKey, "Content-Type": "application/x-www-form-urlencoded"]
//        do {
//          var requestBodyComponents = URLComponents()
//          let scopeAsString = stringScopes.joined(separator: " ") //put array to string separated by whitespace
//
//            print("code verifier here is \(codeVerifier)" )
//          requestBodyComponents.queryItems =
//            [URLQueryItem(name: "client_id", value: spotifyClientID),
//             URLQueryItem(name: "grant_type", value: "authorization_code"),
//             URLQueryItem(name: "code", value: responseTypeCode),
//             URLQueryItem(name: "redirect_uri", value: spotifyRedirectURL.absoluteString),
//             URLQueryItem(name: "code_verifier", value: codeVerifier),
////             URLQueryItem(name: "scope", value: scopeAsString),
//            ]
//            print("\(requestBodyComponents.queryItems)")
//          request.httpBody = requestBodyComponents.query?.data(using: .utf8)
//          let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data,                            // is there data
//            let response = response as? HTTPURLResponse,  // is there HTTP response
//            (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
//            error == nil else {                           // was there no error, otherwise ...
//              print("Error fetching token \(error?.localizedDescription ?? "")")
//                let jsonData = try? JSONSerialization.jsonObject(with: data!, options: [])
//                print(jsonData)
//
//              return completion(nil, error)
//            }
//            let responseObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
//            print("Access Token Dictionary=", responseObject ?? "")
//            completion(responseObject, nil)
//          }
//          task.resume()
//        } catch {
//          print("Error JSON serialization \(error.localizedDescription)")
//        }
//      }
//
//
//    // do not need
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
//
//    // do not need
////    func connect() {
////        guard let _ = self.appRemote.connectionParameters.accessToken else {
////            print("connecting ")
////            self.appRemote.authorizeAndPlayURI("")
////            return
////        }
////
////        appRemote.connect()
////    }
//
//    // do not need
////    func disconnect() {
////        if appRemote.isConnected {
////            appRemote.disconnect()
////        }
////    }
//}
//
//extension SpotifyController: SPTAppRemoteDelegate {
//    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
//        print("esstablishing connection ")
//        self.appRemote = appRemote
//        self.appRemote.playerAPI?.delegate = self
//        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
//            if let error = error {
//                debugPrint(error.localizedDescription)
//            }
//
//        })
//    }
//
//    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
//        print("failed")
//    }
//
//    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
//        print("disconnected")
//    }
//}
//
//extension SpotifyController: SPTAppRemotePlayerStateDelegate {
//    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
//        print("chandged state")
//    }
//
//}
//
