//
//  ContentView.swift
//  FonzMusicSwift
//
//  Created by didi on 4/24/21.
//

import SwiftUI
//
//class UpdateMainPageView: ObservableObject {
//    @Published var updatePage = false
//}

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
            // checks version & forces user to update if it's outdated
            if needsToUpdate {
                MustUpdateApp()
            }
            else {
                TabView(selection: $selectedTab) {
                    HostTab(connectedToSpotify: $connectedToSpotify, hasConnectedCoasters: $hasConnectedCoasters, hasAccount: $hasAccount).tabItem {
                        Label("host", systemImage: "hifispeaker")
                    }.tag(TabIdentifier.host)
                    SearchTab(selectedTab: $selectedTab,connectedToSpotify: $connectedToSpotify, hasAccount: $hasAccount, hasConnectedCoasters: $hasConnectedCoasters).tabItem {
                        Label("queue", systemImage: "plus.magnifyingglass")
                    }.tag(TabIdentifier.search)
                    SettingsPage(hasAccount: $hasAccount, hasConnectedCoasters: $hasConnectedCoasters, connectedToSpotify: $connectedToSpotify).tabItem {
                        Label("account", systemImage: "gearshape")
                    }.tag(TabIdentifier.account)
                }.accentColor(.amber)
                .onAppear {
                    // fetches the min app version from apu
                    let minVersionNumber = GetVersionApi().getMinVersion(device: "iOS")
                    print("version is \(minVersionNumber)" )
//                    let minVersionNumber = "1.00"
                    // sets bool based on comparing the current version from min version
                    needsToUpdate = determineViewBasedOnVersion(currentVersion: UIApplication.appVersion!, minVersion: minVersionNumber)
                }
                
            }
        }.onAppear {
            
            // to reset (debugging)
//            UserDefaults.standard.set(false, forKey: "connectedToSpotify")
//            UserDefaults.standard.set(true, forKey: "hasConnectedCoasters")
//            UserDefaults.standard.set(false, forKey: "hasAccount")
            
            // fetches the defaults based on user account
            hasAccount = UserDefaults.standard.bool(forKey: "hasAccount")
            hasConnectedCoasters = UserDefaults.standard.bool(forKey: "hasConnectedCoasters")
            connectedToSpotify = UserDefaults.standard.bool(forKey: "connectedToSpotify")
            
//            hasAccount = true
//            hasConnectedCoasters = true
//            connectedToSpotify = true
            
            
        }
//        .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform:
//            handleUserActivity
//        )
        
       
    }
    
    func determineViewBasedOnVersion(currentVersion:String, minVersion:String) -> Bool {
        // puts version into 2 substrings
        let currentVersionParts = currentVersion.split(separator: ".")
        // gets first part & puts it in hundreds column
        let currentVersionFirst = Int(currentVersionParts[0])! * 100
        // adds parts together to get one number
        let currentVersionNumber = currentVersionFirst + Int(currentVersionParts[1])!
        print("current version \(currentVersionNumber)")

        // puts version into 2 substrings
        let minVersionParts = minVersion.split(separator: ".")
        // gets first part & puts it in hundreds column
        let minVersionFirst = Int(minVersionParts[0])! * 100
        // adds parts together to get one number
        let minVersionNumber = minVersionFirst + Int(minVersionParts[1])!
        print("min version \(minVersionNumber)")
        
        if minVersionNumber > currentVersionNumber {
            return true
        }
        else {return false }
        
        
    }
    
}
//
//func handleUserActivity(_ userActivity: NSUserActivity) {
//    print("handling user act")
//    print("user activity: \(userActivity.webpageURL)")
//    guard let incomingUrl = userActivity.webpageURL
//          else {
//        return
//    }
//    let dividedUrl = incomingUrl.absoluteString.split(separator: "/")
//    let lastSection = dividedUrl[dividedUrl.count - 1]
//
//    print(lastSection)
//    if (lastSection.count == 14) {
//        UserDefaults.standard.set(String(lastSection), forKey: "uidFromTapping")
//    }
////    UserDefaults.standard.set("", forKey: "uidFromTapping")
//    print("incoming url is \(incomingUrl)")
//}

//
//.onOpenURL { url in
//    // if the url contains a tabIdentifier in it, it will go to that page
//    guard let tabIdentifier = url.tabIdentifier else {
//      return
//    }
//    selectedTab = tabIdentifier
//}
