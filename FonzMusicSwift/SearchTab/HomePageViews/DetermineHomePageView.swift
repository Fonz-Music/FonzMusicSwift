//
//  DetermineHomePageView.swift
//  FonzMusicSwift
//
//  Created by didi on 6/30/21.
//

import SwiftUI

struct DetermineHomePageView: View {
    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
    // determines if current user has an account
//    @Binding var hasAccount : Bool
    
    @Binding var showHomeButtons : Bool
    
    @Binding var pressedButtonToLaunchNfc : Bool
    
//    @Binding var hasConnectedCoasters : Bool
//
//    @Binding var connectedToSpotify : Bool
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
    
    var body: some View {
        
        if !userAttributes.getHasConnectedCoasters() {
            VStack{
                Spacer()
                    .frame(height: 30)
                HStack() {
                    Spacer()
                    if !userAttributes.getHasConnectedCoasters(){
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
                .frame(height: 150)
            JoinAPartyButton(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, showHomeButtons: $showHomeButtons)
        }
        
    }
}
