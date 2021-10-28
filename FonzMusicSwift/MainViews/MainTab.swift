//
//  SearchTab.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//

import SwiftUI

struct SearchTab: View {

// ------------------------------ inherited from parent ------------------------------------------
    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    // list of coasters connected to the Host
    @ObservedObject var coastersConnectedToUser: CoastersFromApi
// ------------------------------ created in view ------------------------------------------------
    // hostCoaster details passed in and will update view when changed
    @StateObject var hostCoaster = HostCoasterInfo()
    // tells app there is no host
    @State var hasHost = false
    
    
    
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
//            PavRoute(hasHostVar: $hasHost)
            // if the user is connected to a host's party
            if hasHost {
                if hostCoaster.group == "pav" {
                    PavRoute(hostCoaster: hostCoaster, hasHostVar: $hasHost, userAttributes: userAttributes)
                        
                }
                else {
                    SearchBarPage(hostCoaster: hostCoaster, hasHostVar: $hasHost, userAttributes: userAttributes)
                }


            }
            // otherwise show decision page
            else {

                HomePageDecision(hostCoaster: hostCoaster, hasHostVar: $hasHost, selectedTab: $selectedTab, userAttributes: userAttributes, hasHost: $hasHost, coastersConnectedToUser: coastersConnectedToUser)
                    // if first time user, ask if they need to create a new account
            }
        }
        
        .background(
            ZStack{
                Color(UIColor(colorScheme == .light ? Color.white: Color.darkBackground))
                VStack{
                    Spacer()
//                    Image("mountainProfile")
//                        .opacity(0.4)
//                        .frame(maxWidth: UIScreen.screenWidth)
                }
               
            }, alignment: .bottom)
        .ignoresSafeArea()
//        .onAppear {
//            #if !APPCLIP
//            // checks if first time launching app
//            if (UIApplication.isFirstLaunch()) {
//                print("first launch")
//                throwFirstLaunchAlert = true
//            }
//            #endif
//        }
    }
}
