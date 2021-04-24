//
//  FonzMusicSwiftApp.swift
//  FonzMusicSwift
//
//  Created by didi on 4/24/21.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
