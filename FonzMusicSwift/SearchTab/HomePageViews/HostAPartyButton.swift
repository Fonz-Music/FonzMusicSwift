//
//  HostAPartyButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI
import Firebase

struct HostAPartyButton: View {

    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
    
    @Binding var showHomeButtons: Bool
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        Button(action: {
            withAnimation {
                showHomeButtons = false
            }
            FirebaseAnalytics.Analytics.logEvent("userTappedSetupCoaster", parameters: ["user":"user", "tab":"search"])
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                withAnimation {
                    selectedTab = TabIdentifier.host
                    showHomeButtons = true
                }
            }
            
            
        }, label: {
            Image("coasterIconLilac").resizable().frame(width: sideGraphicHeight * 1.1, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .frame(width: 125, height: 125)
        })
        .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
//        .buttonStyle(NeumorphicButtonStyleCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .lilac))
        Text("i want to setup my coaster").foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphTwo()
    }
    
}
