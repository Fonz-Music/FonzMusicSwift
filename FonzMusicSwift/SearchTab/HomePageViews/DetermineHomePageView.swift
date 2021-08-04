//
//  DetermineHomePageView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//

import SwiftUI

struct DetermineHomePageView: View {

// ------------------------------ inherited from parent ------------------------------------------
    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
    
    @Binding var showHomeButtons : Bool
    
    @Binding var pressedButtonToLaunchNfc : Bool
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    var body: some View {
        
        if !userAttributes.getHasConnectedCoasters() {
            VStack{
                Spacer()
                    .frame(height: 30)
                HStack() {
                    Spacer()
                    if !userAttributes.getConnectedToSpotify(){
                        ConnectSpotifyHomeButton(userAttributes: userAttributes)
                        Spacer()
                    }
                    if !userAttributes.getHasConnectedCoasters() {
                        BuyACoasterHomeButton()
                    }
                    
                    Spacer()
                }
//                HostAPartyButton(selectedTab: $selectedTab, showHomeButtons: $showHomeButtons, hasAccount: $hasAccount)
                Spacer()
                    .frame(height: 50)
                JoinAPartyButton(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, showHomeButtons: $showHomeButtons)
                Spacer()
            }
        }
        else {
            Spacer()
                .frame(maxHeight: 130)
            JoinAPartyButton(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, showHomeButtons: $showHomeButtons)
            Spacer()
        }
        
    }
}
