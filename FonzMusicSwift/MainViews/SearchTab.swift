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
                
                HomePageDecision(hostCoaster: hostCoaster, hasHostVar: $hasHost, selectedTab: $selectedTab, hasAccount: $hasAccount, hasConnectedCoasters: $hasConnectedCoasters, connectedToSpotify: $connectedToSpotify, hasHost: $hasHost)
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
                    CreateAccountPrompt(hasAccount: $hasAccount, showModal: $throwCreateAccount)
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
            
            if (UIApplication.isFirstLaunch()) {
                print("first launch")
                throwFirstLaunchAlert = true
            }
            
            #endif
            
//            UserDefaults.standard.set("", forKey: "uidFromTapping")
            
            
            
            
        }
        .onOpenURL { url in
//            let dividedUrl = url.absoluteString.split(separator: "/")
//            let lastSection = dividedUrl[dividedUrl.count - 1]
//
//            print(lastSection)
            
            let containsSpotify = url.absoluteString.contains("spotify")
            if containsSpotify {
                let sessionId = UserDefaults.standard.string(forKey: "userAccountSessionId")
                let spotifySignInResp = SpotifySignInApi().addSpotifyToAccount(sessionId: sessionId ?? "")
                DispatchQueue.main.async {
                    
                
                    print("has spot status \(spotifySignInResp.status)")
                    if spotifySignInResp.status == 200 {
                        print("changing connection now")
                        withAnimation {
                            connectedToSpotify = true
                        }
                        
                        UserDefaults.standard.set(true, forKey: "connectedToSpotify")
                    }
                }
   
            }
            
            
            
//            let coasterUid = url.checksCoaster
//            print("coaster uid is \(String(describing: coasterUid))")
        }
    }
}
