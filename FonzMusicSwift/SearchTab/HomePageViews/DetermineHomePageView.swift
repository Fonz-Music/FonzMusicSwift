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
    @Binding var hasAccount : Bool
    
    @Binding var showHomeButtons : Bool
    
    @Binding var pressedButtonToLaunchNfc : Bool
    
    @Binding var hasConnectedCoasters : Bool
    
    var body: some View {
        
        if !hasConnectedCoasters {
            VStack{
                Spacer()
                    .frame(height: 100)
                HostAPartyButton(selectedTab: $selectedTab, showHomeButtons: $showHomeButtons, hasAccount: $hasAccount)
                Spacer()
                    .frame(height: 100)
                JoinAPartyButton(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, showHomeButtons: $showHomeButtons)
            }
        }
        else {
            Spacer()
                .frame(height: 150)
            JoinAPartyButton(pressedButtonToLaunchNfc: $pressedButtonToLaunchNfc, showHomeButtons: $showHomeButtons)
        }
        
    }
}
