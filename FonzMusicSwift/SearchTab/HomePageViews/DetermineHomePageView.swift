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
        
//        if !userAttributes.getHasConnectedCoasters() {
            VStack{
                Spacer()
                    .frame(height: 10)
                // if the user does NOT have coasters NOT Spotify NOT account
                if !userAttributes.getHasConnectedCoasters() && !userAttributes.getConnectedToSpotify() {
                    BuyACoasterHomeButton()
                }
                HStack() {
                    Spacer()
                    if !userAttributes.getConnectedToSpotify(){
                        ConnectSpotifyHomeButton(userAttributes: userAttributes)
//                        Spacer()
                    }
                    else if (userAttributes.getConnectedToSpotify() && !userAttributes.getHasAccount()) {
                        CreateAccountHomeButton(userAttributes: userAttributes)
//                        Spacer()
                    }
                    else {
                        #if APPCLIP
                        GetFullAppButton(userAttributes: userAttributes)
                        #else
                        if !userAttributes.getHasConnectedCoasters() {
                            BuyACoasterHomeButton()
                        }
                        #endif
                    }
                    // if no coasters
                    if !userAttributes.getHasConnectedCoasters() {
                        Spacer()
                        SetupACoasterButton(userAttributes: userAttributes, showHomeButtons: $showHomeButtons, pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc)
                        Spacer()
//                        BuyACoasterHomeButton()
                    }
                    
                    
                    
                }
                if userAttributes.getHasAccount() && userAttributes.getConnectedToSpotify() && userAttributes.getHasConnectedCoasters() {
                    #if !APPCLIP
                    Spacer()
                        .frame(maxHeight: 130)
                    #else
                    Spacer()
                        .frame(height: 50)
                    #endif
                }
                else if !userAttributes.getHasConnectedCoasters() || !userAttributes.getConnectedToSpotify() {
                    Spacer()
                        .frame(height: 50)
                }
                else {
                    Spacer()
                        .frame(height: 20)
                }
                
                JoinAPartyButton(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, showHomeButtons: $showHomeButtons)
                Spacer()
            }
//        }
//        else {
//            Spacer()
//                .frame(maxHeight: 130)
//            JoinAPartyButton(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, showHomeButtons: $showHomeButtons)
//            Spacer()
//        }
        
    }
}
