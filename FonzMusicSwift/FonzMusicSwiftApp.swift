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
        print("configured firebase for analytics")
         //This inits an ANON firebase account
//        Auth.auth().signInAnonymously() { (authResult, error) in
//          print("signed in anon")
//        }

      return true
    }
}
//#if !APPCLIP

@main
struct FonzMusicSwiftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State var authCode: String = ""
    @State var accessToken: String = ""
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
//
//#else
//
//@main
//struct Fonz_Music_App_ClipApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//    @State var authCode: String = ""
//    @State var accessToken: String = ""
//
//    var body: some Scene {
//        WindowGroup {
//            ContentViewClip()
//
//        }
//    }
//}
//
//#endif

// code for getting the spotify refresh + access tokens in app
// never used, but works properly

//
//// get params from return val
//let parameters = spotifyController.appRemote.authorizationParameters(from: url)
//print("\(parameters)")
//// set the auth code from the params
//if let code = parameters?["code"] {
//    print("there is a code")
//    authCode = code
//}
//if let token = parameters?[SPTAppRemoteAccessTokenKey] {
//    print("there is a code")
//    accessToken = token
//}
//print("this is the code \(authCode)")
//
//spotifyController.responseTypeCode = authCode
//
//
//print("\(spotifyController.sessionManager?.session)")
//
