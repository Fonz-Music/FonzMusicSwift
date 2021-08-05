//
//  FonzMusicSwiftApp.swift
//  FonzMusicSwift
//
//  Created by didi on 4/24/21.
//

import SwiftUI
import Firebase
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    
    func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions:
          [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // configureed firebase for analytics
      FirebaseApp.configure()
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
