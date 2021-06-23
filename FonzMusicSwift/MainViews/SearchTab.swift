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
    
    // tells app there is no host
    @State var hasHost = false
    // hostCoaster details passed in and will update view when changed
    @State var hostCoaster = HostCoasterInfo()
    
   
    
    var body: some View {
        VStack {
            
            
            if hasHost {
                SearchBar(hostCoaster: hostCoaster, hasHostVar: $hasHost)
                    
            }
            else {
                HomePageDecision(hostCoaster: hostCoaster, hasHostVar: $hasHost, selectedTab: $selectedTab)
                   
            }
        }
        .background(
            Image("mountainProfile")
                .opacity(0.5)
                .frame(maxWidth: UIScreen.screenWidth), alignment: .bottom)
        .ignoresSafeArea()
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
