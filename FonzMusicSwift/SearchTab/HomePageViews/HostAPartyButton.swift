//
//  HostAPartyButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI

struct HostAPartyButton: View {

    // inherited that indicated the tab the app is on
    @Binding var selectedTab: TabIdentifier
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = TabIdentifier.host
            }
            
        }, label: {
            Image("coasterIconAmber").resizable().frame(width: sideGraphicHeight * 1.1, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .frame(width: 125, height: 125)
        })
        .buttonStyle(NeumorphicButtonStyleCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
        Text("i want to setup my coaster").foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white).fonzParagraphTwo()
    }
    
}
