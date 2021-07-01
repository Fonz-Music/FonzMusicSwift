//
//  SearchTab.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//

import SwiftUI

struct SearchTab: View {
    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
    
    @Binding var connectedToSpotify : Bool
    
    
    // determines if current user has an account
    @Binding var hasAccount : Bool
    
    @Binding var hasConnectedCoasters : Bool
    
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
            
            
            if hasHost {
                SearchBarPage(hostCoaster: hostCoaster, hasHostVar: $hasHost, hasAccount: $hasAccount, connectedToSpotify: $connectedToSpotify)
                    
            }
            else {
                ZStack {
                    HomePageDecision(hostCoaster: hostCoaster, hasHostVar: $hasHost, selectedTab: $selectedTab, hasAccount: $hasAccount, hasConnectedCoasters: $hasConnectedCoasters)
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
                }
                .sheet(isPresented: $throwCreateAccount, content: {
                    CreateAccountPrompt()
                })
                
                   
            }
        }
        .background(
            ZStack{
               
                Color(UIColor(colorScheme == .light ? Color.white: Color.darkBackground))
               
                Image("mountainProfile")
                    .opacity(0.4)
                    .frame(maxWidth: UIScreen.screenWidth)
            }, alignment: .bottom)
        .ignoresSafeArea()
        .onAppear {
            
            if (UIApplication.isFirstLaunch()) {
                print("first launch")
                throwFirstLaunchAlert = true
            }
        }
        .onOpenURL { url in
            let dividedUrl = url.absoluteString.split(separator: "/")
            let lastSection = dividedUrl[dividedUrl.count - 1]
            
            print(lastSection)
            
            if (lastSection.count == 14) {
                print("is uid")
                
                let coasterDetails = GuestApi().getCoasterInfo(coasterUid: String(lastSection))
                DispatchQueue.main.async {
                    if (coasterDetails.statusCode == 200 || coasterDetails.coasterName != "") {
                        
//                        self.uid = uidFromCoaster
                        // sets vars to return to user
                        self.hasHost = true
                        self.hostCoaster.coasterName = coasterDetails.coasterName
                        self.hostCoaster.hostName = coasterDetails.displayName
                        self.hostCoaster.sessionId = coasterDetails.sessionId
                        self.hostCoaster.uid = String(lastSection)
                        
                    }
                    else if (coasterDetails.statusCode == 204) {
                        // tell user this coaster doesn't have a host, you wanna connect to it?
                    }
                }
                
            }
            
            let coasterUid = url.checksCoaster
            print("coaster uid is \(String(describing: coasterUid))")
        }
    }
}
