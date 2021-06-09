//
//  FonzMusicSwiftApp.swift
//  FonzMusicSwift
//
//  Created by didi on 4/24/21.
//

import SwiftUI
import Firebase
import UIKit

//class AppDelegate: NSObject, UIApplicationDelegate, SPTAppRemotePlayerStateDelegate, SPTAppRemoteDelegate, SPTSessionManagerDelegate {
class AppDelegate: NSObject, UIApplicationDelegate {
    
    
//    let SpotifyClientID = "f0973699a0ef4a44b444027ea5c54daf"
//    let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
//    var accessToken = ""
//    var playURI = ""

    
    func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions:
          [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // dont need anymore?
      FirebaseApp.configure()
        print("configured FB")
         //This inits an ANON firebase account
        Auth.auth().signInAnonymously() { (authResult, error) in
          print("signed in anon")
        }
      return true
    }
}

@main
struct FonzMusicSwiftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var spotifyController = SpotifyController()
    @State var authCode: String = ""
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
//                    if url.absoluteString.contains("spotify") {
//                    let authCode: String
                    let parameters = spotifyController.appRemote.authorizationParameters(from: url)
                    if let code = parameters?["code"] {
                        print("there is a code")
                        authCode = code
                    }
                    print("this is the code \(authCode)")
                    
                    print("this is called")
                    print("the url is \(url)")
//                    @StateObject var spotifyController = SpotifyController()
                    spotifyController.setAccessToken(from: url)
                    }
//                }
//                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification), perform: { _ in
//                    spotifyController.connect()
//                })
        }
    }
}
