//
//  JoinAPartyButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/16/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics


struct JoinAPartyButton: View {
// ---------------------------------- created in view -----------------------------------------------

    @Binding var pressedButtonToLaunchNfc : Bool
    
    @Binding var showHomeButtons: Bool
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.05
    
   
    
    var body: some View {
        
        
        
        Button(action: {
            withAnimation {
                showHomeButtons = false
                pressedButtonToLaunchNfc = true
            }
            FirebaseAnalytics.Analytics.logEvent("guestTappedJoinParty", parameters: ["user":"guest", "tab":"search"])
        }, label: {
            
       
            Image("plusIconAmber").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .frame(width: 125, height: 125)

        })
        .buttonStyle(BasicFonzButtonCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
//        .buttonStyle(NeumorphicButtonStyleCircle(bgColor: colorScheme == .light ? Color.white: Color.darkButton, secondaryColor: .amber))
        Text("i want to queue a song")
            .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
            .fonzParagraphTwo()
            
    }
    
}
