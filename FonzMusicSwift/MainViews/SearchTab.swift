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
    @State var hostCoaster = HostCoasterInfo()
    // tells app there is no host
    @State var hasHost = false
    
    // tells app there is no host
    @State var throwFirstLaunchAlert = false
    // tells app there is no host
    @State var throwCreateAccount = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            // if the user is connected to a host's party
            if hasHost {
                SearchBarPage(hostCoaster: hostCoaster, hasHostVar: $hasHost, userAttributes: userAttributes)
                    
            }
            // otherwise show decision page
            else {
                
                HomePageDecision(hostCoaster: hostCoaster, hasHostVar: $hasHost, selectedTab: $selectedTab, userAttributes: userAttributes, hasHost: $hasHost, coastersConnectedToUser: coastersConnectedToUser)
                    // if first time user, ask if they need to create a new account
                    .actionSheet(isPresented: $throwFirstLaunchAlert) {
                        ActionSheet(
                            title: Text("have you used the Fonz Music App before?"),
                            buttons: [
                                .default(Text("yes")) {
                                    throwCreateAccount = true
                                },
                                .default(Text("no").foregroundColor(Color.lilac)) {
                                  
                                },
                            ]
                        )
                    }
                .sheet(isPresented: $throwCreateAccount, content: {
                    CreateAccountPrompt(userAttributes: userAttributes, showModal: $throwCreateAccount, hadPreviousAccount: true)
                })
                
                   
            }
        }
        
        .background(
            ZStack{
                Color(UIColor(colorScheme == .light ? Color.white: Color.darkBackground))
                VStack{
                    Spacer()
                    Image("mountainProfile")
                        .opacity(0.4)
                        .frame(maxWidth: UIScreen.screenWidth)
                }
               
            }, alignment: .bottom)
        .ignoresSafeArea()
        .onAppear {
            #if !APPCLIP
            // checks if first time launching app
            if (UIApplication.isFirstLaunch()) {
                print("first launch")
                throwFirstLaunchAlert = true
            }
            #endif
        }
    }
}
