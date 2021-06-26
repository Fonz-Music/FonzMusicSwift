//
//  ConnectYourFirstCoasterButton.swift
//  FonzMusicSwift
//
//  Created by didi on 6/24/21.
//

import SwiftUI

struct ConnectYourFirstCoasterButton: View {
// ---------------------------------- created in view -----------------------------------------------

    @Binding var pressedButtonToLaunchNfc : Bool
//
//    @Binding var showHomeButtons: Bool
    
    @Binding var connectedToSpotify : Bool
    
   
    
    @Environment(\.colorScheme) var colorScheme
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        VStack{
            Button(action: {
                
            
                withAnimation {
                    
                    pressedButtonToLaunchNfc = true
    //                selectedTab = 1
                }
         
                
            }, label: {
                Image("coasterIcon").resizable().frame(width: sideGraphicHeight * 1.2, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .frame(width: 125, height: 125)
            })
            .buttonStyle(CircleButtonGradiant(bgColorTopLeft: .lilac, bgColorBottomRight: Color.lilacDark, secondaryColor: .white))
            .disabled(!connectedToSpotify)
            Text("connect your first coaster")
                .foregroundColor(colorScheme == .light ? Color.darkBackground: Color.white)
                .fonzParagraphTwo()
                
        }
    }
}
