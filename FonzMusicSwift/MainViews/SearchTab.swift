//
//  SearchTab.swift
//  FonzMusicSwift
//
//  Created by didi on 6/15/21.
//

import SwiftUI

struct SearchTab: View {
    // inherited that indicated the tab the app is on
    @Binding var selectedTab: Int
    
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
    }
}
