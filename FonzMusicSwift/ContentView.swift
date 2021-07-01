//
//  ContentView.swift
//  FonzMusicSwift
//
//  Created by didi on 4/24/21.
//

import SwiftUI

class UpdateMainPageView: ObservableObject {
    @Published var updatePage = false
}

enum TabIdentifier: Hashable {
  case host, search, settings
}

struct ContentView: View {
    
    @State var selectedTab = TabIdentifier.search
    @State var connectedToSpotify = false
    @State var hasConnectedCoasters = false
    @State var needsToUpdate = false
    @State var hasAccount = true

    // main app
    var body: some View {
        
        
        if needsToUpdate {
            MustUpdateApp()
        }
        else {
            TabView(selection: $selectedTab) {
                HostTab(connectedToSpotify: $connectedToSpotify, hasConnectedCoasters: $hasConnectedCoasters, hasAccount: $hasAccount).tabItem {
                    Label("host", systemImage: "homepod")
                }.tag(TabIdentifier.host)
                SearchTab(selectedTab: $selectedTab,connectedToSpotify: $connectedToSpotify, hasAccount: $hasAccount, hasConnectedCoasters: $hasConnectedCoasters).tabItem {
                    Label("search", systemImage: "magnifyingglass")
                }.tag(TabIdentifier.search)
                SettingsPage(hasAccount: $hasAccount, hasConnectedCoasters: $hasConnectedCoasters).tabItem {
                    Label("settings", systemImage: "gear")
                }.tag(TabIdentifier.settings)
            }.accentColor(.amber)
            .onAppear {
//                let minVersionNumber = GetVersionApi().getMinVersion(device: "iOS")
//                print("version is \(versionNumber)" )
                let minVersionNumber = "1.00"
                print(UIApplication.appVersion)
                needsToUpdate = determineViewBasedOnVersion(currentVersion: UIApplication.appVersion!, minVersion: minVersionNumber)
            }
            .onOpenURL { url in
                guard let tabIdentifier = url.tabIdentifier else {
                  return
                }
                selectedTab = tabIdentifier
            }
        }
       
    }
    
    func determineViewBasedOnVersion(currentVersion:String, minVersion:String) -> Bool {
//        let currentVersion
//
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

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
extension UIImage {
    static func searchSymbol(scale: SymbolScale) -> UIImage {
        let config = UIImage.SymbolConfiguration(scale: scale)
        return (UIImage(named: "searchIcon")!.withConfiguration(config).withRenderingMode(.alwaysTemplate))
    }
}

extension UIApplication {
       class func isFirstLaunch() -> Bool {
           if !UserDefaults.standard.bool(forKey: "hasBeenLaunchedBeforeFlag") {
               UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBeforeFlag")
               UserDefaults.standard.synchronize()
               return true
           }
           return false
       }
   }

