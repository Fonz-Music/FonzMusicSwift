//
//  ContentViewClip.swift
//  FonzMusicSwift
//
//  Created by didi on 7/17/21.
//

import SwiftUI

enum TabIdentifier: Hashable {
  case host, search, account
}


struct ContentView: View {
    // current tab for entire app
    @State var selectedTab = TabIdentifier.search
    // bool on if the user has spotify
    @State var connectedToSpotify = false
    // bool on if the user has coasters connected
    @State var hasConnectedCoasters = false
    // bool on whether the user has an account
    @State var hasAccount = false
    // bool on whether the user needs to update their app
    @State var needsToUpdate = false

    // main app
    var body: some View {
        
    ZStack{
        SearchTab(selectedTab: $selectedTab,connectedToSpotify: $connectedToSpotify, hasAccount: $hasAccount, hasConnectedCoasters: $hasConnectedCoasters)
            .onOpenURL { url in
                // if the url contains a tabIdentifier in it, it will go to that page
                guard let tabIdentifier = url.tabIdentifier else {
                  return
                }
                selectedTab = tabIdentifier
            }
        }
//        .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: handleUserActivity)
        .onAppear {
            
            // to reset (debugging)
//            UserDefaults.standard.set(false, forKey: "connectedToSpotify")
//            UserDefaults.standard.set(true, forKey: "hasConnectedCoasters")
//            UserDefaults.standard.set(false, forKey: "hasAccount")
            
            // fetches the defaults based on user account
            hasAccount = UserDefaults.standard.bool(forKey: "hasAccount")
            hasConnectedCoasters = UserDefaults.standard.bool(forKey: "hasConnectedCoasters")
            connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
            
        }
    
    }
}

