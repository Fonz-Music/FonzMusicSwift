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
                    // get params from return val
                    let parameters = spotifyController.appRemote.authorizationParameters(from: url)
                    // set the auth code from the params
                    if let code = parameters?["code"] {
                        print("there is a code")
                        authCode = code
                    }
                    print("this is the code \(authCode)")
                    
                    // send auth code to api
//                    let resp = SpotifySignInApi().sendAuthCodeToSpotify(authCode: authCode)

//                    print("the resp is \(resp)")
                    
                    }
//                }
//                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification), perform: { _ in
//                    spotifyController.connect()
//                })
        }
    }
}
