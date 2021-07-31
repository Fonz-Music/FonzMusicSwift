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
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes = CoreUserAttributes()
    // bool on whether the user needs to update their app
    @State var needsToUpdate = false
    // object that stores the songs from the api
    @ObservedObject var coastersConnectedToHost: CoastersFromApi = CoastersFromApi()

    // main app
    var body: some View {
        
    ZStack{
        SearchTab(selectedTab: $selectedTab, userAttributes: userAttributes, coastersConnectedToUser: coastersConnectedToHost)
            .onOpenURL { url in
                // if the url contains a tabIdentifier in it, it will go to that page
                guard let tabIdentifier = url.tabIdentifier else {
                  return
                }
                selectedTab = tabIdentifier
            }
        }  
    }
}

