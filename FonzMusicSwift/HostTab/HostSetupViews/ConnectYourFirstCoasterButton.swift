//
//  ConnectYourFirstCoasterButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/24/21.
//

import SwiftUI
//import Firebase
import FirebaseAnalytics

struct ConnectYourFirstCoasterButton: View {
// ---------------------------------- created in view -----------------------------------------------

    @Binding var pressedButtonToLaunchNfc : Bool
//
//    @Binding var showHomeButtons: Bool
    
//    @Binding var connectedToSpotify : Bool
    // object that contains hasAccount, connectedToSpotify, & hasConnectedCoasters
    @StateObject var userAttributes : CoreUserAttributes
   
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        VStack{
            Button(action: {
                
            
                withAnimation {
//                    connectedToSpotify = false
                    pressedButtonToLaunchNfc = true
    //                selectedTab = 1
                }
                FirebaseAnalytics.Analytics.logEvent("userTappedConnectFirstCoaster", parameters: ["user":"user", "tab":"host"])
                
            }, label: {
                Image("coasterIcon").resizable().frame(width: sideGraphicHeight * 1.2, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .frame(width: 150, height: 150)
            })
            .buttonStyle(CircleButtonGradiant(bgColorTopLeft: .lilac, bgColorBottomRight: Color.lilacDark, secondaryColor: .white))
            .disabled(!userAttributes.getConnectedToSpotify())
            Text("connect your first coaster")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzParagraphOne()
                
        }
    }
}
