//
//  Fonz_Music_App_ClipApp.swift
//  Fonz Music App Clip
//
//  Created by didi on 7/17/21.
//

import SwiftUI
import Firebase
import UIKit

//@main
//struct Fonz_Music_App_ClipApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//    @State var authCode: String = ""
//    @State var accessToken: String = ""
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .onOpenURL { url in
//                   print("sending to ole spottie")
//
//                    if url.absoluteString.range(of: "spotify") != nil {
//                        print ("navs to spot")
//                    }
//                    if url.absoluteString.range(of: "banana") != nil {
//                        print ("navs to banana")
//                    }
//                }
//
//        }
//    }
//}

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
